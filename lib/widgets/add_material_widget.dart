import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/share_preference_manager.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:intl/intl.dart';

import '../screens/project_list/model/AllSitesResponse.dart';

class MaterialRequirementsPopup extends StatefulWidget {
  final String buttonTxt;
  final Data siteObject;
  final VoidCallback stockMaterialAdded;
  final StocksData? initialStockData;
  final List<SearchData> searchDataList;
  final List<SearchUnitData> searchUnitData;

  const MaterialRequirementsPopup({
    Key? key,
    required this.buttonTxt,
    required this.siteObject,
    required this.searchDataList,
    required this.searchUnitData,
    required this.stockMaterialAdded,
    this.initialStockData,
  }) : super(key: key);

  @override
  State<MaterialRequirementsPopup> createState() =>
      _MaterialRequirementsPopupState();
}

class _MaterialRequirementsPopupState extends State<MaterialRequirementsPopup> {
  Color mainColor = Color(0xFFFBBF24);
  final deliveryDate = TextEditingController();
  final materialController = TextEditingController();
  final additionalMaterialController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final stockCreateFormKey = GlobalKey<FormState>();
  List<SearchData> searchDataList = [];
  List<SearchData> filteredSuggestions = [];
  List<SearchUnitData> searchUnitList = [];
  List<SearchUnitData> filteredUnitSuggestions = [];
  bool _isButtonEnabled = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';


  void _saveRequirements() {
    if (stockCreateFormKey.currentState!.validate()) {
      if (_isButtonEnabled) {
        setState(() {
          _isButtonEnabled = false;
        });
        if (widget.initialStockData == null) {
          context.read<MaterialStockBloc>().add(
            CreateStockEvent(
              siteId: widget.siteObject.id,
              requirement: materialController.text,
              additionalRequirement: additionalMaterialController.text,
              createDate: deliveryDate.text,
              unit: unitController.text,
              quantity: quantityController.text,
            ),
          );
        } else {
          context.read<MaterialStockBloc>().add(
            UpdateStockEvent(
              id: widget.initialStockData!.id,
              siteId: widget.siteObject.id,
              requirement: materialController.text,
              additionalRequirement: additionalMaterialController.text,
              createDate: deliveryDate.text,
              unit: unitController.text,
              quantity: quantityController.text,
            ),
          );
        }
      }
    }
  }

  @override
  void didUpdateWidget(covariant MaterialRequirementsPopup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchDataList != widget.searchDataList ||
        oldWidget.searchUnitData != widget.searchUnitData) {
      setState(() {
        searchDataList = widget.searchDataList;
        searchUnitList = widget.searchUnitData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    if (widget.initialStockData != null) {
      materialController.text = widget.initialStockData?.requirement1 ?? '';
      additionalMaterialController.text =
          widget.initialStockData?.requirement2 ?? '';
      quantityController.text = widget.initialStockData?.qty?.toString() ?? '';
      unitController.text = widget.initialStockData?.unit ?? '';
    }
  }

  Future<void> _loadSavedData() async {
    final savedSearchData = await SharedPreferenceManager.getSearchDataList();
    final savedUnitData = await SharedPreferenceManager.getSearchUnitDataList();

    setState(() {
      searchDataList =
      savedSearchData.isNotEmpty ? savedSearchData : widget.searchDataList;
      searchUnitList =
      savedUnitData.isNotEmpty ? savedUnitData : widget.searchUnitData;
    });
  }

  @override
  void dispose() {
    additionalMaterialController.removeListener(() {});
    additionalMaterialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: BlocListener<MaterialStockBloc, GlobalApiResponseState>(
          listener: (context, state) {
            switch (state.status) {
              case GlobalApiStatus.loading:
              // LoadingDialog.show(context, key: const ObjectKey("requesting sign in.."),);
                break;
              case GlobalApiStatus.completed:
                LoadingDialog.hide(context);
                if (state is CreateStockStateSuccess) {
                  Utility.showToast(state.data.message);
                  widget.stockMaterialAdded();
                  Navigator.of(context).pop();
                  setState(() {
                    _isButtonEnabled = true;
                  });
                }
                break;

              case GlobalApiStatus.error:
                LoadingDialog.hide(context);
                FocusScope.of(context).unfocus();
                ErrorHandler.errorHandle(
                  state.message,
                  "Invalid Auth",
                  context,
                );
                setState(() {
                  _isButtonEnabled = true;
                });
                break;

              default:
                setState(() {
                  _isButtonEnabled = true;
                });
                LoadingDialog.hide(context);
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.85,
            maxWidth: MediaQuery
                .of(context)
                .size
                .width * 0.95,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection(
                        title: 'Requirements',
                        subTitle: 'Additional Requirements',
                        icon: Icons.inventory_2_outlined,
                        isAdditional: false,
                        validator:
                            (value) =>
                        value?.isEmpty ?? true
                            ? 'Please enter requirement'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
        if (!_isButtonEnabled)
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
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
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Material Requirements',
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
    required String subTitle,
    required IconData icon,
    required bool isAdditional,
    String? Function(String?)? validator,
  }) {
    return Form(
      key: stockCreateFormKey,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: materialController,
              validator: validator,
              style: TextStyle(fontSize: 14, color: AppColors.colorGray),
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 14, color: AppColors.colorGray),
                labelText: 'Name of Material',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
                readOnly: true,
                validator: validator,
                controller: additionalMaterialController,
                style: TextStyle(fontSize: 14, color: AppColors.colorGray),
                decoration: InputDecoration(
                  labelText: 'Name of Material',
                  labelStyle: TextStyle(
                      fontSize: 14, color: AppColors.colorGray),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(10),
                      bottom: Radius.circular(
                        filteredSuggestions.isNotEmpty ? 0 : 10,
                      ),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(10),
                      bottom: Radius.circular(
                        filteredSuggestions.isNotEmpty ? 0 : 10,
                      ),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(10),
                      bottom: Radius.circular(
                        filteredSuggestions.isNotEmpty ? 0 : 10,
                      ),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  });
                  FocusScope.of(context).unfocus(); // Hide keyboard if active
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.colorWhite,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25)),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, bottomSheetSetState) {
                          return Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0,
                                        right: 15,
                                        left: 15,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                "Select Additional Material",
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.2),
                                                    borderRadius: BorderRadius
                                                        .circular(8),
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: AppColors.colorBlack,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(8),
                                              border: Border.all(
                                                  color: AppColors.colorGray,
                                                  width: 1),
                                            ),
                                            child: TextField(
                                              autofocus: false,
                                              controller: _searchController,
                                              onChanged: (value) {
                                                bottomSheetSetState(() {
                                                  _searchQuery = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                prefixIcon: Icon(Icons.search,
                                                    color: Colors.grey[500]),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets
                                                    .symmetric(
                                                    vertical: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: getSuggestionListItemsWithSearch(
                                        searchDataList),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      );
                    },
                  );
                }
            ),

            const SizedBox(height: 15),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: validator,
                      controller: quantityController,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray,
                        ),
                        labelText: 'Quantity',
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
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          readOnly: true,
                          // Prevent keyboard from showing
                          validator: validator,
                          controller: unitController,
                          style: TextStyle(fontSize: 14, color: AppColors
                              .colorGray),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14, color: AppColors.colorGray),
                            labelText: 'Unit',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          onTap: () {
                            setState(() {
                              _searchQuery = '';
                              _searchController.clear();
                            });
                            FocusScope.of(context).unfocus(); // Hide keyboard if active
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: AppColors.colorWhite,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                    return Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.7,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius
                                                  .vertical(
                                                  top: Radius.circular(25)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  right: 15,
                                                  left: 15,
                                                  bottom: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.all(
                                                            16),
                                                        child: Text(
                                                          "Select Unit",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight
                                                                  .normal),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(right: 10.0),
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              Navigator
                                                                  .of(context)
                                                                  .pop(),
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .all(8),
                                                            decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                  0.2),
                                                              borderRadius: BorderRadius
                                                                  .circular(8),
                                                            ),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color: AppColors
                                                                  .colorBlack,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .circular(8),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .colorGray,
                                                            width: 1),
                                                      ),
                                                      child: TextField(
                                                        autofocus: false,
                                                        controller: _searchController,
                                                        onChanged: (value) {
                                                          bottomSheetSetState(() {
                                                            _searchQuery =
                                                                value;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          hintText: 'Search',
                                                          prefixIcon: Icon(
                                                              Icons.search,
                                                              color: Colors
                                                                  .grey[500]),
                                                          border: InputBorder
                                                              .none,
                                                          isDense: true,
                                                          contentPadding: EdgeInsets
                                                              .symmetric(
                                                              vertical: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20.0, right: 15),
                                              child: searchunitList(searchUnitList),),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                            );
                          },
                        )

                        /*if (filteredUnitSuggestions.isNotEmpty)
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.colorGray),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredUnitSuggestions.length,
                              itemBuilder: (context, index) {
                                final unitData = filteredUnitSuggestions[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      unitController.text = unitData.name!;
                                      filteredUnitSuggestions.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        unitData.name!,
                                        style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /*Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    validator: validator,
                    controller: quantityController,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                      ),
                      labelText: 'Quantity',
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
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    validator: validator,
                    controller: unitController,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorGray
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorGray
                      ),
                      labelText: 'Unit',
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
                        filteredUnitSuggestions = searchUnitList
                            .where((item) =>
                            item.name!.toLowerCase().contains(
                                value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
            if (filteredUnitSuggestions.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: filteredUnitSuggestions.length,
                    itemBuilder: (context, index) {
                      final unitData = filteredUnitSuggestions[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              unitController.text = unitData.name!;
                              filteredUnitSuggestions.clear();
                            });
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                border: Border.all(
                                    color: AppColors.colorGray, width: 1)
                            ),
                            child: Center(
                              child: Text("${unitData.name}", style: TextStyle(
                                  fontSize: 12, color: AppColors.colorBlack),),
                            ),
                          ),
                        ),
                      );
                    }),
              ),*/
            const SizedBox(height: 15),
            TextFormField(
              validator: validator,
              controller: deliveryDate,
              style: TextStyle(fontSize: 14, color: AppColors.colorGray),
              readOnly: true,
              // Important - allows tap but prevents keyboard
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 14, color: AppColors.colorGray),
                labelText: 'Delivery Date',
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onTap: () async {
                FocusScope.of(
                  context,
                ).requestFocus(FocusNode()); // Remove keyboard focus
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
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => _saveRequirements(),
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.save, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                widget.buttonTxt,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSuggestionListItemsWithSearch(List<SearchData> searchDataList) {
    final searchFilterData = _searchQuery.isEmpty
        ? searchDataList
        : searchDataList.where((item) =>
        item.name!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    return ListView.builder(
      itemCount: searchFilterData.length,
      itemBuilder: (context, index) {
        final materialDataList = searchFilterData[index];
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: (){
                  setState(() {
                    additionalMaterialController.text = materialDataList.name ?? "";
                  });
                  Navigator.pop(context);
                },
                child: Text(materialDataList.name ?? "", style: TextStyle(fontSize: 16, color: AppColors.colorBlack),)),
          ),
        );
      },
    );
  }

  searchunitList(List<SearchUnitData> searchUnitList) {
    final searchFilterData = _searchQuery.isEmpty
        ? searchUnitList
        : searchUnitList.where((item) =>
        item.name!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    return ListView.builder(
      itemCount: searchFilterData.length,
      itemBuilder: (context, index) {
        final unitData = searchFilterData[index];
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(
                8.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    unitController.text =
                        unitData.name ?? "";
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  unitData.name ?? "",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors
                          .colorBlack),)),
          ),
        );
      },
    );
  }
}
