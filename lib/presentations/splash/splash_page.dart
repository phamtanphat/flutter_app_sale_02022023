import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';
import 'package:flutter_app_sale_02022023/data/datasources/local/cache/app_sharepreference.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 2),() {
      String token = AppSharePreference.getString(AppConstant.TOKEN_KEY);
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, AppConstant.HOME_ROUTE);
      } else {
        Navigator.pushReplacementNamed(context, AppConstant.SIGN_IN_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/animations/animation_splash.json',
                animate: true, repeat: true),
            Text("Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white))
          ],
        ));
  }
}