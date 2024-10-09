import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.kWhiteColor,
      primaryColor: AppColors.kPrimaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.kWhiteColor,
        titleTextStyle: TextStyle(
          color: AppColors.kBlackColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.kBlackColor),
      ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
          // bodyText1: TextStyle(color: AppColors.kBlackColor),
          // bodyText2: TextStyle(color: AppColors.kGreyColor),
          ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: AppColors.kPrimaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: AppColors.kWhiteColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.kWhiteColor),
      ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
          // bodyText1: TextStyle(color: AppColors.kWhiteColor),
          // bodyText2: TextStyle(color: AppColors.kGreyColor),
          ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
