import 'package:flutter_app_sale_02022023/common/bases/base_bloc.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/authentication_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_in/bloc/sign_in_event.dart';

class SignInBloc extends BaseBloc {
  AuthenticationRepository? _authenticationRepository;

  void updateAuthenticationRepo(AuthenticationRepository repository) {
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
        .then((_) {
          progressSink.add(SignInSuccessEvent());
        })
        .catchError((e) {
          messageSink.add(e.toString());
        })
        .whenComplete(() => loadingSink.add(false));
  }

}