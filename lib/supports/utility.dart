import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/widgets/privacy_policy_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class Utility{
  static Future<bool> showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:Text('Exit App', style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.normal),),
        content: Text('Do you really want to exit the app?', style: TextStyle(fontSize: 14, color: Colors.black45, fontStyle: FontStyle.normal)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop(true);
              SystemNavigator.pop();
            },
            child: Text('Exit'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ) ?? false;
  }

  static Widget title(String titleTxt, Color txtColor){
    return Text(titleTxt, style: TextStyle(fontSize: 18, fontFamily: 'OpenSans', fontWeight: FontWeight.w700, color: txtColor, overflow: TextOverflow.ellipsis),);
  }
  static Widget subTitle(String subTitle, Color color){
    return Text(subTitle, style: TextStyle(fontSize: 16, fontFamily: 'OpenSans',fontWeight: FontWeight.w400,color: color, overflow: TextOverflow.ellipsis),);
  }
  static Widget smlText(String smlTxt, Color smlColors){
    return Text(smlTxt, style: TextStyle(fontSize: 14, fontFamily: 'OpenSans',fontWeight: FontWeight.w200,color: smlColors),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,);
  }

  static Future<bool> checkAndRequestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // Show dialog to open app settings
      return false;
    } else {
      // Request the permission
      final result = await permission.request();
      return result.isGranted;
    }
  }
  static Future<void> showPermissionRationaleDialog(
      BuildContext context, {
        required String title,
        required String message,
        required Permission permission,
      }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text('Deny'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('Allow'),
                onPressed: () async {
                  // Navigator.pop(context);
                  await permission.request();
                },
              ),
            ],
          ),
    );
  }

  static Widget getCustomToolbar(String title, Color titleColor, BuildContext context){
    return Container(
      color: AppColors.colorWhite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            GestureDetector(onTap: (){
              if(title == "login") {
                showExitDialog(context);
              }else{
                Navigator.pop(context);
              }
            },child: Icon(Icons.arrow_back, color: AppColors.primary,)),
            SizedBox(width: 20,),
            Text(title, style: TextStyle(fontSize: 18, fontFamily: 'OpenSans', fontWeight: FontWeight.w400, color: titleColor))
          ],
        ),
      ),
    );
  }
  static Widget getButtonDesign(String txt){
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: AppColors.primary
      ),
      child: Center(
        child: subTitle(txt, AppColors.colorWhite),
      ),
    );
  }
  static void showFlutterToast(String msg, {BuildContext? context}) {
    try {
      Fluttertoast.cancel(); // Cancel any existing toast

      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2, // Increased from 1 to 2 seconds
        backgroundColor: AppColors.colorWhite, // Use direct color for testing
        textColor: AppColors.colorBlack,
        fontSize: 14.0,
        webShowClose: true, // For web platform
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)", // Web specific
      );
    } catch (e) {
      debugPrint('Toast error: $e');
      // Fallback to SnackBar if toast fails
      if (context != null && ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    }
  }
  static Widget getRichText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: AppColors.colorGray, // Default text color
              fontSize: 14,
            ),
            children: [
              const TextSpan(text: "By submitting my information, I acknowledge and accept the "),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyWidget()));
                  },
              ),
              const TextSpan(text: " and "),
              TextSpan(
                text: "Terms and Conditions",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to Terms screen or launch URL
                  },
              ),
              const TextSpan(text: " of the builder's Application."),
            ],
          ),
        ),
      ),
    );
  }
}