import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';
import 'package:flutter_app_sale_02022023/data/datasources/local/cache/app_sharepreference.dart';
import 'package:flutter_app_sale_02022023/presentations/home/home_page.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_in/sign_in_page.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_up/sign_up_page.dart';
import 'package:flutter_app_sale_02022023/presentations/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppSharePreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppConstant.SPLASH_ROUTE,
      routes: {
        AppConstant.SIGN_IN_ROUTE : (context) => SignInPage(),
        AppConstant.SIGN_UP_ROUTE : (context) => SignUpPage(),
        AppConstant.HOME_ROUTE : (context) => HomePage(),
        AppConstant.SPLASH_ROUTE : (context) => SplashPage(),
      },
    );
  }
}
