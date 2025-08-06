import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/cash_details_view/bloc/cashbook_bloc.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:intl/intl.dart';

import '../screens/cash_details_view/model/CashbookDetailResponse.dart';

class CashInOutWidget extends StatefulWidget {
  final String cashTitle;
  final String type;
  final Data? cashBookObj;
  final Function(bool) transactionAdd;

  const CashInOutWidget({
    super.key,
    required this.cashTitle,
    required this.type,
    required this.cashBookObj,
    required this.transactionAdd,
  });

  @override
  State<CashInOutWidget> createState() => _CashInOutWidgetState();
}

class _CashInOutWidgetState extends State<CashInOutWidget> {
  String title = "";
  String type = "";
  final amountTV = TextEditingController();
  final remarkTV = TextEditingController();
  String date = "";
  final cashInOutKey = GlobalKey<FormState>();
  final transactionKeyForm = GlobalKey<FormState>();
  bool isCashIn = true;
  String fileName = "";

  @override
  void initState() {
    super.initState();
    title = widget.cashTitle;
    type = widget.type;
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if(type.contains("cashin")){
      isCashIn = true;
    }else{
      isCashIn = false;
    }
  }
  @override
  void didUpdateWidget(CashInOutWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: BlocListener<CashbookBloc, GlobalApiResponseState>(
        listener: (context, state) {
          switch (state.status) {
            case GlobalApiStatus.loading:
              // LoadingDialog.show(context, key: ObjectKey("Loading......"));
              break;
            case GlobalApiStatus.completed:
              LoadingDialog.hide(context);
              if(state is AddTransactionCashBookStateSuccess){
                Future.microtask(() {
                  Navigator.of(context, rootNavigator: true).pop();
                  widget.transactionAdd(true);
                  // Utility.showToast(state.data.messase);
                });
              }
              break;
            case GlobalApiStatus.error:
               LoadingDialog.hide(context);
               ErrorHandler.errorHandle(state.message, "Error", context);
              break;
            default:
              LoadingDialog.hide(context);
          }
        },
        child: _buildMainView(),
      ),
    );
  }

  Widget _buildMainView() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
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
          child: Form(
            key: transactionKeyForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                SizedBox(height: 15),
                Align(alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FlutterSwitch(
                      value: isCashIn,
                      onToggle: (val) {
                        setState(() {
                          isCashIn = val;
                        });
                      },
                      activeText: "In",
                      inactiveText: "Out",
                      showOnOff: true,
                      activeColor: AppColors.primary,
                      inactiveColor: Colors.grey,
                      width: 65.0,
                      height: 30.0,
                      borderRadius: 20.0,
                    ),
                  ),
                ),),
                SizedBox(height: 15),
                Center(
                  child: GestureDetector(
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
                          'dd-MM-yyyy',
                        ).format(pickedDate);
                        setState(() {
                          date = formattedDate;
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter amount";
                            }
                            return null;
                          },
                          controller: amountTV,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            labelText: 'Amount',
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
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Please enter remark";
                            }
                            return null;
                          },
                          controller: remarkTV,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            labelText: 'Remark',
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Align(alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        PlatformFile file = result.files.first;
                        setState(() {
                          fileName = file.name;
                        });
                        print('File name: ${file.name}');
                        print('File path: ${file.path}');
                        // You can now upload, display or process the file
                      } else {
                        Utility.showToast("No file selected");
                      }
                    },
                    child: SizedBox(
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 25),
                        child: Row(
                          children: [
                            Image.asset("assets/icons/file_icon.png", width: 25,height: 25,),
                            SizedBox(width: 5,),
                            Expanded(child: Text(fileName.isEmpty ? "File Attachment" : fileName,maxLines: 1, style: TextStyle(fontSize: 12,color: AppColors.colorGray,fontStyle: FontStyle.italic,), overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      if (transactionKeyForm.currentState!.validate()) {
                        context.read<CashbookBloc>().add(
                          AddTransactionCashBookEvent(
                            bookId: widget.cashBookObj?.id ?? 0,
                            siteId: widget.cashBookObj?.siteId ?? 0,
                            toggleValue:  isCashIn,
                            amount: amountTV.text,
                            remark: remarkTV.text,
                            currentDate: date,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Text(
            isCashIn ? "Cash In" : "Cash Out",
            style: TextStyle(
              color: AppColors.colorBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 20.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close, color: AppColors.colorBlack, size: 25),
            ),
          ),
        ),
      ],
    );
  }
}
