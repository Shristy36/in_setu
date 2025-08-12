import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/plans_view/storageManager/create_folder.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/screens/project_list/bloc/sites_bloc.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:permission_handler/permission_handler.dart';

class AddSiteModal extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSiteAdded;
  final Data? siteObject;

  const AddSiteModal({
    Key? key,
    required this.onClose,
    required this.onSiteAdded,
    this.siteObject,
  }) : super(key: key);

  @override
  _AddSiteModalState createState() => _AddSiteModalState();
}

class _AddSiteModalState extends State<AddSiteModal> {
  final _formKey = GlobalKey<FormState>();
  final _siteNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _companyController = TextEditingController();
  File? _siteImg;
  bool isButtonClick = true;

  @override
  void initState() {
    super.initState();
    if (widget.siteObject != null) {
      final site = widget.siteObject!;
      _siteNameController.text = site.siteName ?? '';
      _locationController.text = site.siteLocation ?? '';
      _companyController.text = site.companyName ?? '';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _siteImg = File(image.path);
      });
    } else {
      // User canceled
      debugPrint('No image selected.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: BlocListener<SitesBloc, GlobalApiResponseState>(
        listener: (context, state) async {
          switch (state.status) {
            case GlobalApiStatus.loading:
              // LoadingDialog.show(context, key: const ObjectKey("requesting add site.."));
              break;

            case GlobalApiStatus.completed:
              LoadingDialog.hide(context);
              if (state is SitesCreateStateSuccess) {
                widget.onSiteAdded();
                Utility.showToast(state.data!.message);
                Navigator.of(context).pop(true);
                setState(() {
                  isButtonClick = true;
                });
              }
              else if (state is SiteUpdateStateSuccess) {
                widget.onSiteAdded();
                Utility.showToast(state.data!.message);
                Navigator.of(context).pop(true);
                setState(() {
                  isButtonClick = true;
                });
              }
              break;

            case GlobalApiStatus.error:
              LoadingDialog.hide(context);
              widget.onSiteAdded();
              ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
              setState(() {
                isButtonClick = true;
              });
              break;

            default:
              setState(() {
                isButtonClick = true;
              });
              LoadingDialog.hide(context);
          }
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildModalHeader(),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            _buildImageUploadSection(),
                            SizedBox(height: 24),
                            _buildInputField(
                              label: 'Site Name',
                              controller: _siteNameController,
                              icon: Icons.location_city_rounded,
                              validator: (value) => value?.isEmpty ?? true ? 'Please enter site name' : null,
                            ),
                            SizedBox(height: 20),
                            _buildInputField(
                              label: 'Site Location',
                              controller: _locationController,
                              icon: Icons.location_on_rounded,
                              validator: (value) => value?.isEmpty ?? true ? 'Please enter site location' : null,
                            ),
                            SizedBox(height: 20),
                            _buildInputField(
                              label: 'Company Name',
                              controller: _companyController,
                              icon: Icons.business_rounded,
                              validator: (value) => value?.isEmpty ?? true ? 'Please enter company name' : null,
                            ),
                            SizedBox(height: 32),
                            _buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isButtonClick)
            if (!isButtonClick)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Processing...",
                            style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

  Widget _buildModalHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.siteObject != null ? 'Edit Site' : 'Add New Site',
              style: TextStyle(
                color: AppColors.colorBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                  Icons.close, color: AppColors.colorBlack, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE2E8F0), width: 2),
      ),
      child: _siteImg != null
          ? GestureDetector(
        onTap: () => _pickImage()/*_handleImageSource(context, ImageSource.gallery)*/,
        child: Image.file(_siteImg!, fit: BoxFit.cover),
      )
          : Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _pickImage()/*_handleImageSource(context, ImageSource.gallery)*/,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cloud_upload_rounded, color: Color(0xFF64748B), size: 32),
              ),
              SizedBox(height: 12),
              Text(
                'Upload Site Image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
              ),
              SizedBox(height: 4),
              Text('Tap to select an image', style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF1E293B))),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE2E8F0)),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: TextStyle(fontSize: 14, color: AppColors.colorGray),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontSize: 14,
                color: AppColors.colorGray,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintText: 'Enter $label',
              hintStyle: TextStyle(color: Color(0xFF94A3B8)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if(isButtonClick){
                      setState(() {
                        isButtonClick = false;
                      });
                      if (widget.siteObject == null) {
                        createFolderAndFilesExternal(_siteNameController.text, "","", []);
                        context.read<SitesBloc>().add(CreateSiteProject(
                          siteName: _siteNameController.text,
                          siteLocation: _locationController.text,
                          companyName: _companyController.text,
                          image: _siteImg,
                        ));
                      } else {
                        context.read<SitesBloc>().add(SiteProjectUpdate(
                          widget.siteObject!.id,
                          _siteNameController.text,
                          _locationController.text,
                          _companyController.text,
                          _siteImg,
                        ));
                      }
                    }
                  }
                },
                child: Center(
                  child: Text(
                    'Add Site',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> showPermissionRationaleDialog(
      BuildContext context, {
        required String title,
        required String message,
        required Permission permission,
      }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(child: Text('Deny'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: Text('Allow'),
            onPressed: () async {
              await permission.request();
              Navigator.pop(context);

            },
          ),
        ],
      ),
    );
  }
}
