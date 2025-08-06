import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/home_page/dashboard_screen.dart';

class AutoSlidingImages extends StatefulWidget {
  final List<SitePlanModel> images;

  const AutoSlidingImages({Key? key, required this.images}) : super(key: key);

  @override
  _AutoSlidingImagesState createState() => _AutoSlidingImagesState();
}

class _AutoSlidingImagesState extends State<AutoSlidingImages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: AppColors.colorGray, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.images[index].planImg,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => Container(
              width: _currentPage == index ? 20 : 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.primary : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            ),
          ),
        ),
      ],
    );
  }
}
