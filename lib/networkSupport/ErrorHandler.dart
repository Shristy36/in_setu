import 'package:flutter/material.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/DialogManager.dart';

class ErrorHandler {
  //change with suitable dialog
  static void errorHandle(String message, String title, BuildContext context){
    DialogManager.showErrorDialog(message, title,context);
  }
  static  builderErr(String message, String title, BuildContext context){
    DialogManager.showErrorDialog(message, title,context);
  }
}
