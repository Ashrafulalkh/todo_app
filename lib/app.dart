import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller_binder.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'package:todo_app/ui/utils/app_colors.dart';


class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      theme: _buildLightTheme(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 5,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(width: 1.5,color: AppColors.themeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(width: 1.5,color: AppColors.themeColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(width: 1.5,color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(width: 1.5,color: Colors.red),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      )
    );
  }
}
