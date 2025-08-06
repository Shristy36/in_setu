import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbank_app_flutter/configs/Palette.dart';
import 'package:mbank_app_flutter/configs/Strings.dart';
import 'package:mbank_app_flutter/support/NavigationService.dart';
import 'package:mbank_app_flutter/support/utils/ToastUtils.dart';
import 'package:mbank_app_flutter/ui/Login/authentication/LoginView/LoginScreen.dart';

import '../../../configs/Dimens.dart';
import '../../RouteContants.dart';

class DialogManager {
  //only used to show warning dialog when new login
  static void showVerificationWarningDialog({
    String title = "Info",
    String description = "Information",
    required VoidCallback onOkPressed,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/ic_error.png",
              height: 50,
              width: 50,
              color: Palette.errorColor,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              title ?? '',
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(Get.context!);
                Get.back();
                onOkPressed();
                // Navigator.pushNamed(
                //     NavigationService.navigatorKey.currentContext!,
                //     RouteConstants.otpVerification);
              },
              child: const Text("ok"),
            )
          ],
        ),
      ),
    ));
  }

  void accessTokenExpiredDialog() {
    showAccessTokenExpiredDialog(callback: () {
      /* Get.dialog(const Dialog(
        child: LoginDialog(),
      ));*/
      Get.offAll(() => const LoginScreen());
    });
  }

  void showAccessTokenExpiredDialog({
    String title = "Error",
    String description = Strings.accessTokenExpired,
    required VoidCallback callback,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/ic_error.png",
              height: 50,
              width: 50,
              color: Palette.errorColor,
            ),
            const SizedBox(height: margin),
            Text(title ?? '', style: Get.textTheme.headlineSmall),
            const SizedBox(height: margin),
            Text(description ?? "", style: Get.textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                callback();
                Get.back(); //close the dialog
              },
              child: Text(Strings.ok),
            ),
          ],
        ),
      ),
    ));
  }

  static void showTransactionSuccessDialog({
    String title = "Success",
    String description = "Transaction Success",
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/img_tran_success.png",
              height: 150,
              width: 150,
              //color: Palette.errorColor,
            ),
            const SizedBox(height: margin),
            Text(title ?? '', style: Get.textTheme.headlineSmall),
            const SizedBox(height: margin),
            Text(description ?? '', style: Get.textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                /* if(Get.isDialogOpen) {
                  Get.back();
                }*/
                Get.back();
              },
              child: const Text("ok"),
            )
          ],
        ),
      ),
    ));
  }

  static void showErrorDialog({
    String title = "Error",
    String description = "Some thing went wrong",
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/ic_error.png",
              height: 50,
              width: 50,
              color: Palette.errorColor,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              title ?? '',
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                /* if(Get.isDialogOpen) {
                  Get.back();
                }*/
                Get.back();
              },
              child: const Text("ok"),
            )
          ],
        ),
      ),
    ));
  }

  static void showInfoDialogWithAction({
    String title = "Title",
    String description = "Some message",
    required VoidCallback callback,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/ic_info.png",
              height: 50,
              width: 50,
              color: Palette.errorColor,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              title ?? '',
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: callback,
              child: const Text("ok"),
            )
          ],
        ),
      ),
    ));
  }

  static void showWarningDialog({
    String title = "Title",
    String description = "Some message",
    required VoidCallback callback,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/ic_info.png",
              height: 50,
              width: 50,
              color: Palette.errorColor,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              title ?? '',
              style: Get.textTheme.titleSmall,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    closeDialog();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Palette.red, fontSize: smallTextSize, fontFamily: Strings.fontFamily),
                  ),
                ),
                TextButton(
                  onPressed: callback,
                  child: const Text("ok"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  static void showTransactionSuccessDialog1({
    String title = "Success",
    String description = "Transaction successful",
    required VoidCallback callback,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/img_tran_success.png",
              height: 150,
              width: 150,
              color: Palette.errorColor,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              title ?? '',
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: margin,
            ),
            Text(
              description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: callback,
              child: const Text("ok"),
            )
            /* GestureDetector(child: const Text("ok"), onTap: (){
             callback.e
            },)*/
          ],
        ),
      ),
    ));
  }

  static void closeDialog() {
    if (Get.isDialogOpen != null) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }
}
