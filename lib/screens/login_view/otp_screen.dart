import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/login_view/bloc/signin_bloc.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/model/register_model/RegisterResponse.dart'
    hide User;
import 'package:in_setu/screens/login_view/model/register_model/ResetRequestResponse.dart';
import 'package:in_setu/screens/login_view/model/register_model/SignUpResponse.dart';
import 'package:in_setu/screens/login_view/reset_password_screen.dart';
import 'package:in_setu/screens/project_list/project_list_screen.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';

class OtpScreen extends StatefulWidget {
  final SignUpResponse? signUpObj;
  final String userName;
  final String? password;
  final ResetRequestResponse? requestResponse;

  const OtpScreen({
    super.key,
    this.signUpObj,
    required this.userName,
    this.password,
    this.requestResponse,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpFormKey = GlobalKey<FormState>();
  String otp = '';
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final int otpLength;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String getOtp() => _controllers.map((c) => c.text).join();

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (getOtp().length == otpLength) {
      debugPrint("OTP Entered: ${getOtp()}");
    }
  }

  Widget _otpBox(int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) => _onChanged(value, index),
          validator: (value) => (value == null || value.isEmpty) ? '':
          null,
          
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize lists first
    otpLength =
        otp.isNotEmpty ? otp.length : (widget.requestResponse != null ? 6 : 4);
    _controllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());

    if (widget.signUpObj?.otp?.isNotEmpty == true) {
      otp = widget.signUpObj!.otp!;
    } else if (widget.requestResponse?.resetOtp?.isNotEmpty == true) {
      otp = widget.requestResponse!.resetOtp!;
    } else {
      otp = "";
    }
    // Optional: auto-fill text boxes from otp
    if (otp.isNotEmpty) {
      for (int i = 0; i < otp.length && i < otpLength; i++) {
        _controllers[i].text = otp[i];
      }
    }
  }

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
              if (state is SignUpStateSuccess) {
                // LoadingDialog.hide(context);
                // print("Reset password success");
                final User user = state.data.data.user;
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
              ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
              break;

            default:
              LoadingDialog.hide(context);
          }
        },
        child: otpView(),
      ),
    );
  }

  Widget otpView() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Form(
            key: otpFormKey,
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
                    child: Utility.smlText(
                      loginDescription,
                      AppColors.colorBlack,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Utility.subTitle(
                      "Register Otp -> $otp",
                      AppColors.colorBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: List.generate(
                      otpLength,
                      (index) => _otpBox(index),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (otpFormKey.currentState!.validate()) {
                      if (widget.requestResponse?.resetOtp?.isNotEmpty ==
                          true) {
                        if (widget.requestResponse!.resetOtp == getOtp()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen(),
                            ),
                          );
                        }
                      } else {
                        // OTP was not provided in response — call API to verify
                        context.read<SigninBloc>().add(
                          DoSignUpEvent(
                            userName: widget.userName,
                            userPassword: widget.password ?? '',
                            otp: getOtp(),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
