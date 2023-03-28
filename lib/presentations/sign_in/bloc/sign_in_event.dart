import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';

class SignInEvent extends BaseEvent {
  String email;
  String password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}

class SignInSuccessEvent extends BaseEvent {

  SignInSuccessEvent();

  @override
  List<Object?> get props => [];
}
