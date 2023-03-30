import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_widget.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/authentication_repository.dart';
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
      child: Container(),
    );
  }
}
