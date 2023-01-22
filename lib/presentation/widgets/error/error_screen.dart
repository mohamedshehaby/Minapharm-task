import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:minapharm_task/presentation/resources/strings_manager.dart';
import 'package:minapharm_task/presentation/resources/values_manager.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback retryFunction;

  const ErrorScreen({super.key, required this.message, required this.retryFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(
            height: AppSize.s12.h,
          ),
          ElevatedButton(onPressed: retryFunction, child: const Text(AppStrings.tryAgain))
        ],
      ),
    );
  }
}
