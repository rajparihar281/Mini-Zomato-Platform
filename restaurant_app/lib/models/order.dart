// lib/models/order.dart

class Order {
  final String id;
  final String customerName;
  final List<String> items;
  final double total;
  final DateTime orderTime;

  Order({
    required this.id,
    required this.customerName,
    required this.items,
    required this.total,
    required this.orderTime,
  });
}
