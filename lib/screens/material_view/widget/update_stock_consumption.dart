import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/supports/utility.dart';

class UpdateStockConsumption extends StatefulWidget {
  const UpdateStockConsumption({super.key});

  @override
  State<UpdateStockConsumption> createState() => _UpdateStockConsumptionState();
}

class _UpdateStockConsumptionState extends State<UpdateStockConsumption> {
  String _selectedOption = 'Option 1';
  final updateStockController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.50,
        ),
        decoration: BoxDecoration(
          color: AppColors.colorLightGray,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.colorBlack, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utility.title("Update Stock Details", AppColors.colorBlack),
              SizedBox(height: 10),
              Utility.subTitle("Cement", AppColors.colorBlack),
              SizedBox(height: 40),
              Utility.smlText("Present Stock", AppColors.colorGray),
              SizedBox(height: 10),
              Utility.subTitle("100 BAGS", AppColors.colorBlack),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Option 1',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Utility.smlText("USED", AppColors.colorGray),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Option 2',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Utility.smlText("ADD", AppColors.colorGray),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.colorBlack, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Icon(Icons.add, size: 30,),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: 100,
                        height: 40, // Give enough height to fit the text comfortably
                        child: TextFormField(
                          controller: updateStockController,
                          style: TextStyle(fontSize: 14, color: AppColors.colorGray),
                          decoration: InputDecoration(
                            isDense: true, // 👈 makes content more compact
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            hintText: 'Enter Details',
                            hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                            border: OutlineInputBorder( // 👈 optional, for visible border
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 30,
                        width: 1,
                        color: AppColors.colorGray,
                      ),

                      SizedBox(width: 5,),
                      Utility.smlText("BAGS", AppColors.colorGray)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green, width: 0.5)
                      ),
                      child: Center(
                        child: Utility.smlText("Cancel", Colors.green),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary
                    ),
                    child: Center(
                      child: Utility.smlText("Update", AppColors.colorBlack),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
