import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/plans_view/bloc/plans_bloc.dart';
import 'package:in_setu/screens/plans_view/loading_screens/level_one_loading_screen.dart';
import 'package:in_setu/screens/plans_view/model/DocumentLevelOneResponse.dart';
import 'package:in_setu/screens/plans_view/plan_details_screen.dart';
import 'package:in_setu/screens/plans_view/storageManager/create_folder.dart';
import 'package:in_setu/screens/plans_view/storageManager/model/folder_model.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/screens/material_view/material_screen.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/bottomnav.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';

class ProjectPlansScreen extends StatefulWidget {
  final Data siteObject;
  final User user;

  ProjectPlansScreen({super.key, required this.siteObject, required this.user});

  @override
  _ProjectPlansScreenState createState() => _ProjectPlansScreenState();
}

class _ProjectPlansScreenState extends State<ProjectPlansScreen>
    with TickerProviderStateMixin {
  bool _isGridView = true;
  TextEditingController nameController = TextEditingController();
  List<Document> listOfDocument = [];

  @override
  void initState() {
    super.initState();
    context.read<PlansBloc>().add(
      DocumentLevelOneFetch(
        siteId: widget.siteObject.id,
        folderName: "document",
        levelNo: 1,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Item',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 24),
                _buildAddOption(
                  icon: Icons.folder_outlined,
                  title: 'Add Folder',
                  subtitle: 'Create a new project folder',
                  color: Colors.blue,
                  onTap: () => _addFolder(),
                ),
                SizedBox(height: 16),
                _buildAddOption(
                  icon: Icons.upload_file,
                  title: 'Upload File',
                  subtitle: 'Upload files from your device',
                  color: Colors.green,
                  onTap: () => _addFile(),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addFolder() {
    _showNameDialog('Create Folder', 'Enter folder name', (name) {
      HapticFeedback.lightImpact();
    });
  }

  void _addFile() async {
    final List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'dwg', 'pdf'];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
      );

      if (result != null) {
        for (PlatformFile file in result.files) {
          String fileName = file.name;
          String fileExtension = fileName.split('.').last.toLowerCase();

          if (!allowedExtensions.contains(fileExtension)) {
            Utility.showToast("This file type is not allowed: ${file.name}");
            continue; // skip this file
          }
          await createFolderAndFilesExternal(
            widget.siteObject.siteName!,
            "",
            "",
            result.files,
          );
          context.read<PlansBloc>().add(
            CreateLevelOneFileFetch(
              levelId: 1,
              isWhatCreating: "file",
              folderName: fileName,
              siteId: widget.siteObject.id,
              filePath: file.path,
            ),
          );
          print("filepath :${file.path}");
        }
      }
    } catch (e) {
      Utility.showToast('Error uploading file: ${e.toString()}');
    }
  }

  void _showNameDialog(String title, String hint, Function(String) onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => BlocListener<PlansBloc, GlobalApiResponseState>(
            listenWhen: (previous, current) => current.status != previous.status,
            listener: (context, state) {
              switch (state.status) {
                case GlobalApiStatus.completed:
                  if (state is LevelOneCreateFileStateSuccess) {
                    Utility.showToast(state.data.message);
                    Navigator.of(context).pop();
                    triggerRefreshData();
                    onConfirm("confirmed");
                  }
                  break;
                case GlobalApiStatus.error:
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // triggerRefreshData();
                    ErrorHandler.errorHandle(state.message, "Server Error", context);
                  });
                  break;
                default:
                // Handle other states if needed
              }
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(title),
              content: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isNotEmpty) {
                      addFolder();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Create'),
                ),
              ],
            ),
          ),
    );
  }

  void triggerRefreshData() {
    context.read<PlansBloc>().add(
      DocumentLevelOneFetch(
        siteId: widget.siteObject.id,
        folderName: "document",
        levelNo: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlansBloc, GlobalApiResponseState>(
      listener: (context, state) {
        if (state.status == GlobalApiStatus.completed &&
            state is LevelOneCreateFileStateSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PlansBloc>().add(
              DocumentLevelOneFetch(
                siteId: widget.siteObject.id,
                folderName: "document",
                levelNo: 1,
              ),
            );
          });
        } else if (state.status == GlobalApiStatus.error) {
          /*Utility.showToast(state.message);*/
          // ErrorHandler.errorHandle(state.message, "Something wrong", context);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BottomNavScreen(
                    user: widget.user,
                    siteObject: widget.siteObject,
                  ),
            ),
          );
          return true;
        },
        child: Scaffold(
          drawer: getDrawerItems(context),
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: BlocBuilder<PlansBloc, GlobalApiResponseState>(
              builder: (context, state) {
                if (state.status == GlobalApiStatus.loading) {
                  return LevelOneLoadingScreen();
                } else if (state.status == GlobalApiStatus.completed) {
                  if (state is LevelOneDocumentStateSuccess) {
                    if (state.data.document.isNotEmpty) {
                      listOfDocument = state.data.document;
                      return getPlansView(listOfDocument);
                    } else {
                      return Center(
                        child: NoDataFound(
                          noDataFoundTxt: "Documents are not available",
                        ),
                      );
                    }
                  }
                } else if (state.status == GlobalApiStatus.error) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {

                  });
                }
                return getPlansView(listOfDocument);
              },
            ),
          ),
          floatingActionButton: _buildFloatingActionButton(),
        ),
      ),
    );
  }

  Widget getPlansView(List<Document> listItems) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          // _buildHeader(),
          SizedBox(height: 10),
          _buildTitleComponenet(),
          Expanded(
            child:
                _isGridView
                    ? _buildGridView(listItems)
                    : _buildListView(listItems),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleComponenet() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project Plans',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[800],
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                  HapticFeedback.selectionClick();
                },
                icon: Icon(
                  _isGridView ? Icons.view_list : Icons.grid_view,
                  color: AppColors.colorGray,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Document> projects) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20),
      child: MasonryGridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 8,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: _buildProjectCard(projects[index]),
          );
        },
      ),
    );
  }

  Widget _buildListView(List<Document> projects) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectListItem(projects[index]);
      },
    );
  }

  Widget _buildProjectCard(Document project) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.colorGray.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                if (project.isFile == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PlanDetailsScreen(
                        folderName: project.documentName!,
                        siteObject: widget.siteObject,
                        documentObj: project,
                      ),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(15),
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: AppColors.colorGray,
                            width: 0.5,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: buildFileImage(project.path),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Half of image height (90/2)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        "${project.documentName}",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            project.isFile == 1 ? Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: SvgPicture.asset("assets/svg/delete_icon.svg", width: 15, height: 15, color: Colors.red,)
                ),
              ),
            ): SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget buildFileImage(String? path) {
    if (path == null || path.isEmpty) {
      return Image.asset("assets/icons/folder.png", width: 90, height: 90);
    } else if (path.endsWith(".jpg") ||
        path.endsWith(".jpeg") ||
        path.endsWith(".png")) {
      return Image.network(
        "${ApiConstants.baseUrl}$path",
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/default_gallery_icon.png",
            width: 90,
            height: 90,
          );
        },
      );
    } else if (path.endsWith(".pdf")) {
      return Image.asset("assets/icons/icon_pdf.png", width: 90, height: 90);
    } else if (path.endsWith(".dwg")) {
      return Image.network(
        "${ApiConstants.baseUrl}${path}",
        width: 90,
        height: 90,
      );
    } else {
      return Image.asset("assets/icons/folder.png", width: 90, height: 90);
    }
  }

  Widget buildForListItems(String? path) {
    if (path == null || path.isEmpty) {
      return Image.asset("assets/icons/folder.png", width: 35, height: 35);
    } else if (path.endsWith(".jpg") ||
        path.endsWith(".jpeg") ||
        path.endsWith(".png")) {
      return Image.network(
        "${ApiConstants.baseUrl}$path",
        width: 35,
        height: 35,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/default_gallery_icon.png",
            width: 35,
            height: 35,
          );
        },
      );
    } else if (path.endsWith(".pdf")) {
      return Image.asset("assets/icons/pdf.png", width: 35, height: 35);
    } else if (path.endsWith(".dwg")) {
      return Image.network(
        "${ApiConstants.baseUrl}${path}",
        width: 35,
        height: 35,
      );
    } else {
      return Image.asset("assets/icons/folder.png", width: 40, height: 40);
    }
  }

  Widget _buildProjectListItem(Document project) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.colorGray, width: 0.5),
      ),
      child: ListTile(
        onTap: () {
          if (project.isFile == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PlanDetailsScreen(
                      folderName: project.documentName!,
                      siteObject: widget.siteObject,
                      documentObj: project,
                    ),
              ),
            );
          }
        },
        leading: buildFileImage(project.path),
        title: Text(
          "${project.documentName}",
          style: TextStyle(fontSize: 12, color: AppColors.colorBlack),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _showAddDialog,
      backgroundColor: AppColors.primary,
      elevation: 8,
      child: Icon(Icons.add, color: Colors.white, size: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  void addFolder() {
    final folderName = nameController.text.trim();
    if (folderName.isNotEmpty) {
      createFolderAndFilesExternal(
        widget.siteObject.siteName!,
        folderName,
        "",
        [],
      );
      context.read<PlansBloc>().add(
        CreateLevelOneFileFetch(
          levelId: 1,
          isWhatCreating: "folder",
          folderName: folderName,
          siteId: widget.siteObject.id,
          filePath: '',
        ),
      );
    }
    Navigator.of(context).pop();
  }
}
