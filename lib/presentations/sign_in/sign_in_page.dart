import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_widget.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';
import 'package:flutter_app_sale_02022023/common/widgets/loading_widget.dart';
import 'package:flutter_app_sale_02022023/common/widgets/progress_listener_widget.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/authentication_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_in/bloc/sign_in_event.dart';
import 'package:flutter_app_sale_02022023/utils/dimension_utils.dart';
import 'package:flutter_app_sale_02022023/utils/message_utils.dart';
import 'package:provider/provider.dart';

import 'bloc/sign_in_bloc.dart';

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
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          update: (_, request, repository) {
            repository ??= AuthenticationRepository();
            repository.setApiRequest(request);
            return repository;
          },
        ),
        ProxyProvider<AuthenticationRepository, SignInBloc>(
          create: (context) => SignInBloc(),
          update: (_, repository, bloc) {
            bloc ??= SignInBloc();
            bloc.setAuthenticationRepo(repository);
            return bloc;
          },
        )
      ],
      child: SignInContainerWidget(),
    );
  }
}

class SignInContainerWidget extends StatefulWidget {
  @override
  State<SignInContainerWidget> createState() => _SignInContainerWidgetState();
}

class _SignInContainerWidgetState extends State<SignInContainerWidget> {
  late SignInBloc _bloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _bloc.messageStream.listen((event) {
        MessageUtils.showMessage(context, "Alert!!", event.toString());
      });
    });
  }

  void onPressSignIn() {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

    if (email.isEmpty || password.isEmpty) return;
    _bloc.executeSignIn(SignInEvent(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LoadingWidget(
        bloc: _bloc,
        child: SafeArea(
            child: Container(
          constraints: const BoxConstraints.expand(),
          child: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                    child: ProgressListenerWidget<SignInBloc>(
                  callback: (event) {
                    print(event.runtimeType);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 2,
                          child:
                              Image.asset("assets/images/ic_food_express.png")),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: DimensionUtils
                                        .paddingHeightDivideNumber(context)),
                                child: _buildEmailTextField(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: DimensionUtils
                                        .paddingHeightDivideNumber(context)),
                                child: _buildPasswordTextField(),
                              ),
                              _buildButtonSignIn(onPressSignIn),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _buildTextSignUp())
                    ],
                  ),
                )),
              ),
            );
          }),
        )),
      ),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account!"),
            InkWell(
              onTap: () async {
                try {
                  var data = await Navigator.pushNamed(context, AppConstant.SIGN_UP_ROUTE) as Map;
                  setState(() {
                    emailController.text = data["email"];
                    passwordController.text = data["password"];
                    MessageUtils.showMessage(context, "Alert!!", data["message"]);
                  });
                } catch (e) {
                  MessageUtils.showMessage(context, "Alert!!", e.toString());
                  return;
                }
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildEmailTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        obscureText: true,
        controller: passwordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn(Function onPress) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[500];
                } else if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.blueAccent;
              }),
              elevation: MaterialStateProperty.all(5),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 100)),
            )),
            child: ElevatedButton(
              child: Text("Login",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () => onPress(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
