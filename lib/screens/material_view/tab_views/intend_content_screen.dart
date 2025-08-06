import 'package:flutter/material.dart';
import 'package:in_setu/widgets/intent_management.dart';
import 'package:in_setu/widgets/updated_indent_material_widget.dart';

class IntendContentScreen extends StatefulWidget {
  const IntendContentScreen({super.key});

  @override
  State<IntendContentScreen> createState() => _IntendContentScreenState();
}

class _IntendContentScreenState extends State<IntendContentScreen> {
  void _toggleIndentExpanded(int itemId) {
    setState(() {
      final item = indentItems.firstWhere((item) => item.id == itemId);
      item.isExpanded = !item.isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: indentItems.length,
      itemBuilder: (context, index) {
        return _buildIndentCard(indentItems[index]);
      },
    );
  }
  Widget _buildIndentCard(IndentItem indent) {
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
                    GestureDetector(onTap: ()=>{
                      showDialog(context: context, builder: (context) => const UpdatedIndentMaterialWidget())
                    },child: Icon(Icons.edit, color: Colors.white, size: 20)),
                    SizedBox(width: 10),
                    Icon(Icons.delete, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _toggleIndentExpanded(indent.id),
                      child: Icon(
                        indent.isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more,
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
                        indent.createdBy[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Created By- ${indent.createdBy}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Materials summary or detailed view
                if (!indent.isExpanded)
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
  Widget buildMaterialsSummary(IndentItem indent) {
    return Column(
      children:
      indent.materials.asMap().entries.map((entry) {
        int index = entry.key;
        MaterialItem material = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < indent.materials.length - 1 ? 8 : 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                material.name,
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
              Text(
                material.quantity,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildMaterialsDetailed(IndentItem indent) {
    return Column(
      children:
      indent.materials.asMap().entries.map((entry) {
        MaterialItem material = entry.value;

        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: buildDetailedMaterialItem(
            material.name,
            material.details,
            material.quantity,
            material.isReceived,
                (value) {},
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
      Function(bool) onReceivedChanged,
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
                  Text(
                    details,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                      'Status:-',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Received:-',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => onReceivedChanged(!isReceived),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color:
                              isReceived
                                  ? Colors.green[500]
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                isReceived
                                    ? Colors.green[500]!
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:
                            isReceived
                                ? Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Transferred:- To',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Qty',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red[400]!),
                    foregroundColor: Colors.red[400],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'VIEW SITE',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

