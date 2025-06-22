import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/sizes.dart';

class CustomViews{
  static Widget setTitleText(String txt){
    return Text(txt, style: TextStyle(fontSize: SSizes.fontSizeLg, color: AppColors.colorBlack,fontWeight: FontWeight.bold),);
  }
  static Widget setSubTitle(String txt){
    return Text(txt, style: TextStyle(fontSize: SSizes.fontSizeMd, color: AppColors.colorWhite,fontWeight: FontWeight.normal),);
  }
  static Widget setNormalTxt(String txt){
    return Text(txt, style: TextStyle(fontSize: SSizes.fontSizeSm, color: AppColors.colorBlack,fontWeight: FontWeight.normal),);
  }
  static Widget setVerticalSpace(){
    return SizedBox(height: 15,);
  }
  static Widget setHorizontalSpace(){
    return SizedBox(height: 15,);
  }
  static setBorderRadius(){
    BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: AppColors.primary, width: 1)
    );
  }
}