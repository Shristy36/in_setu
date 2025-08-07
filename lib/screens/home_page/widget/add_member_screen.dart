import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/bloc/home_bloc.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/model/SiteTeamMemberResponse.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/screens/home_page/widget/add_contact_widget.dart';
import 'package:in_setu/widgets/bottomnav.dart';

import '../../project_list/model/AllSitesResponse.dart' hide UserData;

class AddMemberScreen extends StatefulWidget {
  final Data siteObj;
  final User user;

  const AddMemberScreen({super.key, required this.siteObj, required this.user});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final List<Color> backgroundColors = [
    Color(0xFFb2ae92),
    Color(0xFF5a9e42),
    Color(0xFF567cd9),
    Color(0xFFf5a623),
    Color(0xFF50e3c2),
    Color(0xFF9013fe),
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetSiteMemberEvent(siteId: widget.siteObj.id));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                BottomNavScreen(
                  user: widget.user,
                  siteObject: widget.siteObj,
                ),
          ),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            "Teams",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                      BottomNavScreen(
                        user: widget.user,
                        siteObject: widget.siteObj,
                      ),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        floatingActionButton: Container(
          width: 120.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () => showContactBottomSheet(context),
            backgroundColor: AppColors.primary,
            child: const Text(
              "Add Member",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: BlocBuilder<HomeBloc, GlobalApiResponseState>(
          builder: (context, state) {
            if (state.status == GlobalApiStatus.loading) {
              // return Utility.getLoadingView(context);
            } else if (state.status == GlobalApiStatus.completed) {
              if (state is SiteTeamMemberStateSuccess) {
                if (state.data.data.isNotEmpty) {
                  return getSiteMemberView(state.data.data);
                } else {
                  return Center(
                    child: NoDataFound(
                      noDataFoundTxt: "Site member are not found",
                    ),
                  );
                }
              }
            } else if (state.status == GlobalApiStatus.error) {
              return ErrorHandler.builderErr(
                state.message,
                "Something wrong",
                context,
              );
            }
            return Center(child: Utility.getLoadingView(context));
          },
        ),
      ),
    );
  }

  Widget getSiteMemberView(List<SiteMember> siteTeamList) {
    // List<UserData> memberList = siteTeamList.values.toList();
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: siteTeamList.length,
        itemBuilder: (context, index) {
          final contact = siteTeamList[index];
          final bgColor = backgroundColors[index % backgroundColors.length];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                _showContactDetails(context, contact, index);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: bgColor,
                              child: Text(
                                contact.name!
                                    .split(' ')
                                    .map((e) => e[0])
                                    .take(1)
                                    .join(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorWhite,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(contact.contact!),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showContactDetails(BuildContext context,
      SiteMember contactObj,
      int index,) {
    showModalBottomSheet(
      backgroundColor: AppColors.colorWhite,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: BlocListener<HomeBloc, GlobalApiResponseState>(
            listener: (context, state) {
              switch (state.status) {
                case GlobalApiStatus.completed:
                  LoadingDialog.hide(context);
                  if (state is MakeAdminStateSuccess) {
                    context.read<HomeBloc>().add(GetSiteMemberEvent(siteId: widget.siteObj.id));
                    Utility.showToast(state.data.message);
                    Navigator.pop(context);
                  }else if(state is RemoveSiteMemberStateSuccess){
                    context.read<HomeBloc>().add(GetSiteMemberEvent(siteId: widget.siteObj.id));
                    Utility.showToast(state.data.message);
                    Navigator.pop(context);
                  }else if(state is ReInviteStateSuccess){
                    context.read<HomeBloc>().add(GetSiteMemberEvent(siteId: widget.siteObj.id));
                    Utility.showToast(state.data.message);
                    Navigator.pop(context);
                  }
                  break;
                case GlobalApiStatus.error:
                  LoadingDialog.hide(context);
                  ErrorHandler.errorHandle(
                      state.message, "Auth Error", context);
                  break;
                default:
                  LoadingDialog.hide(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      bottom: 20.0,
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Utility.subTitle("Add User", AppColors.colorBlack),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Utility.subTitle(
                              "Close",
                              AppColors.colorBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 25,
                    right: 30,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utility.subTitle(
                                      contactObj.name!,
                                      AppColors.colorBlack,
                                    ),
                                    Utility.smlText(
                                      contactObj.contact!,
                                      AppColors.colorGray,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "${widget.siteObj.siteName}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 25,
                    right: 30,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: (){
                        context.read<HomeBloc>().add(
                          MakeAdminEvent(
                            reqParams: {
                              "name": contactObj.name,
                              "contact": contactObj.contact,
                              "con_short": contactObj.conShort,
                              "con_style": contactObj.conStyle,
                              "isAdmin": false,
                              "clicked": true,
                            },
                            reqType: "makeadmin",
                            siteId: widget.siteObj.id,
                          ),
                        );
                      },
                      child: Text(
                        "Re -invite",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 25,
                    right: 30,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(
                        MakeAdminEvent(
                          reqParams: {
                            "name": contactObj.name,
                            "contact": contactObj.contact,
                            "con_short": contactObj.conShort,
                            "con_style": contactObj.conStyle,
                            "isAdmin": false,
                            "clicked": true,
                          },
                          reqType: "makeadmin",
                          siteId: widget.siteObj.id,
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Make As Admin",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 25,
                    right: 30,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: (){
                        context.read<HomeBloc>().add(
                          RemoveSiteMemberEvent(
                            reqParams: {
                              "name": contactObj.name,
                              "contact": contactObj.contact,
                              "con_short": contactObj.conShort,
                              "con_style": contactObj.conStyle,
                              "isAdmin": false,
                              "clicked": true,
                            },
                            reqType: "removefromteam",
                            siteId: widget.siteObj.id,
                          ),
                        );
                      },
                      child: Text(
                        "Remove from team",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }


  void showContactBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddContactWidget(
          siteObj: widget.siteObj,
          onContactSelected: (value) {
            if (value) {
              context.read<HomeBloc>().add(
                GetSiteMemberEvent(siteId: widget.siteObj.id),
              );
            }
          },
        );
      },
    );
  }
}
