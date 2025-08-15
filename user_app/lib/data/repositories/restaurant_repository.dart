import 'package:user_app/data/models/menu_item_model.dart';
import 'package:user_app/data/models/order_model.dart';
import 'package:user_app/data/models/restaurant_model.dart';

class RestaurantRepository {
  Future<List<Restaurant>> fetchRestaurants() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Restaurant(
        id: '1',
        name: 'The Golden Spoon',
        cuisine: 'Italian',
        imageUrl:
            'https://images.unsplash.com/photo-1598866594240-a_27d2a162c6?q=80&w=800',
      ),
      const Restaurant(
        id: '2',
        name: 'Spice Village',
        cuisine: 'Indian',
        imageUrl:
            'https://images.unsplash.com/photo-1598515214211-89d3c7373058?q=80&w=800',
      ),
      const Restaurant(
        id: '3',
        name: 'Burger Queen',
        cuisine: 'Fast Food',
        imageUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?q=80&w=800',
      ),
      const Restaurant(
        id: '4',
        name: 'Sushi Central',
        cuisine: 'Japanese',
        imageUrl:
            'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?q=80&w=800',
      ),
    ];
  }

  Future<List<MenuItem>> fetchMenu(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (restaurantId == '1') {
      return [
        const MenuItem(
          id: 'm1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomatoes and mozzarella.',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=800',
        ),
        const MenuItem(
          id: 'm2',
          name: 'Carbonara Pasta',
          description: 'Creamy pasta with eggs, cheese, and bacon.',
          price: 12.50,
          imageUrl:
              'https://images.unsplash.com/photo-1551183053-bf91a1d81141?q=80&w=800',
        ),
        const MenuItem(
          id: 'm3',
          name: 'Tiramisu',
          description: 'A delicious coffee-flavored dessert.',
          price: 6.00,
          imageUrl:
              'https://images.unsplash.com/photo-1542444592-3d51c1626c48?q=80&w=800',
        ),
      ];
    }
    return [
      const MenuItem(
        id: 'm4',
        name: 'House Special',
        description: 'Our chef\'s special dish of the day.',
        price: 15.99,
        imageUrl:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=800',
      ),
      const MenuItem(
        id: 'm5',
        name: 'Classic Burger',
        description: 'A juicy beef burger with all the fixings.',
        price: 10.99,
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=800',
      ),
      const MenuItem(
        id: 'm6',
        name: 'Soft Drink',
        description: 'Coke, Sprite, or Fanta.',
        price: 2.50,
        imageUrl:
            'https://images.unsplash.com/photo-1581006852262-5b889fde5483?q=80&w=800',
      ),
    ];
  }

  // --- NEW METHOD ADDED HERE ---
  Future<List<OrderModel>> fetchOrderHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      OrderModel(
        id: 'o1',
        restaurantName: 'The Golden Spoon',
        date: DateTime.now().subtract(const Duration(days: 2)),
        totalPrice: 21.49,
        items: const [
          MenuItem(
            id: 'm1',
            name: 'Margherita Pizza',
            description: 'desc',
            price: 8.99,
            imageUrl: '',
          ),
          MenuItem(
            id: 'm2',
            name: 'Carbonara Pasta',
            description: 'desc',
            price: 12.50,
            imageUrl: '',
          ),
        ],
      ),
      OrderModel(
        id: 'o2',
        restaurantName: 'Burger Queen',
        date: DateTime.now().subtract(const Duration(days: 5)),
        totalPrice: 13.49,
        items: const [
          MenuItem(
            id: 'm5',
            name: 'Classic Burger',
            description: 'desc',
            price: 10.99,
            imageUrl: '',
          ),
          MenuItem(
            id: 'm6',
            name: 'Soft Drink',
            description: 'desc',
            price: 2.50,
            imageUrl: '',
          ),
        ],
      ),
    ];
  }
}
