import 'package:flutter/material.dart' hide Material;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:in_setu/commonWidget/auto_sliding_images.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/screens/home_page/widget/add_member_screen.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/supports/utility.dart';

import '../project_list/model/AllSitesResponse.dart';

class DashboardScreen extends StatefulWidget {
  final DashboardResponse dashboardResponse;
  final ScrollController scrollController;
  final Data siteObject;
  final User user;

  const DashboardScreen({
    super.key,
    required this.dashboardResponse,
    required this.scrollController,
    required this.siteObject,
    required this.user,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardResponse? dashboardResponse;
  List<MaterialItem> materialList = [];

  List<SitePlanModel> slideImages = [
    SitePlanModel(planImg: "assets/icons/construction_img.png"),
    SitePlanModel(planImg: "assets/icons/site_img.jpg"),
    SitePlanModel(planImg: "assets/icons/construction_img.png"),
    SitePlanModel(planImg: "assets/icons/site_img.jpg"),
  ];

  @override
  void initState() {
    super.initState();
    dashboardResponse = widget.dashboardResponse;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: widget.scrollController,
      physics: NeverScrollableScrollPhysics(), // Disable local scrolling
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _setImageView(),
          SizedBox(height: 20),
          _buildMaterialSection(),
          SizedBox(height: 20),
          _buildSiteTeamSection(),
          SizedBox(height: 20),
          _buildSitePlansSection(context),
          SizedBox(height: 20),
          _buildManPowerList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _setImageView() {
    return AutoSlidingImages(images: slideImages);
  }

  Widget _buildMaterialSection() {
    materialList = dashboardResponse!.materials;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Utility.title(materials, AppColors.colorBlack)],
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 70,
          width: double.infinity,
          child:
              materialList.isEmpty
                  ? Center(
                    child: Card(
                      color: AppColors.colorWhite,
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child:Text(
                            materialNotAvailable,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: materialList.length,
                    itemBuilder: (context, index) {
                      final materialObj = materialList[index];
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: _buildMaterialCard(
                          materialObj.requirement1,
                          "${materialObj.qty} ${materialObj.unit}",
                          Icons.construction,
                          AppColors.primary,
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildMaterialCard(
    String name,
    String quantity,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.colorGray, width: 1),
        ),
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 8),
                Expanded(
                  // <-- Ensures text respects container width
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align text to start
                    children: [
                      Utility.smlText(name, AppColors.colorGray),
                      Utility.smlText(quantity, AppColors.colorBlack),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteTeamSection() {
    // List<TeamMember> teamMembers = dashboardResponse!.teams.values.toList();
    List<TeamMember> teamMembers = dashboardResponse!.teams;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utility.title(siteTeam, AppColors.colorBlack),
            TextButton.icon(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddMemberScreen(
                              siteObj: widget.siteObject,
                              user: widget.user,
                            ),
                      ),
                    ),
                  },
              icon: Icon(Icons.person_add, size: 18),
              label: Utility.smlText(addMembers, AppColors.primary),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        teamMembers.isEmpty
            ? Center(
              child: Card(
                color: AppColors.colorWhite,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 48,
                          color: Color(0xFF9CA3AF),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No Team Members Added',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            )
            : SizedBox(
              height: 120, // Set a fixed height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 15),
                    // Horizontal spacing between items
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Centers vertically
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                            // border: Border.all(color: AppColors.colorBlack, width: 1.5)
                          ),
                          child: Center(
                            child: Text(
                              member.name
                                  .split(' ')
                                  .map((e) => e[0])
                                  .take(2)
                                  .join(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Spacing between avatar and name
                        // Name
                        SizedBox(
                          width:
                              100, // Constrain text width to prevent overflow
                          child: Utility.smlText(
                            member.name,
                            AppColors.colorGray,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      ],
    );
  }
  Widget noSitePlanFound(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Icon(
              Icons.architecture,
              size: 40,
              color: const Color(0xFF9CA3AF)),
          SizedBox(height: 15),
          Text(
            'No Plans Available',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload site plans and blueprints',
            style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF9CA3AF)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


  Widget _buildSitePlansSection(BuildContext context) {
    final listOfSitePlans = dashboardResponse!.sitePlans;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.title(sitePlan, AppColors.colorBlack),
        const SizedBox(height: 10),

        listOfSitePlans.isEmpty
            ? noSitePlanFound()
            : MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: listOfSitePlans.length,
          itemBuilder: (context, index) {
            final sitePlan = listOfSitePlans[index];
            return Card(
              clipBehavior: Clip.hardEdge,
              color: AppColors.colorWhite,
              shadowColor: Colors.black12,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.colorBlack,
                              width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: buildFileImage(sitePlan.path),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        sitePlan.documentName ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.colorBlack, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  Widget buildFileImage(String? path) {
    if (path == null || path.isEmpty) {
      return Image.asset("assets/images/default_gallery_icon.png",
        fit: BoxFit.cover,
        width: double.infinity,);
    } else if (path.endsWith(".jpg") ||
        path.endsWith(".jpeg") ||
        path.endsWith(".png")) {
      return Image.network(
        "${ApiConstants.baseUrl}$path",
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/images/default_gallery_icon.png",
            fit: BoxFit.cover,
            width: double.infinity,);
        },
      );
    } else if (path.endsWith(".pdf")) {
      return Image.asset("assets/icons/icon_pdf.png",
        fit: BoxFit.cover,
        width: double.infinity,);
    } else if (path.endsWith(".dwg")) {
      return Image.network(
        "${ApiConstants.baseUrl}${path}",
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      return Image.asset("assets/images/default_gallery_icon.png",
        fit: BoxFit.cover,
        width: double.infinity,);
    }
  }


  Widget _buildManPowerList() {
    final List<Manpower> manPowersListItems = dashboardResponse!.manpower;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.title(manPower, AppColors.colorBlack),
        SizedBox(height: 10), // Add some spacing
        _buildProjectsList(manPowersListItems), // Remove the Expanded widget
      ],
    );
  }

  Widget _buildProjectsList(List<Manpower> manPowersList) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 100),
      child:
          manPowersList.isEmpty
              ? Center(
                child: Card(
                  color: AppColors.colorWhite,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 48,
                            color: Color(0xFF9CA3AF),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No Manpower Available',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: manPowersList.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(manPowersList[index]);
                },
              ),
    );
  }

  Widget _buildProjectCard(Manpower manpowerObj) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectHeader(manpowerObj),
          _buildProjectContent(manpowerObj),
        ],
      ),
    );
  }

  Widget _buildProjectHeader(Manpower manPower) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 8, top: 8),
      decoration: BoxDecoration(
        /*const Color.fromARGB(255, 236, 228, 228)*/
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Utility.subTitle(manPower.agencyName, AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectContent(Manpower project) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Staff:-',
            project.staffs
                .asMap()
                .entries
                .map((s) => _buildStaffItem(s.value, s.key))
                .toList(),
          ),
          SizedBox(height: 2),
          _buildSection(
            'Manpower:-',
            project.manpowers
                .asMap()
                .entries
                .map((m) => _buildManpowerItem(m.value, m.key))
                .toList(),
          ),
          SizedBox(height: 2),
          _buildSection(
            'Task:-',
            project.tasks
                .asMap()
                .entries
                .map((t) => _buildTaskItem(t.value, t.key))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utility.subTitle(title, Colors.black54),
          SizedBox(height: 2),
          ...items,
        ],
      ),
    );
  }

  Widget _buildStaffItem(Staff staff, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.colorLightGray,
      ),
      child: Row(
        children: [
          SizedBox(width: 2),
          Text(
            "${index + 1}",
            style: TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              staff.memberName,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              staff.memberCount,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManpowerItem(Staff manpower, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.colorLightGray,
      ),
      child: Row(
        children: [
          SizedBox(width: 2),
          Text(
            "${index + 1}",
            style: TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              manpower.memberName,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            /*decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),*/
            child: Text(
              manpower.memberCount,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Task task, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.colorLightGray,
      ),
      child: Row(
        children: [
          SizedBox(width: 2),
          Text(
            "${index + 1}",
            style: TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 8),
          Text(
            task.taskName,
            style: TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Utility.smlText("", Colors.black54),
          ),
        ],
      ),
    );
  }
}

class AddMemberModel {
  String name;
  String img;

  AddMemberModel({required this.name, required this.img});
}

class SitePlanModel {
  String planImg;

  SitePlanModel({required this.planImg});
}
