import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:heytheo/pages/home_page/home_page.dart';
import 'package:heytheo/pages/login_page.dart';
import 'package:heytheo/services/authgate.dart';
import 'firebase_options.dart';
import 'theme/app_colors.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const StockApp());
}

class StockApp extends StatelessWidget {
  const StockApp({super.key});

  //used getmaterialapp for navigation and state management
  //screenutil for responsive design
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.scaffold,
            primaryColor: AppColors.primary,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.scaffold,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColors.textPrimary),
              titleTextStyle: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: child,
        );
      },
      child: RootAuthGate(),
    );
  }
}
