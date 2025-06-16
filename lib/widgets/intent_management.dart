
class IndentItem {
  final int id;
  final String createdBy;
  final List<MaterialItem> materials;
  bool isExpanded;

  IndentItem({
    required this.id,
    required this.createdBy,
    required this.materials,
    this.isExpanded = false,
  });
}

class MaterialItem {
  final String name;
  final String details;
  final String quantity;
  bool isReceived;

  MaterialItem({
    required this.name,
    required this.details,
    required this.quantity,
    this.isReceived = false,
  });
}

// Add this to your _StockManagementScreenState class
List<IndentItem> indentItems = [
  IndentItem(
    id: 1,
    createdBy: 'Abubakar',
    materials: [
      MaterialItem(
        name: '1. material',
        details: '(Additional Details)',
        quantity: '100 Pcs',
      ),
      MaterialItem(
        name: '2. cement',
        details: '(Additional Details)',
        quantity: '100 Pcs',
      ),
    ],
  ),
  IndentItem(
    id: 2,
    createdBy: 'Rahul',
    materials: [
      MaterialItem(
        name: '1. steel',
        details: '(High Grade)',
        quantity: '50 Pcs',
      ),
      MaterialItem(
        name: '2. bricks',
        details: '(Red Bricks)',
        quantity: '200 Pcs',
      ),
      MaterialItem(
        name: '3. sand',
        details: '(River Sand)',
        quantity: '5 Truck',
      ),
    ],
  ),
];


class StockItem {
  final int id;
  final String createdBy;
  int stockIn;
  int stockOut;
  int remainingStock;
  final String unit;
  final int openingStock;
  int closingStock;
  final int transferred;
  final int totalReceived;
  bool isExpanded;

  StockItem({
    required this.id,
    required this.createdBy,
    required this.stockIn,
    required this.stockOut,
    required this.remainingStock,
    required this.unit,
    required this.openingStock,
    required this.closingStock,
    required this.transferred,
    required this.totalReceived,
    this.isExpanded = false,
  });
}



 



