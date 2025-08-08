import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/custom_text_field.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/login_view/otp_screen.dart';
import 'package:in_setu/screens/login_view/reset_password_screen.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';

import 'bloc/signin_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailContactTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (state is RequestResetStateSuccess) {
                LoadingDialog.hide(context);
                final resetObj = state.data;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => OtpScreen(
                          userName: emailContactTxt.text,
                          requestResponse: resetObj,
                        ),
                  ),
                );
              }
              break;

            case GlobalApiStatus.error:
              LoadingDialog.hide(context);
              FocusScope.of(context).unfocus();
              ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
              break;

            default:
              LoadingDialog.hide(context);
          }
        },
        child: _buildForgotPasswordForm(),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/building.jpg",
                    width: 200,
                    height: 200,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Utility.subTitle(loginTitle, AppColors.primary),
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
                    controller: emailContactTxt,
                    labelText: hintPhone,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SigninBloc>().add(
                          DoRequestReset(contactNo: emailContactTxt.text),
                        );
                      }
                    },
                    child: Utility.getButtonDesign(sendResetBtn),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
