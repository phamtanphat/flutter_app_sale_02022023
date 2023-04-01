import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';

class SignUpEvent extends BaseEvent {
  String email, password, phone, address, name;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [];
}

class SignUpSuccessEvent extends BaseEvent {
  String email, password;

  SignUpSuccessEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}