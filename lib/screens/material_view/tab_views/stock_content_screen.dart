import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/screens/material_view/stock_details_screen.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/screens/material_view/delete_intent_item_dialog/delete_stock_item.dart';
import 'package:in_setu/screens/material_view/loading_screen.dart';
import 'package:in_setu/screens/material_view/material_stock_summary_screen.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/widgets/add_material_widget.dart';
import 'package:in_setu/widgets/intent_management.dart';

import '../delete_intent_item_dialog/delete_intent_dialog.dart';

class StockContentScreen extends StatefulWidget {
  final Data siteObject;
  final List<SearchData> searchDataList;
  final List<SearchUnitData> searchUnitData;
  const StockContentScreen({super.key, required this.siteObject, required this.searchDataList, required this.searchUnitData});

  @override
  State<StockContentScreen> createState() => _StockContentScreenState();
}

class _StockContentScreenState extends State<StockContentScreen> {
  bool _isLoading = true;
  List<StockItem> stockItems = [
    StockItem(
      id: 1,
      createdBy: 'Abubakar',
      stockIn: 99999,
      stockOut: 99999,
      remainingStock: 150,
      unit: 'KG',
      openingStock: 200,
      closingStock: 150,
      transferred: 0,
      totalReceived: 99999,
    ),
    StockItem(
      id: 2,
      createdBy: 'Rahul',
      stockIn: 50000,
      stockOut: 25000,
      remainingStock: 75,
      unit: 'KG',
      openingStock: 100,
      closingStock: 75,
      transferred: 25,
      totalReceived: 50000,
    ),
    StockItem(
      id: 3,
      createdBy: 'Priya',
      stockIn: 75000,
      stockOut: 30000,
      remainingStock: 120,
      unit: 'KG',
      openingStock: 150,
      closingStock: 120,
      transferred: 30,
      totalReceived: 75000,
    ),
    StockItem(
      id: 4,
      createdBy: 'Amit',
      stockIn: 40000,
      stockOut: 15000,
      remainingStock: 85,
      unit: 'KG',
      openingStock: 100,
      closingStock: 85,
      transferred: 15,
      totalReceived: 40000,
    ),
  ];


  void _handleStockIn(int itemId) {
    setState(() {
      final item = stockItems.firstWhere((item) => item.id == itemId);
      item.stockIn += 1000;
      item.remainingStock += 10;
    });
  }

  void _handleStockOut(int itemId) {
    setState(() {
      final item = stockItems.firstWhere((item) => item.id == itemId);
      if (item.remainingStock > 0) {
        item.stockOut += 1000;
        item.remainingStock =
            (item.remainingStock - 10).clamp(0, double.infinity).toInt();
      }
    });
  }


  List<StocksData> stockItemsList = [];

  @override
  void initState() {
    super.initState();
    context.read<MaterialStockBloc>().add(MaterialStockFetchEvent(siteId: widget.siteObject.id));
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialStockBloc, GlobalApiResponseState>(
      listener: (context, state) {
        switch (state.status) {
          case GlobalApiStatus.loading:
            setState(() => _isLoading = true);
            break;
          case GlobalApiStatus.completed:
            if (state is MaterialStockStateSuccess) {
              setState(() {
                _isLoading = false;
                stockItemsList = state.data.stocksData!;
              });
            }
            break;
          case GlobalApiStatus.error:
            setState(() => _isLoading = false);
            ErrorHandler.errorHandle(
              state.message,
              "Something wrong",
              context,
            );
            break;
          default:
            setState(() => _isLoading = false);
        }
      },
      child: _isLoading ? LoadingScreen() : getStockDetails(stockItemsList),
    );
  }
  Widget getStockDetails(List<StocksData> stockList){
    return stockList.isEmpty ? NoDataFound(noDataFoundTxt: "No Stock Data Found") : Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: stockItemsList.length,
            itemBuilder: (context, index) {
              return _buildStockItemCard(stockItems[index], stockItemsList[index]);
            },
          ),
        ),
      ],
    );
  }
  Widget _buildStockItemCard(StockItem item, StocksData stockData) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailsScreen(stockData: stockData, siteObject: widget.siteObject)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action buttons row
                  Row(
                    children: [
                      Icon(Icons.copy_outlined, color: Colors.blue, size: 20),
                      SizedBox(width: 12),
                      GestureDetector(
                          onTap: ()=> {
                            showDialog(context: context, builder: (context) =>
                                MaterialRequirementsPopup(
                                  buttonTxt: "Update Material", siteObject: widget.siteObject, stockMaterialAdded: (){
                              context.read<MaterialStockBloc>().add(MaterialStockFetchEvent(siteId: widget.siteObject.id));
                            },initialStockData: stockData, searchDataList: widget.searchDataList, searchUnitData: widget.searchUnitData,))
                          },
                          child: SvgPicture.asset(
                            "assets/svg/edit_btn.svg",
                            width: 20,
                            height: 20,
                            color: AppColors.colorBlack,
                          ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                          onTap: ()async {
                            final delete = await DeleteStockItem.showDeleteManPowerDialog(
                                context,
                                siteDeleteMsg,
                                siteDeleteTitle,
                                stockData.id,
                            );
                            if(delete){
                              context.read<MaterialStockBloc>().add(MaterialStockFetchEvent(siteId: widget.siteObject.id));
                            }
                          },
                          child: Icon(Icons.delete_outline, color: Colors.red, size: 20)),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Created by
                  Text(
                    '${stockData.requirement1}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // Stock numbers
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Stock IN:- ',
                                style: TextStyle(color: Colors.grey[600]),
                                children: [
                                  TextSpan(
                                    text: '${item.stockIn}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Stock OUT:- ',
                                style: TextStyle(color: Colors.grey[600]),
                                children: [
                                  TextSpan(
                                    text: '${item.stockOut}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Buttons and remaining stock
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () => _handleStockIn(item.id),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'IN',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _handleStockOut(item.id),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.green, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'OUT',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Remaining Stock',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            '${item.remainingStock} ${item.unit}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded details
            if (item.isExpanded) _buildExpandedDetails(item),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedDetails(StockItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '( Additional Details )',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          Text(
            'Stocks',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          // Stock details table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Opening Stock',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(width: 1, height: 20, color: Colors.grey[300]),
                      Expanded(
                        child: Text(
                          'Closing Stock',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.openingStock}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(width: 1, height: 20, color: Colors.grey[300]),
                      Expanded(
                        child: Text(
                          '${item.closingStock}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Transferred',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${item.transferred}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: Colors.grey[300]),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Total Received',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${item.totalReceived}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Indent Material'), behavior: SnackBarBehavior.floating,));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'INDENT\nMATERIAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Update Consumption'), behavior: SnackBarBehavior.floating,),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'UPDATE\nCONSUMPTION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialStockSummaryScreen()));
              /*ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Stock Summary')));*/
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFFBBF24), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              'STOCK SUMMARY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFBBF24),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
