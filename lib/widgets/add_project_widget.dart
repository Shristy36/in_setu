import 'package:flutter/material.dart';

class AddSiteModal extends StatefulWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onClose;

  const AddSiteModal({
    Key? key,
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.slideAnimation,
    required this.onClose,
  }) : super(key: key);

  @override
  _AddSiteModalState createState() => _AddSiteModalState();
}

class _AddSiteModalState extends State<AddSiteModal> {
  final _formKey = GlobalKey<FormState>();
  final _siteNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _companyController = TextEditingController();
  bool _hasSelectedImage = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.opacityAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.opacityAnimation,
          child: SlideTransition(
            position: widget.slideAnimation,
            child: ScaleTransition(
              scale: widget.scaleAnimation,
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.85,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
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
                                SizedBox(height: 20),
                                _buildImageUploadSection(),
                                SizedBox(height: 24),
                                _buildInputField(
                                  label: 'Site Name',
                                  controller: _siteNameController,
                                  icon: Icons.location_city_rounded,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter site name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                _buildInputField(
                                  label: 'Site Location',
                                  controller: _locationController,
                                  icon: Icons.location_on_rounded,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter site location';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                _buildInputField(
                                  label: 'Company Name',
                                  controller: _companyController,
                                  icon: Icons.business_rounded,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter company name';
                                    }
                                    return null;
                                  },
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add_location_alt_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Add New Site',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.close_rounded, color: Colors.white),
              onPressed: widget.onClose,
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
        color: _hasSelectedImage ? Color(0xFFE0F2FE) : Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _hasSelectedImage ? Color(0xFF0EA5E9) : Color(0xFFE2E8F0),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            setState(() {
              _hasSelectedImage = !_hasSelectedImage;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      _hasSelectedImage ? Color(0xFF0EA5E9) : Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _hasSelectedImage
                      ? Icons.check_rounded
                      : Icons.cloud_upload_rounded,
                  color: _hasSelectedImage ? Colors.white : Color(0xFF64748B),
                  size: 32,
                ),
              ),
              SizedBox(height: 12),
              Text(
                _hasSelectedImage ? 'Image Selected!' : 'Upload Site Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      _hasSelectedImage ? Color(0xFF0EA5E9) : Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 4),
              Text(
                _hasSelectedImage
                    ? 'Tap to change image'
                    : 'Tap to select an image',
                style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              ),
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
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
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
            style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              prefixIcon: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
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
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: widget.onClose,
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB800).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle form submission
                    widget.onClose();
                  }
                },
                child: Center(
                  child: Text(
                    'Add Site',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
