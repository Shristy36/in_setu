import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/mainpower_screen/bloc/man_power_bloc.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';

import '../screens/project_list/model/AllSitesResponse.dart';

class AddRequirementMemberItems {
  String name;
  String number;
  TextEditingController nameController;
  TextEditingController numberController;

  AddRequirementMemberItems({this.name = '', this.number = ''})
    : nameController = TextEditingController(text: name),
      numberController = TextEditingController(text: number);

  void dispose() {
    nameController.dispose();
    numberController.dispose();
  }
}

class AddManpowerWidget extends StatefulWidget {
  final Data siteObject;
  final VoidCallback manPowerAdded;
  final MainPowerData? existingManPower;

  const AddManpowerWidget({
    super.key,
    required this.siteObject,
    required this.manPowerAdded,
    this.existingManPower,
  });

  @override
  State<AddManpowerWidget> createState() => _AddManpowerWidgetState();
}

class _AddManpowerWidgetState extends State<AddManpowerWidget> {
  List<AddRequirementMemberItems> staffRequirements = [];
  List<AddRequirementMemberItems> manpowerRequirements = [];
  List<AddRequirementMemberItems> taskRequirements = [];

  final formKey = GlobalKey<FormState>();
  final agencyNameController = TextEditingController();

  void _addRequirement(bool isAdditional, String type) {
    setState(() {
      if (type == 'staff') {
        staffRequirements.add(AddRequirementMemberItems());
      } else if (type == 'manpower') {
        manpowerRequirements.add(AddRequirementMemberItems());
      } else if (type == 'task') {
        taskRequirements.add(AddRequirementMemberItems());
      }
    });
  }

  void _removeRequirement(bool isAdditional, int index, String type) {
    setState(() {
      if (type == 'staff' && staffRequirements.length > 1) {
        staffRequirements.removeAt(index);
      } else if (type == 'manpower' && manpowerRequirements.length > 1) {
        manpowerRequirements.removeAt(index);
      } else if (type == 'task' && taskRequirements.length > 1) {
        taskRequirements.removeAt(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.existingManPower != null) {
      agencyNameController.text = widget.existingManPower!.agencyName ?? '';

      // Initialize staff requirements
      staffRequirements =
          (widget.existingManPower!.staffs ?? []).map((staff) {
            return AddRequirementMemberItems(
              name: staff.memberName ?? '',
              number: staff.memberCount?.toString() ?? '',
            );
          }).toList();

      if (staffRequirements.isEmpty)
        staffRequirements.add(AddRequirementMemberItems());

      // Similar for manpower and task
      manpowerRequirements =
          (widget.existingManPower!.manpowers ?? []).map((manpower) {
            return AddRequirementMemberItems(
              name: manpower.memberName ?? '',
              number: manpower.memberCount?.toString() ?? '',
            );
          }).toList();

      if (manpowerRequirements.isEmpty)
        manpowerRequirements.add(AddRequirementMemberItems());

      taskRequirements =
          (widget.existingManPower!.tasks ?? []).map((task) {
            return AddRequirementMemberItems(
              name: task.taskName ?? '',
              number: '', // Tasks might not have numbers
            );
          }).toList();

      if (taskRequirements.isEmpty)
        taskRequirements.add(AddRequirementMemberItems());
    } else {
      staffRequirements = [AddRequirementMemberItems()];
      manpowerRequirements = [AddRequirementMemberItems()];
      taskRequirements = [AddRequirementMemberItems()];
    }
  }

  void _submitData() {
    final staffList =
        staffRequirements
            .map(
              (item) => {
                'member_name': item.name.trim(),
                'member_count': item.number.trim(),
              },
            )
            .toList();

    final manpowerList =
        manpowerRequirements
            .map(
              (item) => {
                'member_name': item.name.trim(),
                'member_count': item.number.trim(),
              },
            )
            .toList();

    final taskList =
        taskRequirements
            .map(
              (item) => {
                'task_name': item.name.trim(),
                'member_count': item.number.trim(),
              },
            )
            .toList();

    if (widget.existingManPower != null) {
      // Update existing record
      context.read<ManPowerBloc>().add(
        UpdateManPowerItemFetch(
          id: widget.existingManPower!.id!,
          siteId: widget.siteObject.id!,
          agencyName: agencyNameController.text,
          staffs: staffList,
          manPowers: manpowerList,
          tasks: taskList,
        ),
      );
    } else {
      // Create new record
      context.read<ManPowerBloc>().add(
        CreateManPowerItemFetch(
          siteId: widget.siteObject.id!,
          agencyName: agencyNameController.text,
          staffs: staffList,
          manPowers: manpowerList,
          tasks: taskList,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManPowerBloc, GlobalApiResponseState>(
      listener: (context, state) {
        switch (state.status) {
          case GlobalApiStatus.loading:
            // LoadingDialog.show(context, key: const ObjectKey("requesting sign in.."),);
            break;
          case GlobalApiStatus.completed:
            LoadingDialog.hide(context);
            if (state is CreateManPowerStateSuccess) {
              Utility.showToast(state.data.message);
              widget.manPowerAdded();
              Navigator.of(context).pop();
            }
            break;

          case GlobalApiStatus.error:
            LoadingDialog.hide(context);
            FocusScope.of(context).unfocus();
            ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
            break;

          default:
            LoadingDialog.hide(context);
        }
      },
      child: _buildManPowerWidget(),
    );
  }

  Widget _buildManPowerWidget() {
    return Material(
      color: Colors.black54,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
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
                      child: _addManpowerItems()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Add Manpower Report',
              style: TextStyle(
                color: AppColors.colorBlack,
                fontSize: 16,
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

  Widget _addManpowerItems() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter agency name";
                      }else if(value.length < 4 || value.length > 100) {
                        return "Agency Name is Required must be between 4 and 100 characters";
                      }
                      return null;
                    },
                    controller: agencyNameController,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.colorGray,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Name of agency',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      prefixIcon: Icon(
                        Icons.people_sharp,
                        color: Colors.grey.shade600,
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
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: _buildStaffSection(
                      items: staffRequirements,
                      isAdditional: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: _buildManPowerSection(
                      items: manpowerRequirements,
                      isAdditional: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: _buildTaskSection(
                      items: taskRequirements,
                      isAdditional: false,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _submitData();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }

  Widget _buildStaffSection({
    required List<AddRequirementMemberItems> items,
    required bool isAdditional,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Staff",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          AddRequirementMemberItems item = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  if (items.length > 1)
                    GestureDetector(
                      onTap:
                          () =>
                              _removeRequirement(isAdditional, index, "staff"),
                      child:
                          index == items.length - 1 && items.length > 1
                              ? CircleAvatar(
                                backgroundColor: Colors.red.shade50,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red.shade600,
                                  size: 16,
                                ),
                              )
                              : const SizedBox.shrink(),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter staff name";
                        }
                        return null;
                      },
                      controller: item.nameController,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                        ),
                        labelText: 'Member name',
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
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          item.name = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter staff number";
                        }
                        return null;
                      },
                      controller: item.numberController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelText: 'No',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
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
                          item.number = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          );
        }).toList(),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => {
            if(formKey.currentState!.validate()){
              _addRequirement(isAdditional, "staff")
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Add Staff',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManPowerSection({
    required List<AddRequirementMemberItems> items,
    required bool isAdditional,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Man Power",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          AddRequirementMemberItems item = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  if (items.length > 1)
                    GestureDetector(
                      onTap:
                          () => _removeRequirement(
                            isAdditional,
                            index,
                            "manpower",
                          ),
                      child: index == items.length - 1 && items.length > 1
                          ? CircleAvatar(
                        backgroundColor: Colors.red.shade50,
                        child: Icon(
                          Icons.remove,
                          color: Colors.red.shade600,
                          size: 16,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter manpower name";
                        }
                        return null;
                      },
                      controller: item.nameController,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                        ),
                        labelText: 'Manpower name',
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
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          item.name = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter manpower number";
                        }
                        return null;
                      },
                      controller: item.numberController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                        ),
                        labelText: 'No',
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
                          item.number = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          );
        }).toList(),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => {
            if(formKey.currentState!.validate()){
              _addRequirement(isAdditional, "manpower")
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Add Manpower',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskSection({
    required List<AddRequirementMemberItems> items,
    required bool isAdditional,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          AddRequirementMemberItems item = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  if (items.length > 1)
                    GestureDetector(
                      onTap:
                          () =>
                              _removeRequirement(isAdditional, index, "task"),
                      child: index == items.length - 1 && items.length > 1
                          ? CircleAvatar(
                        backgroundColor: Colors.red.shade50,
                        child: Icon(
                          Icons.remove,
                          color: Colors.red.shade600,
                          size: 16,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter task name";
                        }
                        return null;
                      },
                      controller: item.nameController,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                        ),
                        labelText: 'Task name',
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
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          item.name = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          );
        }).toList(),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => {
            if(formKey.currentState!.validate()){
              _addRequirement(isAdditional, "task")
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Add Task',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    agencyNameController.dispose();
    for (var item in staffRequirements) {
      item.dispose();
    }
    for (var item in manpowerRequirements) {
      item.dispose();
    }
    for (var item in taskRequirements) {
      item.dispose();
    }
    super.dispose();
  }
}
