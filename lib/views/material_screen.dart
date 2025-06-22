import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/widgets/add_material_widget.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';
import 'package:in_setu/widgets/intent_management.dart';
import 'package:in_setu/widgets/updated_indent_material_widget.dart';

class StockManagementScreen extends StatefulWidget {
  @override
  _StockManagementScreenState createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  String _activeTab = 'Stocks';
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();
  bool isReceived1 = false;
  bool isReceived2 = false;

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

  List<StockItem> get filteredItems {
    if (_searchQuery.isEmpty) {
      return stockItems;
    }
    return stockItems
        .where(
          (item) =>
              item.createdBy.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

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

  void _toggleExpanded(int itemId) {
    setState(() {
      final item = stockItems.firstWhere((item) => item.id == itemId);
      item.isExpanded = !item.isExpanded;
    });
  }

  void _toggleIndentExpanded(int itemId) {
    setState(() {
      final item = indentItems.firstWhere((item) => item.id == itemId);
      item.isExpanded = !item.isExpanded;
    });
  }

  void updateMaterialReceived(int indentId, int materialIndex, bool value) {
    setState(() {
      final indent = indentItems.firstWhere((item) => item.id == indentId);
      indent.materials[materialIndex].isReceived = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerItems(context),
      floatingActionButton:
          _activeTab == 'Stocks'
              ? FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const MaterialRequirementsPopup(buttonTxt: "Add Material",),
                  );
                },
                tooltip: 'Add Stock',
                child: Icon(Icons.add, color: Colors.white),
              )
              : FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  showDialog(context: context, builder: (context) => UpdatedIndentMaterialWidget());
                },
                tooltip: 'Add Indent',
                child: Icon(Icons.add, color: Colors.white),
              ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Top Header
                  APPBarWidget(),
                  // Tabs
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _activeTab = 'Stocks'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    _activeTab == 'Stocks'
                                        ? Color(0xFF1E3A8A)
                                        : Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Stocks',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      _activeTab == 'Stocks'
                                          ? Color(0xFFFBBF24)
                                          : Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _activeTab = 'Indents'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    _activeTab == 'Indents'
                                        ? Color(0xFF1E3A8A)
                                        : Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Indents',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      _activeTab == 'Indents'
                                          ? Color(0xFFFBBF24)
                                          : Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged:
                            (value) => setState(() => _searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
           
            // Content
            Expanded(
              child:
                  _activeTab == 'Stocks'
                      ? _buildStocksContent()
                      : _buildIndentsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndentsContent() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
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
        borderRadius: BorderRadius.circular(20),
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
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
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

                // SizedBox(height: 20),

                // Add requirements button
                // Container(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.orange[400],
                //       foregroundColor: Colors.white,
                //       padding: EdgeInsets.symmetric(vertical: 15),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       elevation: 0,
                //     ),
                //     child: Text(
                //       'ADD REQUIREMENTS',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStocksContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return _buildStockItemCard(filteredItems[index]);
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildIndentsContent() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
  //         SizedBox(height: 16),
  //         Text(
  //           'No indents available',
  //           style: TextStyle(color: Colors.grey[500], fontSize: 16),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStockItemCard(StockItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                          showDialog(context: context, builder: (context) => const MaterialRequirementsPopup(buttonTxt: "Update Material"))
                        },
                        child: Icon(Icons.edit_outlined, color: Colors.purple, size: 20)),
                    SizedBox(width: 12),
                    Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _toggleExpanded(item.id),
                      child: Icon(
                        item.isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Created by
                Text(
                  'Created By- ${item.createdBy}',
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
                    ).showSnackBar(SnackBar(content: Text('Indent Material')));
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
                      SnackBar(content: Text('Update Consumption')),
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
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Stock Summary')));
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
