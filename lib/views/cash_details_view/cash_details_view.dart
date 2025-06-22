import 'package:flutter/material.dart';
import 'package:in_setu/commonWidget/common_view.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/widgets/add_cashbook_widget.dart';
import 'package:in_setu/widgets/cash_in_out_widget.dart';

class CashDetailsView extends StatefulWidget {
  const CashDetailsView({super.key});

  @override
  State<CashDetailsView> createState() => _CashDetailsViewState();
}

class _CashDetailsViewState extends State<CashDetailsView> {
  List<CashBookUserModel> cashBookUserModel = [];
  List<CashInOutModel> transactions = [];
  String selectedUser = "Select";

  @override
  void initState() {
    super.initState();
    // if (cashBookUserModel.isNotEmpty) {
    //   for (int i = 0; i < cashBookUserModel.length; i++) {
    //     if (cashBookUserModel[i].userName.isNotEmpty) {
    //       selectedUser = cashBookUserModel[i].userName;
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header section
          Container(
            color: AppColors.primary,
            width: double.infinity,
            height: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomViews.setSubTitle(selectedUser),
                              InkWell(
                                onTap:
                                    () => {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>AddCahbookWidget(cashBookUserSave: (cashBook) {
                                          setState(() {
                                            cashBookUserModel.add(cashBook);
                                            selectedUser = cashBook.userName;
                                          });
                                        },),
                                      ),
                                    },
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 40, height: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomViews.setSubTitle("Particular/Remark"),
                      CustomViews.setSubTitle("Cr/Dr Balance"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomViews.setVerticalSpace(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 400,
              child: transactions.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/empty.png", width: 90, height: 90,),
                    SizedBox(height: 10,),
                    Text("No Data Found", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),)
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    title: Text(transaction.remark),
                    subtitle: Text('${transaction.date} - ${transaction.amount}'),
                    trailing: Icon(
                      transaction.type == 'cashin'
                          ? Icons.arrow_circle_up
                          : Icons.arrow_circle_down,
                      color: transaction.type == 'cashin' ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap:
                    () => {
                      showDialog(
                        context: context,
                        builder:
                            (context) => CashInOutWidget(
                              cashTitle: "Cash In",
                              type: "cashin",
                              onSave: (cashInOutModel) {
                                setState(() {
                                  transactions.add(cashInOutModel);
                                });
                              },
                            ),
                      ),
                    },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Cash In",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap:
                    () => {
                      showDialog(
                        context: context,
                        builder:
                            (context) => CashInOutWidget(
                              cashTitle: "Cash Out",
                              type: "cashout",
                              onSave: (cashInOutModel) {
                                setState(() {
                                  transactions.add(cashInOutModel);
                                });
                              },
                            ),
                      ),
                    },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Cash Out",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => {_showAddDialog()},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Options",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  'Options',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 24),
                _buildAddOption(
                  icon: Icons.home,
                  title: 'Pdf File',
                  subtitle: 'Generate PDF Report',
                  color: Colors.blue,
                  onTap: () => /*_addFolder()*/ {},
                ),
                SizedBox(height: 16),
                _buildAddOption(
                  icon: Icons.person,
                  title: 'Cash Book',
                  subtitle: 'Change Cash Book',
                  color: Colors.green,
                  onTap: () => /*_addFile(*/ {},
                ),
                SizedBox(height: 16),
                _buildAddOption(
                  icon: Icons.delete_forever_sharp,
                  title: 'Delete',
                  subtitle: 'Delete All',
                  color: Colors.red,
                  onTap: () => /*_addFile(*/ {},
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

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wallet, size: 60, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No cash books available',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Add a cash book to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildCashBookList() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cashBookUserModel.length,
          itemBuilder: (context, index) {
            final cashBook = cashBookUserModel[index];
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    cashBook.userName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
