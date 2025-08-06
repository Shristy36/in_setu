import 'package:flutter/material.dart';
import 'package:in_setu/commonWidget/custom_text_field.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/supports/utility.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.colorWhite,
      body: Column(
        children: [
          SizedBox(height: 20),
          Utility.getCustomToolbar("", AppColors.colorWhite, context),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Align(
                        alignment: Alignment.center,
                        child: Utility.subTitle(loginTitle, AppColors.primary,),
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
                        padding: const EdgeInsets.only(left: 20.0,right: 20, top: 20),
                        child: CustomTextField(
                          validationValue: phoneValidation,
                          controller: email,
                          labelText: hintPhone,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: Utility.getButtonDesign(sendResetBtn),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
