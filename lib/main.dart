import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopbiz_app/admin/screens/main/admin_dashboard_screen.dart';
import 'package:shopbiz_app/admin/screens/products/add_product.dart';
import 'package:shopbiz_app/admin/screens/products/delete_product.dart';
import 'package:shopbiz_app/admin/screens/products/update_product.dart';
import 'package:shopbiz_app/admin/screens/products/view_all_product.dart';
import 'package:shopbiz_app/admin/screens/users/view_all_users.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/screens/authentication/forget_password_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/log_in_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/sign_up_screen.dart';
import 'package:shopbiz_app/ui/screens/users/privacy_policy/privacy_policy_screen.dart';
import 'package:shopbiz_app/ui/screens/users/profile_screen.dart';
import 'package:shopbiz_app/ui/screens/users/review/review_screen.dart';
import 'package:shopbiz_app/ui/screens/users/terms_conditions/terms_screen.dart';

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
        routes: {
          '/dashboard': (context) => const AdminDashboardScreen(),
          '/users': (context) => const ViewAllUsersScreen(),
          '/login': (context) => const LogInScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/forget-password': (context) => ForgetPasswordScreen(),
          '/add-product': (context) => const AddProductScreen(),
          '/update-product': (context) => const UpdateProductScreen(),
          '/delete-product': (context) => const DeleteProductScreen(),
          '/view-products': (context) => const ViewAllProductScreen(),
          '/privacy-policy': (context) => const PrivacyPolicyScreen(),
          '/terms-condition': (context) => const TermsConditionsScreen(),
          '/profile-screen': (context) => const ProfileScreen(),
          '/review-screen': (context) => const ReviewScreen(),
          '/admin': (context) => const AdminDashboardScreen(),
        },
        home: const LogInScreen());
  }
}
