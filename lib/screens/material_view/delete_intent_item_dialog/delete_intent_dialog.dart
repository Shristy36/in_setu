
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';

class DeleteIntentDialog{
  static Future<bool> showDeleteManPowerDialog(
      BuildContext context,
      String message,
      String title,
      dynamic userId,
      )async {
    bool deleted = false;
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.colorWhite,
          child: BlocListener<MaterialStockBloc, GlobalApiResponseState>(
            listener: (context, state) {
              switch (state.status) {
                case GlobalApiStatus.loading:
                  break;
                case GlobalApiStatus.completed:
                  if (state is DeleteIntentStateSuccess) {
                    Navigator.of(context).pop();
                    Utility.showToast(state.data!.message);
                    deleted = true;
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
                            siteDeleteTitle,
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
                          message,
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
                                "Cancel",
                                AppColors.primary,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              context.read<MaterialStockBloc>().add(DeleteIntentEvent(id: userId));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Utility.subTitle(
                                "Yes, Delete It!",
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
    return deleted;
  }
}