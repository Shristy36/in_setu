import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class MaterialStockSummaryScreen extends StatefulWidget {
  const MaterialStockSummaryScreen({super.key});

  @override
  State<MaterialStockSummaryScreen> createState() =>
      _MaterialStockSummaryScreenState();
}

class _MaterialStockSummaryScreenState extends State<MaterialStockSummaryScreen> {
  List<StockSummeryModel> stockSummeryList = [
    StockSummeryModel(name: "Abubakar Kalmani", date: "17/04/2024", time: "12:30 am", inward: "100", outward: "50", total: "50"),
    StockSummeryModel(name: "Khurshid", date: "17/04/2024", time: "12:30 am", inward: "250", outward: "50", total: "200"),
    StockSummeryModel(name: "Abubakar Kalmani", date: "17/04/2024", time: "12:30 am", inward: "100", outward: "50", total: "50"),
    StockSummeryModel(name: "Khurshid", date: "17/04/2024", time: "12:30 am", inward: "250", outward: "50", total: "200"),
    StockSummeryModel(name: "Abubakar Kalmani", date: "17/04/2024", time: "12:30 am", inward: "100", outward: "50", total: "50"),
    StockSummeryModel(name: "Khurshid", date: "17/04/2024", time: "12:30 am", inward: "250", outward: "50", total: "200"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Stock Summary", style: TextStyle(
            fontSize: 18,
            color: AppColors.colorBlack,
            fontWeight: FontWeight.normal)),
          backgroundColor: AppColors.colorWhite,),
        body: Column(
          children: [
            Container(
              height: 1.5,
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                color: AppColors.colorWhite,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Container(
                       height: 40,
                       decoration: BoxDecoration(
                         border: Border.all(color: AppColors.colorBlack, width: 1),
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Text("Stock Summary", style: TextStyle(fontSize: 16, color: AppColors.colorBlack,fontWeight: FontWeight.bold),),
                           Container(
                             height: 40,
                             width: 1,
                             color: AppColors.colorBlack,
                           ),
                           Text("Filter", style: TextStyle(fontSize: 16, color: AppColors.colorBlack, fontWeight: FontWeight.bold),),
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
                         )
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Text("Material \nDescription", style: TextStyle(fontSize: 16, color: AppColors.colorBlack, fontWeight: FontWeight.bold),),
                           Text("Inward", style: TextStyle(fontSize: 16, color: AppColors.colorBlack,fontWeight: FontWeight.bold),),
                           Text("Outward", style: TextStyle(fontSize: 16, color: AppColors.colorBlack,fontWeight: FontWeight.bold),),
                           Text("Total", style: TextStyle(fontSize: 16, color: AppColors.colorBlack,fontWeight: FontWeight.bold),),
                         ],
                       ),
                     ),
                     Expanded(
                       child: ListView.builder(
                         itemCount: stockSummeryList.length,
                           itemBuilder: (context, index){
                             final isLastItem = index == stockSummeryList.length - 1;
                             return Container(
                               height: 80,
                               decoration: BoxDecoration(
                                 border: Border(
                                   left: BorderSide(width: 1, color: AppColors.colorBlack),
                                   bottom: BorderSide(width: 1, color: AppColors.colorBlack),
                                   right: BorderSide(width: 1, color: AppColors.colorBlack),
                                 ),
                                 borderRadius: isLastItem ? BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)) : BorderRadius.zero
                               ),
                               child: Expanded(
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     SizedBox(
                                       width: 120,
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Align(alignment: Alignment.centerLeft,child: Text(stockSummeryList[index].name, style: TextStyle(fontSize: 16, color: AppColors.colorBlack),)),
                                           Row(
                                             children: [
                                               Text(stockSummeryList[index].date, style: TextStyle(fontSize: 10, color: AppColors.colorBlack),),
                                               SizedBox(width: 2,),
                                               Text(stockSummeryList[index].time, style: TextStyle(fontSize: 10, color: AppColors.colorBlack),),
                                             ],
                                           )

                                         ],
                                       ),
                                     ),
                                     Container(
                                       height: 80,
                                       color: AppColors.colorBlack,
                                       width: 1,
                                     ),
                                     SizedBox(width: 40,child: Text(stockSummeryList[index].inward, style: TextStyle(fontSize: 14, color: AppColors.colorBlack),)),
                                     Container(
                                       height: 80,
                                       color: AppColors.colorBlack,
                                       width: 1,
                                     ),
                                     SizedBox(width: 40,child: Text(stockSummeryList[index].outward, style: TextStyle(fontSize: 14, color: AppColors.colorBlack),)),
                                     Container(
                                       height: 80,
                                       color: AppColors.colorBlack,
                                       width: 1,
                                     ),
                                     SizedBox(width: 40,child: Text(stockSummeryList[index].total, style: TextStyle(fontSize: 14, color: AppColors.colorBlack),)),

                                   ],
                                 ),
                               ),
                             );
                           }),
                     )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}


class StockSummeryModel{
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
    required this.total
});
}