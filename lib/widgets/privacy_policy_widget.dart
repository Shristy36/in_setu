import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/supports/utility.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Utility.subTitle(privacyPolicyTitle, AppColors.colorWhite), iconTheme: IconThemeData(color: AppColors.colorWhite),backgroundColor: AppColors.primary,),
       body: Padding(
           padding: EdgeInsets.all(15),
         child: Align(alignment: Alignment.center,child: Text(privacyPolicyDescription, style: TextStyle(fontSize: 12, color: AppColors.colorBlack),),),
       ),
    );
  }
}
