import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/screens/material_view/delete_intent_item_dialog/delete_intent_dialog.dart';
import 'package:in_setu/screens/material_view/loading_screen.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/screens/project_list/project_list_loading_screen.dart';
import 'package:in_setu/widgets/updated_indent_material_widget.dart';

class IntendContentScreen extends StatefulWidget {
  final Data siteObject;
  final List<SearchUnitData> searchUnitData;
  const IntendContentScreen({super.key, required this.siteObject, required this.searchUnitData});

  @override
  State<IntendContentScreen> createState() => _IntendContentScreenState();
}

class _IntendContentScreenState extends State<IntendContentScreen> {
  final Set<int> _expandedItemIds = {};
  bool _isLoading = true;
  List<IntentsData> intentsDataList = [];

  void _toggleIndentExpanded(dynamic itemId) {
    setState(() {
      if (_expandedItemIds.contains(itemId)) {
        _expandedItemIds.remove(itemId); // collapse
      } else {
        _expandedItemIds.add(itemId); // expand
      }
    });
  }

  bool _isItemExpanded(dynamic itemId) => _expandedItemIds.contains(itemId);

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
                intentsDataList = state.data.intentsData!;
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
      child: _isLoading ? ProjectListLoadingScreen() : getIntentListItems(intentsDataList),
    );
  }

  Widget getIntentListItems(List<IntentsData> intentsDataList){
    return intentsDataList.isEmpty ? NoDataFound(noDataFoundTxt: "No Indents Data Found") : ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: intentsDataList.length,
      itemBuilder: (context, index) {
        return _buildIndentCard(intentsDataList[index]);
      },
    );
  }

  Widget _buildIndentCard(IntentsData indent) {
    final isExpanded = _isItemExpanded(indent.id);
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.purple[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Intend Id ${indent.id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.copy, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap:
                          () => {
                            showDialog(
                              context: context,
                              builder:
                                  (context) =>
                                      UpdatedIndentMaterialWidget(
                                        searchUnitData: widget.searchUnitData,
                                      ),
                            ),
                          },
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        final delete = await DeleteIntentDialog.showDeleteManPowerDialog(
                          context,
                          siteDeleteMsg,
                          siteDeleteTitle,
                          indent.id,
                        );
                        if(delete){
                          context.read<MaterialStockBloc>().add(MaterialStockFetchEvent(siteId: widget.siteObject.id));
                        }
                      },
                      child: Icon(Icons.delete, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _toggleIndentExpanded(indent.id),
                      child: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Created by section
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green[400],
                      child: Text(
                        "K",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Created By Kurshid',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Materials summary or detailed view
                if (!isExpanded)
                  buildMaterialsSummary(indent)
                else
                  buildMaterialsDetailed(indent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMaterialsSummary(IntentsData intent) {
    return Column(
      children:
          intent.formvalues!.asMap().entries.map((entry) {
            int index = entry.key;
            Formvalues material = entry.value;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index < intent.formvalues!.length - 1 ? 8 : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${material.materialName}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      Text(
                        "${material.quantity}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${material.unit}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget buildMaterialsDetailed(IntentsData intend) {
    return Column(
      children:
          intend.formvalues!.asMap().entries.map((entry) {
            Formvalues material = entry.value;

            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: buildDetailedMaterialItem(
                material.materialName!,
                material.unit!,
                material.quantity!,
                false,
                // => updateMaterialReceived(indent.id, index, value),
              ),
            );
          }).toList(),
    );
  }

  Widget buildDetailedMaterialItem(
    String name,
    String details,
    String quantity,
    bool isReceived,
    // Function(bool) onReceivedChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  quantity,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(additional Details)',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Received:-',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Checkbox(
                          value: isReceived,
                          onChanged: (value) => value,
                          activeColor: Colors.green[500],
                        ),
                        // GestureDetector(
                        //   onTap: () => onReceivedChanged(!isReceived),
                        //   child: Container(
                        //     width: 20,
                        //     height: 20,
                        //     decoration: BoxDecoration(
                        //       color:
                        //       isReceived
                        //           ? Colors.green[500]
                        //           : Colors.transparent,
                        //       border: Border.all(
                        //         color:
                        //         isReceived
                        //             ? Colors.green[500]!
                        //             : Colors.grey[400]!,
                        //         width: 2,
                        //       ),
                        //       borderRadius: BorderRadius.circular(4),
                        //     ),
                        //     child:
                        //     isReceived
                        //         ? Icon(
                        //       Icons.check,
                        //       size: 14,
                        //       color: Colors.white,
                        //     )
                        //         : null,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Transferred:- To',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.red[400]!),
                                      foregroundColor: Colors.red[400],
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'VIEW SITE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: 100,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
