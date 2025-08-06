import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
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
  List<ProjectItem> projects = [
    ProjectItem(
      name: 'Architectural',
      type: ProjectType.folder,
      icon: "assets/icons/folder.png"/*Icons.architecture*/,
      color: Colors.blue,
      fileCount: 24,
    ),
    ProjectItem(
      name: 'Structural',
      type: ProjectType.folder,
      icon: "assets/icons/folder.png"/*Icons.construction*/,
      color: Colors.orange,
      fileCount: 18,
    ),
    ProjectItem(
      name: 'MEP',
      type: ProjectType.folder,
      icon: "assets/icons/folder.png"/*Icons.electrical_services*/,
      color: Colors.green,
      fileCount: 12,
    ),
    ProjectItem(
      name: 'Screenshot_2025',
      type: ProjectType.folder,
      icon: "assets/icons/gallery.png"/*Icons.construction*/,
      color: Colors.orange,
      fileCount: 1,
    ),
  ];

  bool _isGridView = true;
  late AnimationController _fabAnimationController;
  late AnimationController _searchAnimationController;
  bool _isSearchVisible = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _searchAnimationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _searchAnimationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });
    if (_isSearchVisible) {
      _searchAnimationController.forward();
    } else {
      _searchAnimationController.reverse();
      _searchController.clear();
    }
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
      setState(() {
        projects.add(
          ProjectItem(
            name: name,
            type: ProjectType.folder,
            icon: "assets/icons/folder.png",
            color: Colors.primaries[projects.length % Colors.primaries.length],
            fileCount: 0,
          ),
        );
      });
      HapticFeedback.lightImpact();
      _showSnackBar('Folder "$name" created successfully', Colors.green);
    });
  }

  void _addFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        allowedExtensions: null,
      );

      if (result != null) {
        for (PlatformFile file in result.files) {
          String fileName = file.name;
          String fileExtension = fileName.split('.').last.toLowerCase();

          setState(() {
            projects.add(
              ProjectItem(
                name: fileName,
                type: ProjectType.file,
                icon: _getFileIcon(fileExtension),
                color: _getFileColor(fileExtension),
                fileCount: 0,
                filePath: file.path,
                fileSize: file.size,
              ),
            );
          });
        }

        HapticFeedback.lightImpact();
        String message =
            result.files.length == 1
                ? 'File "${result.files.first.name}" uploaded successfully'
                : '${result.files.length} files uploaded successfully';
        _showSnackBar(message, Colors.green);
      }
    } catch (e) {
      _showSnackBar('Error uploading file: ${e.toString()}', Colors.red);
    }
  }

  /*IconData*/ String _getFileIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return "assets/icons/pdf.png"/*Icons.picture_as_pdf*/;
      case 'doc':
      case 'docx':
        return "assets/icons/docs.png"/*Icons.description*/;
      case 'xls':
      case 'xlsx':
        return "assets/icons/folder.png"/*Icons.table_chart*/;
      case 'ppt':
      case 'pptx':
        return "assets/icons/folder.png"/*Icons.slideshow*/;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return "assets/icons/gallery.png"/*Icons.image*/;
      case 'mp4':
      case 'avi':
      case 'mov':
        return "assets/icons/folder.png"/*Icons.video_file*/;
      case 'mp3':
      case 'wav':
      case 'aac':
        return "assets/icons/folder.png"/*Icons.audio_file*/;
      case 'zip':
      case 'rar':
      case '7z':
        return "assets/icons/folder.png"/*Icons.archive*/;
      case 'dwg':
      case 'dxf':
        return "assets/icons/folder.png"/*Icons.architecture*/;
      default:
        return "assets/icons/folder.png"/*Icons.insert_drive_file*/;
    }
  }

  Color _getFileColor(String extension) {
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Colors.purple;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Colors.indigo;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Colors.pink;
      case 'zip':
      case 'rar':
      case '7z':
        return Colors.brown;
      case 'dwg':
      case 'dxf':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _showNameDialog(String title, String hint, Function(String) onConfirm) {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
                    Navigator.pop(context);
                    onConfirm(nameController.text.trim());
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
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ProjectItem> filteredProjects =
        projects.where((project) {
          return project.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
        }).toList();

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavScreen(user: widget.user, siteObject: widget.siteObject,)));
        return true;
      },
      child: Scaffold(
        drawer: getDrawerItems(context),
        backgroundColor: Color(0xFFF5F5F5),
        body: SafeArea(
          child: Column(
            children: [
              // _buildHeader(),
              _buildTitleComponenet(),
              _buildSearchBar(),
              Expanded(
                child:
                    _isGridView
                        ? _buildGridView(filteredProjects)
                        : _buildListView(filteredProjects),
              ),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildTitleComponenet() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          // Container(
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.blue[400]!, Colors.blue[600]!],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.blue.withOpacity(0.3),
          //         blurRadius: 8,
          //         offset: Offset(0, 4),
          //       ),
          //     ],
          //   ),
          //   child: Icon(Icons.work_outline, color: Colors.white, size: 28),
          // ),
          // SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project Plans',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '${projects.length} items',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Row(
            children: [
          /*    IconButton(
                onPressed: _toggleSearch,
                icon: Icon(
                  _isSearchVisible ? Icons.close : Icons.search,
                  color: Colors.grey[700],
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                ),
              ),
           */
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
    );
  }

  Widget _buildSearchBar() {
    return AnimatedBuilder(
      animation: _searchAnimationController,
      builder: (context, child) {
        return Container(
          height: _isSearchVisible ? 60 : 0,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Opacity(
            opacity: _searchAnimationController.value,
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search projects...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<ProjectItem> projects) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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
    );
  }

  Widget _buildListView(List<ProjectItem> projects) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectListItem(projects[index]);
      },
    );
  }

  Widget _buildProjectCard(ProjectItem project) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.tabBarColor, width: 0.5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onProjectTap(project),
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              clipBehavior: Clip.none, // Allows overflow
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 55), // Half of image height (90/2)
                    SizedBox(
                      height: 20,
                      child: Align(alignment: Alignment.center,child: Utility.subTitle(project.name, AppColors.colorBlack)),
                    ),
                  ],
                ),
                // Image positioned to overlap 50% outside
                Positioned(
                  top: -45, // Negative value to move it up (half of image height)
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Image.asset(project.icon, width: 90, height: 90),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectListItem(ProjectItem project) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        /*boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],*/
      ),
      child: ListTile(
        onTap: () => _onProjectTap(project),
        leading: Image.asset(project.icon, width: 40, height: 40,),
        title: Text(
          project.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.type == ProjectType.folder
                  ? '${project.fileCount} files'
                  : 'File',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            if (project.type == ProjectType.file &&
                project.formattedFileSize.isNotEmpty)
              Text(
                project.formattedFileSize,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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

  void _onProjectTap(ProjectItem project) {
    HapticFeedback.selectionClick();
    // Handle project tap - navigate to project details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${project.name}'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }
}

enum ProjectType { folder, file }

class ProjectItem {
  final String name;
  final ProjectType type;
  // final IconData icon;
  final String icon;
  final Color color;
  final int fileCount;
  final String? filePath;
  final int? fileSize;

  ProjectItem({
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
    required this.fileCount,
    this.filePath,
    this.fileSize,
  });

  String get formattedFileSize {
    if (fileSize == null) return '';

    if (fileSize! < 1024) {
      return '${fileSize} B';
    } else if (fileSize! < 1024 * 1024) {
      return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    } else if (fileSize! < 1024 * 1024 * 1024) {
      return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(fileSize! / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}
