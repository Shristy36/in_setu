import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/common_view.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/views/cash_details_view/bloc/cashbook_bloc.dart';
import 'package:in_setu/views/cash_details_view/model/CashbookDetailResponse.dart';
import 'package:in_setu/widgets/add_cashbook_widget.dart';
import 'package:in_setu/widgets/cash_in_out_widget.dart';

class CashDetailsView extends StatefulWidget {
  final num siteId;
  const CashDetailsView({super.key, required this.siteId});

  @override
  State<CashDetailsView> createState() => _CashDetailsViewState();
}

class _CashDetailsViewState extends State<CashDetailsView> {
  CashbookDetailResponse? cashbookDetailResponse;

  @override
  void initState() {
    super.initState();
    context.read<CashbookBloc>().add(CashbookFetchEvent(widget.siteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CashbookBloc, GlobalApiResponseState>(
        builder: (context, state) {
          if (state.status == GlobalApiStatus.loading && state.data == null) {
            return Utility.getLoadingView(context);
          }

          if (state.status == GlobalApiStatus.completed) {
            if (state is CashbookStateSuccess) {
              cashbookDetailResponse = state.data;
              if (state.data != null) {
                return getCashbookDetailView(state.data!);
              }
              return _buildEmptyView();
            }
            return _buildEmptyView();
          }

          if (state.status == GlobalApiStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ErrorHandler.errorHandle(state.message ?? "An error occurred", "Error", context);
            });
            return _buildEmptyView();
          }

          return const Center(child: Text('Loading...'));
        },
      ),
      bottomNavigationBar: BlocBuilder<CashbookBloc, GlobalApiResponseState>(
        builder: (context, state) {
          if (state is CashbookStateSuccess &&
              state.data != null &&
              state.data!.firstCashbook != null &&
              state.data!.firstCashbook!.isNotEmpty) {
            return BottomAppBar(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavButton(
                    title: "Cash In",
                    color: AppColors.primary,
                    onTap: () => _showCashDialog("Cash In", "cashin"),
                  ),
                  _buildBottomNavButton(
                    title: "Cash Out",
                    color: Colors.red,
                    onTap: () => _showCashDialog("Cash Out", "cashout"),
                  ),
                  _buildBottomNavButton(
                    title: "Options",
                    color: Colors.green,
                    onTap: _showAddDialog,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomNavButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCashbookDetailView(CashbookDetailResponse response) {
    // final bookName = response.bookName ?? "Select";
    final firstCashbook = response.firstCashbook ?? [];
    final hasData = firstCashbook.isNotEmpty;

    Widget getCashbookWidget() {
      final hasDefault = response.data!.any((item) => item.isDefault == 1);

      if (hasDefault) {
        final defaultItem = response.data!.firstWhere((item) => item.isDefault == 1);
        return CustomViews.setSubTitle(defaultItem.cashbookName ?? "Default");
      } else {
        return CustomViews.setSubTitle("Select");
      }
    }
    return Column(
      children: [
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
                            getCashbookWidget(),
                           /* ...response.data!
                                .where((item) => item.isDefault == 1)
                                .map((item) => CustomViews.setSubTitle(item.cashbookName ?? "Select")),*/
                            InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context)  => AddCashbookWidget(siteId: widget.siteId, isUpdateValue: (value) {
                                  if (value) {
                                    context.read<CashbookBloc>().add(
                                        CashbookFetchEvent(widget.siteId));
                                  }
                                })
                                /*AddCahbookWidget(
                                  cashbookDetailResponse: cashbookDetailResponse,
                                  cashBookUserSave: (cashBook) {
                                    setState(() {});
                                  },
                                ),*/
                              ),
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.colorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 40, height: 40),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SizedBox(
            width: double.infinity,
            height: 400,
            child: !hasData
                ? const Center(child: NoDataFound(noDataFoundTxt: "No Cashbook Found"))
                : ListView.builder(
              itemCount: firstCashbook.length,
              itemBuilder: (context, index) {
                final item = firstCashbook[index];
                final date = item.date ?? "No Date";
                final transactions = item.transactions ?? [];

                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(child: Text("--------------------------",overflow: TextOverflow.ellipsis,)),
                          Expanded(
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Expanded(child: Text("----------------------------", overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
                    ...transactions.map((transaction) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction.particular ?? "No Particular",
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.colorBlack,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${transaction.amount ?? 0}",
                              style: TextStyle(
                                color: transaction.type == 'credit'
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "${transaction.amount ?? 0}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showCashDialog(String title, String type) {
    showDialog(
      context: context,
      builder: (context) => CashInOutWidget(
        cashTitle: title,
        type: type,
        onSave: (cashInOutModel) {
          setState(() {});
        },
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
            padding: const EdgeInsets.all(24),
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
                const SizedBox(height: 24),
                _buildAddOption(
                  icon: Icons.home,
                  title: 'Pdf File',
                  subtitle: 'Generate PDF Report',
                  color: Colors.blue,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildAddOption(
                  icon: Icons.person,
                  title: 'Cash Book',
                  subtitle: 'Change Cash Book',
                  color: Colors.green,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildAddOption(
                  icon: Icons.delete_forever_sharp,
                  title: 'Delete',
                  subtitle: 'Delete All',
                  color: Colors.red,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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
    return Column(
      children: [
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
                            CustomViews.setSubTitle("Select"),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.colorWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 40, height: 40),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wallet, size: 60, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No cash books available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add a cash book to get started',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}