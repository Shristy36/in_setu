import 'package:flutter/material.dart';
import 'package:in_setu/commonWidget/custom_text_field.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/supports/utility.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final resetFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Form(
              key: resetFormKey,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),
                      child: Utility.subTitle(
                        "Reset Password",
                        AppColors.colorBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      top: 10,
                    ),
                    child: CustomTextField(
                      validationValue: "Enter Password",
                      controller: passwordController,
                      labelText: "Enter Password",
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
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      top: 10,
                    ),
                    child: CustomTextField(
                      validationValue: "Enter Confirm Password",
                      controller: confirmPasswordController,
                      labelText: "Confirm Password",
                      icon: Icons.lock_open_outlined,
                      isPassword: true,
                      isPasswordVisible: _isConfirmPasswordVisible,
                      onTogglePasswordVisibility: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      if (resetFormKey.currentState!.validate()) {
                        Utility.showToast("reset password");
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
