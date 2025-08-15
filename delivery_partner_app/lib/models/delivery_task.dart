// lib/models/delivery_task.dart

class DeliveryTask {
  final String id;
  final String restaurantName;
  final String customerAddress;
  final String status;

  DeliveryTask({
    required this.id,
    required this.restaurantName,
    required this.customerAddress,
    required this.status,
  });
}
