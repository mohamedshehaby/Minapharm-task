import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/presentation/widgets/loading/loading_Indicator.dart';

import 'package:minapharm_task/presentation/resources/colors_manager.dart';
import 'package:minapharm_task/presentation/resources/values_manager.dart';
import 'package:minapharm_task/presentation/widgets/loading/loading_screen/loading_screen_controller.dart';

class LoadingScreen {
  // Singleton pattern
  // Cause in all the app there's only one Loading Screen
  LoadingScreen._sharedInstance();

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverLay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

// Return LoadingScreenController and build ui
  LoadingScreenController _showOverLay({
    required BuildContext context,
    required String text,
  }) {
    final textStream = StreamController<String>();
    textStream.add(text);

    // Get the Overlay State to control overlays
    final overlayState = Overlay.of(context);

    // Get the size of the current widget
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSize.s10.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSize.s16.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSize.s10.h),
                      const LoadingIndicator(),
                      SizedBox(height: AppSize.s10.h),
                      StreamBuilder(
                        stream: textStream.stream,
                        builder: (context, snapshot) {
                          return (snapshot.hasData)
                              ? Text(
                                  snapshot.data as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: AppColor.primary),
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState?.insert(overlayEntry);

    // This will control the overlay
    return LoadingScreenController(
      close: () {
        textStream.close();
        overlayEntry.remove();
        return true;
      },
      update: (text) {
        textStream.add(text);
        return true;
      },
    );
  }
}
