part of 'signin_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class DoLogin extends SignInEvent{
  final String userName;
  final String userPassword;

  DoLogin({required this.userName, required this.userPassword});
}


class DoUserRegister extends SignInEvent{
  final String userName;
  final String userPassword;
  DoUserRegister({required this.userName, required this.userPassword});
}
class DoSignUpEvent extends SignInEvent{
  final String userName;
  final String userPassword;
  final String otp;
  DoSignUpEvent({required this.userName, required this.userPassword, required this.otp});
}

class DoRequestReset extends SignInEvent{
  final String contactNo;
  DoRequestReset({required this.contactNo});

}