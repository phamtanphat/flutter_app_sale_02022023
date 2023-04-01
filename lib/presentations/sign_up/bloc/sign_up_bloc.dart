import 'package:flutter_app_sale_02022023/common/bases/base_bloc.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/authentication_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/sign_up/bloc/sign_up_event.dart';


class SignUpBloc extends BaseBloc {
  AuthenticationRepository? _authenticationRepository;

  void setAuthenticationRepo(AuthenticationRepository repository) {
    _authenticationRepository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case SignUpEvent:
        _handleSignUp(event as SignUpEvent);
        break;
    }
  }

  void _handleSignUp(SignUpEvent event) async {
    loadingSink.add(true);
    _authenticationRepository
      ?.sigUp(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: event.phone,
          address: event.address)
      .then((userDto) {
          messageSink.add("Congratulation Register success");
          progressSink.add(SignUpSuccessEvent(email: event.email, password: event.password));
      }).catchError((e) {
            messageSink.add(e.toString());
      }).whenComplete(() => loadingSink.add(false));
  }
}
