import 'package:flutter/material.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

import 'model/DashBoardResponse.dart';

class TimeLineScreen extends StatefulWidget {
  List<Feed> feeds;
  UserData? userData;

  TimeLineScreen({super.key, required this.feeds, required this.userData});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {

  @override
  Widget build(BuildContext context) {
    if(widget.feeds == null || widget.feeds.isEmpty){
     return NoDataFound(noDataFoundTxt: "No Timeline Found");
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5),
      shrinkWrap: true,  // Allows ListView to take only needed height
      physics: ClampingScrollPhysics(),  // Smooth scrolling behavior
      itemCount: widget.feeds.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: FeedItemCard(feed: widget.feeds[index]),
        );
      },
    );
  }
}

class FeedItemCard extends StatelessWidget {
  final Feed feed;

  const FeedItemCard({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = '${feed.user.firstName} ${feed.user.lastName}';
    final role = feed.user.designation;
    final img = feed.user.profileImage;
    final date = DateFormat('MMM dd, yyyy').format(feed.createdAt);
    final time = DateFormat('HH:mm:ss a').format(feed.createdAt);
    final title = _getActivityTitle(feed.activityType, feed.targetTable);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info row (unchanged from your original)
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: (img.isEmpty)
                      ? LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primary, width: 1),
                  image: (img.isNotEmpty)
                      ? DecorationImage(
                    image: NetworkImage(ApiConstants.baseUrl +img),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: (img.isEmpty)
                    ? Center(
                  child: Text(
                    name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join(''),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : null,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          /*SizedBox(height: 16),
          // Activity type title
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),*/
          SizedBox(height: 18),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Html(
              data: feed.content,
              style: {
                "h6": Style(
                  textAlign: TextAlign.center,
                  fontSize: FontSize.larger,
                  color: AppColors.colorGray,
                  margin: Margins.only(bottom: 15, top: 15),
                ),
                "strong": Style(
                  fontWeight: FontWeight.normal,
                  color: AppColors.colorGray,
                ),
                "hr": Style(
                  margin: Margins.symmetric(vertical: 12),
                    border: Border.all(color: Colors.transparent, width: 0), // Removes the line
                    height: Height(0.0)
                ),
                "body": Style(margin: Margins.zero, color: AppColors.colorGray,/* padding: EdgeInsets.zero*/),
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getActivityTitle(String activityType, String targetTable) {
    switch (activityType) {
      case 'CREATE':
        switch (targetTable) {
          case 'manpower':
            return 'Manpower Added';
          case 'sites':
            return 'Site Created';
          case 'stock':
            return 'Stock Added';
          default:
            return 'New Activity';
        }
      case 'UPDATE':
        return 'Updated ${targetTable.capitalize()}';
      default:
        return 'Activity';
    }
  }
}

// Extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
