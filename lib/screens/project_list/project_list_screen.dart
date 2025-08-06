import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/DialogManager.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/views/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/views/project_list/bloc/sites_bloc.dart';
import 'package:in_setu/views/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/widgets/add_project_widget.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/bottomnav.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';

class ProjectListScreen extends StatefulWidget {
  final User user;

  const ProjectListScreen({super.key, required this.user});

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<SitesBloc>().add(GetAllSites());
  }

  void _editSiteModel(Data siteObject) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddSiteModal(
        onClose: () => Navigator.of(context).pop(),
        onSiteAdded: () {
          context.read<SitesBloc>().add(GetAllSites());
        },
        siteObject: siteObject,
      ),
    );
  }

  void _showAddSiteModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddSiteModal(
        onClose: () => Navigator.of(context).pop(),
        onSiteAdded: () {
          context.read<SitesBloc>().add(GetAllSites());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: getDrawerItems(context),
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            APPBarWidget(
              isSiteNameVisible: false,
              user: widget.user,
              siteName: "",
              siteId: 0,
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.colorGray, width: 1),
                ),
                child: TextField(
                  autofocus: false,
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Utility.title(allSite, AppColors.colorBlack),
              ),
            ),
            Expanded(child: _buildProjectList()),
            SizedBox(height: 20),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    return BlocBuilder<SitesBloc, GlobalApiResponseState>(
      builder: (context, state) {
        if (state.status == GlobalApiStatus.loading && state.data == null) {
          return Utility.getLoadingView(context);
        }

        if (state is AllSiteStateSuccess) {
          if (state.data.data == null || state.data.data!.isEmpty) {
            return NoDataFound(noDataFoundTxt: "No site project found");
          }
          return listProject(state.data.data!);
        }

        if (state.status == GlobalApiStatus.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorHandler.errorHandle(state.message, "Invalid", context);
          });
          return Center(child: Text('Failed to load projects'));
        }

        if (state.data != null && state.data is AllSitesResponse) {
          final data = (state.data as AllSitesResponse).data;
          if (data != null && data.isNotEmpty) {
            return listProject(data);
          }
        }

        return Center(child: Text('Loading...'));
      },
    );
  }

  Widget listProject(List<Data> listOfProject) {
    final filteredProjects = _searchQuery.isEmpty
        ? listOfProject
        : listOfProject.where((project) {
      return project.siteName!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          project.siteLocation!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          project.companyName!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    if (filteredProjects.isEmpty) {
      return NoDataFound(noDataFoundTxt: "No matching projects found");
    }

    return ListView.builder(
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final site = filteredProjects[index];
        return Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 5, top: 25, right: 18),
          child: _buildProjectCard(
            title: site.siteName!,
            location: site.siteLocation!,
            subLocation: site.companyName!,
            count: site.badge!,
            img: site.siteImage,
            gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
            siteObject: site,
          ),
        );
      },
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String location,
    required String subLocation,
    required num count,
    required dynamic img,
    required List<Color> gradient,
    required Data siteObject,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.none,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavScreen(
                  user: widget.user,
                  siteObject: siteObject,
                ),
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.colorGray, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: img != null
                              ? Image.network(ApiConstants.baseUrl + img, fit: BoxFit.cover)
                              : Image.asset("assets/icons/profile_img.jpg", fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Utility.subTitle(title, AppColors.colorBlack),
                          ),
                          SizedBox(height: 8),
                          Utility.smlText(location, AppColors.colorGray),
                          Utility.smlText(subLocation, AppColors.colorGray),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _editSiteModel(siteObject),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.edit_outlined, color: Color(0xFF64748B), size: 18),
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async {
                                    final delete = await DialogManager.showDeleteSiteDialog(
                                      context,
                                      siteDeleteMsg,
                                      siteDeleteTitle,
                                      siteObject.id,
                                    );
                                    if (delete) {
                                      context.read<SitesBloc>().add(GetAllSites());
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFEE2E2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -17.5,
                right: 5,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Utility.smlText(count.toString(), AppColors.colorWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFB800).withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _showAddSiteModal,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'ADD NEW PROJECT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
