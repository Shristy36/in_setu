import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/custom_text_field.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/screens/login_view/bloc/signin_bloc.dart';
import 'package:in_setu/screens/login_view/forgot_password_screen.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/signup_screen.dart';
import 'package:in_setu/screens/project_list/project_list_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailOrPhoneController = TextEditingController();
  final passwordTxt = TextEditingController();
  final signFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utility.showExitDialog(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.colorWhite,
        body: BlocListener<SigninBloc, GlobalApiResponseState>(
          listener: (context, state) {
            switch (state.status) {
              case GlobalApiStatus.loading:
                LoadingDialog.show(
                  context,
                  key: const ObjectKey("requesting sign in.."),
                );
                break;
              case GlobalApiStatus.completed:
                LoadingDialog.hide(context);
                if (state is SignInSuccessState) {
                  LoadingDialog.hide(context);
                  print("login success");
                  final User user = state.data.user!;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProjectListScreen(user: user),
                    ),
                  );
                }
                break;

              case GlobalApiStatus.error:
                LoadingDialog.hide(context);
                FocusScope.of(context).unfocus();
                ErrorHandler.errorHandle(
                  state.message,
                  "Invalid Auth",
                  context,
                );
                break;

              default:
                LoadingDialog.hide(context);
            }
          },
          child: signInView(),
        ),
      ),
    );
  }

  Widget signInView() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Form(
            key: signFormKey,
            child: Column(
              children: [
                Center(
                   child: Image.asset("assets/images/building.jpg", width: 200, height: 200,),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Utility.title(loginTitle, AppColors.primary),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10,
                    ),
                    child: Utility.smlText(
                      loginDescription,
                      AppColors.colorBlack,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 20,
                  ),
                  child: CustomTextField(
                    validationValue: phoneValidation,
                    controller: emailOrPhoneController,
                    labelText: hintPhone,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 10,
                  ),
                  child: CustomTextField(
                    validationValue: passValidation,
                    controller: passwordTxt,
                    labelText: hintPass,
                    icon: Icons.lock_open_outlined,
                    isPassword: true,
                    isPasswordVisible: _isPasswordVisible,
                    onTogglePasswordVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 10,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      ),
                    },
                    child: Utility.subTitle(forgotPass, AppColors.primary),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (signFormKey.currentState!.validate()) {
                        context.read<SigninBloc>().add(
                          DoLogin(
                            userName: emailOrPhoneController.text,
                            userPassword: passwordTxt.text,
                          ),
                        );
                      }
                    },
                    child: Utility.getButtonDesign(signIn),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utility.smlText(dontAccountTxt, AppColors.colorGray),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap:
                          () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        ),
                      },
                      child: Utility.smlText(
                        registerTxt,
                        AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
