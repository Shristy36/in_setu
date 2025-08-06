import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';

class NoDataFound extends StatelessWidget {
  final String noDataFoundTxt;
  const NoDataFound({super.key, required this.noDataFoundTxt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/empty.png", height: 100, width: 100,),
          SizedBox(height: 10,),
          Align(alignment: Alignment.center,child: Text(noDataFoundTxt, style: TextStyle(fontSize: 14, color: AppColors.colorGray),))
        ],
      ),
    );
  }
}
