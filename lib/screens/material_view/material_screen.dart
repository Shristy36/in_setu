import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/screens/material_view/tab_views/intend_content_screen.dart';
import 'package:in_setu/screens/material_view/tab_views/stock_content_screen.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/widgets/add_material_widget.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/updated_indent_material_widget.dart';

import '../project_list/model/AllSitesResponse.dart';

class StockManagementScreen extends StatefulWidget {
  final Data siteObject;

  const StockManagementScreen({super.key, required this.siteObject});

  @override
  _StockManagementScreenState createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen>
    with SingleTickerProviderStateMixin {
  String _activeTab = 'Stocks';
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();
  bool isReceived1 = false;
  bool isReceived2 = false;
  late TabController _tabController;
  List<SearchData> searchList = [];
  List<SearchUnitData> searchUnitList = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });

    context.read<MaterialStockBloc>().add(SearchKeywordEvent(searchText: '', requestType: ''),);
    context.read<MaterialStockBloc>().add(SearchUnitEvent(searchText: '', requestType: 'unit'),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerItems(context),
      floatingActionButton:
          _tabController.index == 0
              ? FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) => MaterialRequirementsPopup(
                          buttonTxt: "Add Material",
                          siteObject: widget.siteObject,
                          stockMaterialAdded: () {
                            context.read<MaterialStockBloc>().add(
                              MaterialStockFetchEvent(
                                siteId: widget.siteObject.id,
                              ),
                            );
                          },
                          searchDataList: searchList,
                          searchUnitData: searchUnitList
                        ),
                  );
                },
                tooltip: 'Add Stock',
                child: Icon(Icons.add, color: Colors.white),
              )
              : FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => UpdatedIndentMaterialWidget(),
                  );
                },
                tooltip: 'Add Indent',
                child: Icon(Icons.add, color: Colors.white),
              ),
      backgroundColor: Color(0xFFF5F5F5),
      body: BlocListener<MaterialStockBloc, GlobalApiResponseState>(
          listener: (context, state){
            switch (state.status) {
              case GlobalApiStatus.loading:
                break;
              case GlobalApiStatus.completed:
                LoadingDialog.hide(context);
                if(state is MaterialSearchKeywordStateSuccess){
                  searchList = state.data.data;
                }else if(state is SearchUnitStateSuccess){
                  searchUnitList = state.data.data;
                }

                break;
                case GlobalApiStatus.error:
                  LoadingDialog.hide(context);
                  FocusScope.of(context).unfocus();
                  ErrorHandler.errorHandle(
                      state.message, "Invalid Auth", context);
                  break;
              default:
                LoadingDialog.hide(context);
            }
          },
        child: getMaterialView(),
          ),
    );
  }

  Widget getMaterialView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5),
        child: Column(
          children: [
            // Header
            Column(
              children: [
                Column(children: [_buildTabBar()]),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.colorGray, width: 1),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged:
                          (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                        border: InputBorder.none,
                        isDense: true,
                        // Reduces the height for better alignment
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                        ), // Adjust as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  StockContentScreen(siteObject: widget.siteObject, searchDataList: searchList, searchUnitData: searchUnitList,),
                  IntendContentScreen(siteObject: widget.siteObject),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        dividerColor: Colors.white,
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.tabBarColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        labelColor: AppColors.primary,
        unselectedLabelColor: Color(0xFF6B7280),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        // Add these properties to make tabs equal width
        isScrollable: false,
        // This ensures tabs don't scroll and take equal space
        indicatorSize: TabBarIndicatorSize.tab,
        // Indicator matches tab width
        tabs: [Tab(text: 'Stocks'), Tab(text: 'Indents')],
      ),
    );
  }
}
