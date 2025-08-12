import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/login_view/bloc/signin_bloc.dart';
import 'package:in_setu/screens/walkthrough_screen/onboarding_screen.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';

class AccountDeleteDialog {
  static  showAccountDeleteDialog(
    BuildContext context,
    String userToken,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.colorWhite,
          child: BlocListener<SigninBloc, GlobalApiResponseState>(
            listener: (context, state) {
              switch (state.status) {
                case GlobalApiStatus.loading:
                  break;
                case GlobalApiStatus.completed:
                  if (state is DeleteAccountStateSuccess) {
                    Navigator.of(context).pop();
                    Utility.showToast(state.data!.message);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()),);
                  }
                  break;
                case GlobalApiStatus.error:
                  LoadingDialog.hide(context);
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30), // Space for the circle
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            deleteTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                              color: AppColors.colorBlack,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          accountDeleteMsg,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Utility.subTitle(
                                "No",
                                AppColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () async {
                              context.read<SigninBloc>().add(DeleteAccountEvent(userToken: userToken));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Utility.subTitle(
                                "Yes",
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -32.5,
                  child: Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Utility.smlText("image", AppColors.colorWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
