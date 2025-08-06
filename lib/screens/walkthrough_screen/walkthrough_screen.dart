import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/views/login_view/sign_in_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final _controller = PageController();
  bool skipBtnVisible = true;
  String buttonText = "Next";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  skipBtnVisible = index != 2;// hide on last page
                  if(index != 2){
                    buttonText = "Next";
                  }else{
                    buttonText = "Get Started";
                  }
                });
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/walkthrough2.png"),
                    SizedBox(height: 10),
                    Text("Dual Axis Incline", style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.normal)),
                    SizedBox(height: 10),
                    Text(
                      "Everest Front Lat Pull Down",
                      style: TextStyle(fontSize: 14, color: Colors.black45, fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/walkthrough1.png"),
                    SizedBox(height: 10),
                    Text("Everest Front Lat Pull Down", style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.normal)),
                    SizedBox(height: 10),
                    Text(
                      "Everest Front Lat Pull Down",
                      style: TextStyle(fontSize: 14, color: Colors.black45, fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/walkthrough3.png"),
                    SizedBox(height: 10),
                    Text(
                      "Iso Lateral Super Incline Shoulder Press",
                      style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.normal),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Iso Lateral Super Incline Shoulder Press",
                      style: TextStyle(fontSize: 14, color: Colors.black45, fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: WormEffect(
              dotHeight: 10, // Smaller height
              dotWidth: 10, // Smaller width
              spacing: 8,
              dotColor: Colors.grey,
              activeDotColor: AppColors.primary,
            ), // You can use others like ExpandingDotsEffect
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: skipBtnVisible,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false,);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_controller.page!.toInt() < 2) {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false,);
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
