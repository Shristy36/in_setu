import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:intl/intl.dart';

class IndentsMaterialRequirement {
  String material;
  String quantity;
  String unit;

  IndentsMaterialRequirement({
    this.material = '',
    this.quantity = '',
    this.unit = '',
  });
}

class UpdatedIndentMaterialWidget extends StatefulWidget {
  const UpdatedIndentMaterialWidget({super.key});

  @override
  State<UpdatedIndentMaterialWidget> createState() =>
      _UpdatedIndentMaterialWidgetState();
}

class _UpdatedIndentMaterialWidgetState
    extends State<UpdatedIndentMaterialWidget> {
  List<IndentsMaterialRequirement> indentsMaterialRequirement = [
    IndentsMaterialRequirement(),
  ];
  final specificationDetailsTxtCntl = TextEditingController();
  final purposeTxtCntl = TextEditingController();
  final deliveryDate = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _addRequirement(bool isAdditional) {
    setState(() {
      indentsMaterialRequirement.add(IndentsMaterialRequirement());
    });
  }

  void _removeRequirement(bool isAdditional, int index) {
    setState(() {
      if (indentsMaterialRequirement.length > 1) {
        indentsMaterialRequirement.removeAt(index);
      }
    });
  }

  void _saveRequirements() {
    // Handle save logic here
    print(
      'indentsMaterialRequirement: ${indentsMaterialRequirement.map((r) => '${r.material}: ${r.quantity} ${r.unit}').join(', ')}',
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                              width: 1,
                              color: AppColors.primary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildSection(
                              title: 'Additional Requirements',
                              icon: Icons.add_box_outlined,
                              items: indentsMaterialRequirement,
                              isAdditional: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            TextFormField(
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter specification';
                                }
                                return null;
                              },
                              controller: specificationDetailsTxtCntl,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorGray,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Specification',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorGray,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter purpose';
                                }
                                return null;
                              },
                              controller: purposeTxtCntl,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorGray,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorGray,
                                ),
                                labelText: 'Purpose',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter delivery date';
                                }
                                return null;
                              },
                              controller: deliveryDate,
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorGray,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorGray,
                                ),
                                labelText: 'Delivery Date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey.shade600,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(
                                  FocusNode(),
                                ); // Remove keyboard focus
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate = DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(pickedDate);
                                  setState(() {
                                    deliveryDate.text = formattedDate;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: ()=>{
                                if(formKey.currentState!.validate()){
                                  Navigator.of(context).pop()
                                }
                              },
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Additional Requirement',
              style: TextStyle(
                color: AppColors.colorBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
                Icons.close,
                color: AppColors.colorBlack,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<IndentsMaterialRequirement> items,
    required bool isAdditional,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          IndentsMaterialRequirement item = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    if (items.length > 1)
                      GestureDetector(
                        onTap: () => _removeRequirement(isAdditional, index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.red.shade600,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter material name';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 14, color: AppColors.colorGray),
                  decoration: InputDecoration(
                    labelText: 'Name of Material',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.colorGray,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      item.material = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter quantity';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorGray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            item.quantity = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorGray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue.shade400,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            item.unit = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10),
          child: GestureDetector(
            onTap: () => {
              if(formKey.currentState!.validate()){
                _addRequirement(isAdditional)
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Add More',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
