import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/core/routes/app_routes.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyDmvzhrY_pwpzLfEfdnjvijTWYoiVTTO6o",
      //     authDomain: "shopbiz-83a3c.firebaseapp.com",
      //     projectId: "shopbiz-83a3c",
      //     storageBucket: "shopbiz-83a3c.appspot.com",
      //     messagingSenderId: "667766107143",
      //     appId: "1:667766107143:web:eead0037a8565ca1568ea2",
      //     measurementId: "G-WR2GF6EG1L"),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                Breakpoint(start: 1921, end: size.width, name: '4K'),
              ],
            ),
        routes: AppRoutes.routes,
        home: const LogInScreen());
  }
}
