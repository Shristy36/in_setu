part of 'signin_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class DoLogin extends SignInEvent{
  final String userName;
  final String userPassword;

  DoLogin({required this.userName, required this.userPassword});
}
