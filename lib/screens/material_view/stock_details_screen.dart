import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/widget/update_stock_consumption.dart';
import 'package:in_setu/supports/utility.dart';
import '../project_list/model/AllSitesResponse.dart';

class StockDetailsScreen extends StatefulWidget {
  final StocksData stockData;
  final Data siteObject;
  const StockDetailsScreen({super.key, required this.stockData, required this.siteObject});

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  List<StockSummeryModel> stockSummeryList = [
    StockSummeryModel(name: "Abubakar Kalmani", date: "17/04/2024", time: "12:30 am", inward: "100", outward: "50", total: "50"),
    StockSummeryModel(name: "Khurshid", date: "17/04/2024", time: "12:30 am", inward: "250", outward: "50", total: "200"),
    StockSummeryModel(name: "Abubakar Kalmani", date: "17/04/2024", time: "12:30 am", inward: "100", outward: "50", total: "50"),
    StockSummeryModel(name: "Khurshid", date: "17/04/2024", time: "12:30 am", inward: "250", outward: "50", total: "200"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Utility.title("${widget.siteObject.siteName}", AppColors.colorWhite),
        iconTheme: IconThemeData(color: AppColors.colorWhite),
      ),
      backgroundColor: AppColors.colorWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Material Name: ${widget.stockData.requirement1}", style: TextStyle(fontSize: 16, color: AppColors.colorBlack)),
            SizedBox(height: 10),
            Align(alignment: Alignment.center,child: Text('Stocks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            SizedBox(height: 12),
            _buildStockSummaryBox(),
            SizedBox(height: 16),
            _buildActionButtons(),
            SizedBox(height: 16),
            _buildStockSummaryTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildStockSummaryBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _stockRow('Opening Stock', '99999 Units', 'Closing Stock', '999999 Units'),
          _stockRow('Transferred', '99999 Units', 'Total Received', '999999 Units'),
        ],
      ),
    );
  }

  Widget _stockRow(String leftTitle, String leftValue, String rightTitle, String rightValue) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(leftTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(leftValue, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          Expanded(
            child: Column(
              children: [
                Text(rightTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(rightValue, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Indent Material'), behavior: SnackBarBehavior.floating));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text('INDENT\nMATERIAL', textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => UpdateStockConsumption());
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateStockConsumption()));
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Consumption'), behavior: SnackBarBehavior.floating));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text('UPDATE\nCONSUMPTION', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
       /* OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xFFFBBF24), width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text('STOCK SUMMARY', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFFBBF24), fontWeight: FontWeight.bold, fontSize: 12)),
        ),*/
      ],
    );
  }

  Widget _buildStockSummaryTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorBlack),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Stock Summary", style: _boldStyle()),
              Container(height: 40, width: 1, color: AppColors.colorBlack),
              Text("Filter", style: _boldStyle()),
            ],
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: AppColors.colorBlack),
              bottom: BorderSide(width: 1, color: AppColors.colorBlack),
              right: BorderSide(width: 1, color: AppColors.colorBlack),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Material \nDescription", style: _boldStyle()),
              Text("Inward", style: _boldStyle()),
              Text("Outward", style: _boldStyle()),
              Text("Total", style: _boldStyle()),
            ],
          ),
        ),
        ListView.builder(
          itemCount: stockSummeryList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = stockSummeryList[index];
            final isLastItem = index == stockSummeryList.length - 1;

            return Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: AppColors.colorBlack),
                  bottom: BorderSide(width: 1, color: AppColors.colorBlack),
                  right: BorderSide(width: 1, color: AppColors.colorBlack),
                ),
                borderRadius: isLastItem ? BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)) : BorderRadius.zero,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Text(item.date, style: TextStyle(fontSize: 10)),
                            SizedBox(width: 2),
                            Text(item.time, style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                  _stockCell(item.inward),
                  _divider(),
                  _stockCell(item.outward),
                  _divider(),
                  _stockCell(item.total),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _stockCell(String text) {
    return SizedBox(
      width: 40,
      child: Text(text, style: TextStyle(fontSize: 14, color: AppColors.colorBlack)),
    );
  }

  Widget _divider() {
    return Container(height: 80, width: 1, color: AppColors.colorBlack);
  }

  TextStyle _boldStyle() {
    return TextStyle(fontSize: 16, color: AppColors.colorBlack, fontWeight: FontWeight.bold);
  }
}

class StockSummeryModel {
  String name;
  String date;
  String time;
  String inward;
  String outward;
  String total;

  StockSummeryModel({
    required this.name,
    required this.date,
    required this.time,
    required this.inward,
    required this.outward,
    required this.total,
  });
}
