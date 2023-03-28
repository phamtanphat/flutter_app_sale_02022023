import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_widget.dart';
class SignInPage extends StatefulWidget {

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      providers: [],
      child: Container(),
    );
  }
}
