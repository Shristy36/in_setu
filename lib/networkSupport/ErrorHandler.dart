import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/DialogManager.dart';
import 'package:in_setu/supports/utility.dart';

class ErrorHandler {
  //change with suitable dialog
  static void errorHandle(String message, String title, BuildContext context){
    DialogManager.showErrorDialog(message, title,context);
  }
  static  builderErr(String message, String title, BuildContext context){
    DialogManager.showErrorDialog(message, title,context);
  }

  static void showErrorDialog(
      String message,
      String title,
      BuildContext context,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.colorWhite,
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
                        child: Utility.title(title, Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Utility.subTitle("Yes", AppColors.primary),
                        ),
                      ),
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
        );
      },
    );
  }
}
