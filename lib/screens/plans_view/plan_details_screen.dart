import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/plans_view/add_files_screen.dart';
import 'package:in_setu/screens/plans_view/bloc/plans_bloc.dart';
import 'package:in_setu/screens/plans_view/loading_screens/level_one_loading_screen.dart';
import 'package:in_setu/screens/plans_view/model/DocumentLevelOneResponse.dart';
import 'package:in_setu/screens/plans_view/storageManager/create_folder.dart';
import 'package:in_setu/supports/utility.dart';

import '../project_list/model/AllSitesResponse.dart';

class PlanDetailsScreen extends StatefulWidget {
  final String folderName;
  final Data siteObject;
  final Document documentObj;

  const PlanDetailsScreen({
    super.key,
    required this.folderName,
    required this.siteObject,
    required this.documentObj,
  });

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  bool _isGridView = true;
  final nameController = TextEditingController();
  List<Document> listOfDocuments = [];

  @override
  void initState() {
    super.initState();
    context.read<PlansBloc>().add(
      DocumentLevelSecFetch(
        siteId: widget.siteObject.id,
        folderName: widget.folderName,
        levelNo: 2,
        dirId: widget.documentObj.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlansBloc, GlobalApiResponseState>(
      listener: (context, state) {
        if (state.status == GlobalApiStatus.completed &&
            state is LevelSecondCreateFileStateSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PlansBloc>().add(
              DocumentLevelSecFetch(
                siteId: widget.siteObject.id,
                folderName: widget.folderName,
                levelNo: 2,
                dirId: widget.documentObj.id,
              ),
            );
          });
        } else if (state.status == GlobalApiStatus.error) {
          ErrorHandler.errorHandle(state.message, "Something wrong", context);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Center(
            child: Text(
              widget.folderName,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.colorBlack),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: getSubPlanView(),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget getSubPlanView() {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 25, color: AppColors.colorBlack),
            ),
            SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adapt Ganesh Height",
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Adalaj Gujrat 03434444",
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
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
        ),
        Expanded(
          child: BlocBuilder<PlansBloc, GlobalApiResponseState>(
            builder: (context, state) {
              if (state.status == GlobalApiStatus.loading) {
                return LevelOneLoadingScreen();
              } else if (state.status == GlobalApiStatus.completed) {
                if (state is LevelSecDocumentStateSuccess) {
                  if (state.data.document.isNotEmpty) {
                    listOfDocuments = state.data.document;
                    return _buildGridView(listOfDocuments);
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
                  /*Utility.showToast(state.message);*/
                });
              }
              return _buildGridView(listOfDocuments);
            },
          ),
        ),
      ],
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
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (project.isFile == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AddFilesScreen(
                        folderName: widget.folderName,
                        subFolderName: project.documentName!,
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
          ): SizedBox.shrink()
        ],
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

  Widget _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 20),
      child: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: AppColors.primary,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
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

  void _showNameDialog(String title, String hint, Function(String) onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocListener<PlansBloc, GlobalApiResponseState>(
          listenWhen: (previous, current) => current.status != previous.status,
          listener: (context, state) {
            if (state.status == GlobalApiStatus.completed &&
                state is LevelSecondCreateFileStateSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Utility.showToast(state.data.message);
                Navigator.of(context).pop();
                triggerRefreshApi();
                onConfirm("confirmed");
              });
            } else if (state.status == GlobalApiStatus.error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                triggerRefreshApi();
                Navigator.of(context).pop();
              });
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
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
        );
      },
    );
  }

  void triggerRefreshApi() {
    context.read<PlansBloc>().add(
      DocumentLevelSecFetch(
        siteId: widget.siteObject.id,
        folderName: widget.folderName,
        levelNo: 2,
        dirId: widget.documentObj.id,
      ),
    );
  }

  void _addFile() async {
    final List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'dwg', 'pdf'];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
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
            widget.folderName,
            "",
            result.files,
          );

          context.read<PlansBloc>().add(
            CreateLevelSecondFileFetch(
              comingFromLevel: 2,
              isWhatCreating: "file",
              folderName: fileName,
              dirId: widget.documentObj.id,
              currentFolderName: widget.documentObj.documentName!,
              siteId: widget.siteObject.id,
              filePath: file.path,
            ),
          );
          print("second filepath :${file.path}");
        }
      }
    } catch (e) {
      Utility.showToast('Error uploading file: ${e.toString()}');
    }
  }

  void addFolder() {
    final newFolderName = nameController.text.trim();
    if (newFolderName.isNotEmpty) {
      createFolderAndFilesExternal(
        widget.siteObject.siteName!,
        widget.folderName,
        newFolderName,
        [],
      );
    }
    context.read<PlansBloc>().add(
      CreateLevelSecondFileFetch(
        comingFromLevel: 1,
        isWhatCreating: "folder",
        folderName: newFolderName,
        dirId: widget.documentObj.id,
        currentFolderName: widget.documentObj.documentName!,
        siteId: widget.siteObject.id,
        filePath: '',
      ),
    );
    Navigator.of(context).pop();
  }
}
