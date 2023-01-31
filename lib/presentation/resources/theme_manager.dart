import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/presentation/resources/resources.dart';

MaterialColor createMaterialColor(Color color) {
  var strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

var orientation = ScreenUtil().orientation;

ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,

    // platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: createMaterialColor(AppColor.primary),
      primaryColorDark: AppColor.darkPrimary,
      accentColor: AppColor.secondary,
      errorColor: AppColor.red,
      cardColor: AppColor.white,
      backgroundColor: AppColor.white,
    ),

    disabledColor: AppColor.grey1,
    splashColor: AppColor.lightPrimary,
    scaffoldBackgroundColor: AppColor.white,

    // ProgressIndicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColor.secondary),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      toolbarHeight: ScreenUtil().screenHeight *
          (ScreenUtil().orientation == Orientation.portrait ? .09 : .14),
      iconTheme: IconThemeData(size: AppSize.s20.w),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColor.lightPrimary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      backgroundColor: AppColor.primary,
      shadowColor: AppColor.lightPrimary,
      elevation: 0,
      titleTextStyle: getSemiBoldTextStyle(fontSize: FontSize.s16, color: AppColor.white),
    ),

    dialogTheme: const DialogTheme(
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
    ),
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical:
                ScreenUtil().orientation == Orientation.portrait ? AppSize.s12.h : AppSize.s24.h),
        minimumSize: Size(double.infinity, AppSize.s24.h),
        textStyle: getRegularTextStyle(color: AppColor.white, fontSize: FontSize.s18),
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12.w)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.primary,
        textStyle: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s14),
      ),
    ),

    //Text Theme
    textTheme: TextTheme(
      displayLarge: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s58),
      displayMedium: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s46),
      displaySmall: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s36),
      headlineLarge: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s32),
      headlineMedium: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s28),
      headlineSmall: getRegularTextStyle(color: AppColor.primary, fontSize: FontSize.s24),
      titleLarge: getRegularTextStyle(color: AppColor.darkPrimary, fontSize: FontSize.s22),
      titleMedium: getMediumTextStyle(color: AppColor.darkPrimary, fontSize: FontSize.s16),
      titleSmall: getMediumTextStyle(color: AppColor.darkPrimary, fontSize: FontSize.s14),
      labelLarge: getMediumTextStyle(color: AppColor.secondary, fontSize: FontSize.s14),
      labelMedium: getMediumTextStyle(color: AppColor.darkPrimary, fontSize: FontSize.s12),
      labelSmall: getMediumTextStyle(color: AppColor.grey, fontSize: FontSize.s11),
      bodyLarge: getMediumTextStyle(color: AppColor.primary, fontSize: FontSize.s16),
      bodyMedium: getRegularTextStyle(color: AppColor.darkPrimary, fontSize: FontSize.s14),
      bodySmall: getRegularTextStyle(color: AppColor.grey2, fontSize: FontSize.s12),
    ),

    // Form Field Theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.all(AppSize.s12.w),
      // hint style
      hintStyle: getRegularTextStyle(color: AppColor.grey, fontSize: FontSize.s14),
      // label style
      labelStyle: getMediumTextStyle(color: AppColor.grey, fontSize: FontSize.s14),
      // error style
      errorStyle: getRegularTextStyle(color: AppColor.red),
      // enabled border
      enabledBorder: _getOutlineInputBorder(color: AppColor.grey),
      // focused border
      focusedBorder: _getOutlineInputBorder(color: AppColor.secondary),
      // error border
      errorBorder: _getOutlineInputBorder(color: AppColor.red),
      // focused error border
      focusedErrorBorder: _getOutlineInputBorder(color: AppColor.primary),
    ),
  );
}

OutlineInputBorder _getOutlineInputBorder({required Color color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: AppSize.s1.w),
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.w)),
  );
}
