import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/data/datasources/local/cache/app_sharepreference.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_in/sign_in_page.dart';

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
      initialRoute: "/sign-in",
      routes: {
        "/sign-in" : (context) => SignInPage()
      },
    );
  }
}
