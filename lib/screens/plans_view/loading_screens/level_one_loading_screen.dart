import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class LevelOneLoadingScreen extends StatefulWidget {
  const LevelOneLoadingScreen({super.key});

  @override
  State<LevelOneLoadingScreen> createState() => _LevelOneLoadingScreenState();
}

class _LevelOneLoadingScreenState extends State<LevelOneLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Container(
              width: 80,
              height: 15,
              color: AppColors.skeletonHighlight,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50),),
                color: AppColors.skeletonHighlight,
              ),
            )
          ]),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                childAspectRatio: 0.80,
                // childAspectRatio: 0.85,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.skeletonHighlight,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 140,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  border: Border.all(
                                    color: AppColors.colorGray,
                                    width: 0.5,
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    color: AppColors.skeletonBase,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5), // Half of image height (90/2)
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 80,
                              height: 10,
                              color: AppColors.skeletonHighlight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
