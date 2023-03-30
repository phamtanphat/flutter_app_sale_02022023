import 'package:flutter_app_sale_02022023/common/bases/base_bloc.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';
import 'package:flutter_app_sale_02022023/data/datasources/local/cache/app_sharepreference.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/authentication_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_in/bloc/sign_in_event.dart';

class SignInBloc extends BaseBloc {
  AuthenticationRepository? _authenticationRepository;

  void setAuthenticationRepo(AuthenticationRepository repository) {
    _authenticationRepository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        executeSignIn(event as SignInEvent);
        break;
    }
  }

  void executeSignIn(SignInEvent event) {
    loadingSink.add(true);
    _authenticationRepository
        ?.signIn(email: event.email, password: event.password)
        .then((userDto) {
          AppSharePreference.setString(
              key: AppConstant.TOKEN_KEY,
              value: userDto.token ?? ""
          );
          messageSink.add("Login success");
          progressSink.add(SignInSuccessEvent());
        })
        .catchError((e) {
          messageSink.add(e.toString());
        })
        .whenComplete(() => loadingSink.add(false));
  }
}