import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/core/routes/app_routes.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopbiz',
        theme: ThemeData(
            cardColor: AppColors.kWhiteColor,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: AppColors.kWhiteColor),
                backgroundColor: AppColors.kPrimaryColor,
                titleTextStyle:
                    TextStyle(color: AppColors.kWhiteColor, fontSize: 17.0)),
            scaffoldBackgroundColor: AppColors.kWhiteColor,
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            useMaterial3: true),
        routes: AppRoutes.routes,
        home: const LogInScreen());
  }
  
}
