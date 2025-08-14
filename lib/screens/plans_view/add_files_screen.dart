import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/plans_view/bloc/plans_bloc.dart';
import 'package:in_setu/screens/plans_view/storageManager/create_folder.dart';
import 'package:in_setu/supports/utility.dart';

import '../project_list/model/AllSitesResponse.dart';

class AddFilesScreen extends StatefulWidget {
  final String folderName;
  final String subFolderName;
  final Data siteObject;
  const AddFilesScreen({super.key, required this.folderName, required this.siteObject, required this.subFolderName});

  @override
  State<AddFilesScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<AddFilesScreen> {
  bool _isGridView = true;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        title: Center(
          child: Text(
            widget.folderName,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.colorBlack),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 25, color: AppColors.colorBlack,),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Adapt Ganesh Height", style: TextStyle(color: AppColors.colorBlack, fontSize: 16),),
                          SizedBox(height: 5,),
                          Text("Adalaj Gujrat 03434444", style: TextStyle(color: AppColors.colorBlack, fontSize: 14),),
                        ],
                      ),
                    ),
                  )
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
                              fontWeight: FontWeight.bold,
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
                            color: Colors.grey[700],
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
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),

    );
  }

  /*Widget _buildGridView(List<Document> projects) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8,
            childAspectRatio: 0.80,
            // childAspectRatio: 0.85,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: _buildProjectCard(projects[index]),
            );
          },
        ),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            *//*if(project.isFile == 0){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlanDetailsScreen(
                    folderName: project.documentName!,
                    siteObject: widget.siteObject,
                  ),
                ),
              );
            }*//*
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
                      child: Image.asset(
                        "assets/icons/folder.png",
                        width: 90,
                        height: 90,
                      ) *//*buildFileImage(project.path)*//*,
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
                      fontSize: 16,
                      color: AppColors.colorBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

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
                  'Add File',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
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
          await createFolderAndFilesExternal(widget.siteObject.siteName!, widget.folderName ,widget.subFolderName, result.files);

          // context.read<PlansBloc>().add(
          //   CreateLevelSecondFileFetch(
          //     comingFromLevel: 2,
          //     isWhatCreating: "file",
          //     folderName: fileName,
          //     dirId: widget.documentObj.id,
          //     currentFolderName: widget.documentObj.documentName!,
          //     siteId: widget.siteObject.id,
          //     filePath: file.path,
          //   ),
          // );
          print("second filepath :${file.path}");
        }
      }
    } catch (e) {
      Utility.showToast('Error uploading file: ${e.toString()}');
    }
  }
  void addFolderAndFiles() {
    final newFolderName = nameController.text.trim();
    if (newFolderName.isNotEmpty) {
      createFolderAndFilesExternal(widget.siteObject.siteName!, widget.folderName, newFolderName, []);
    }
  }

}
