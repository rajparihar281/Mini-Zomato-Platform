import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/restaurant_list/restaurant_list_bloc.dart';
import 'package:user_app/bloc/restaurant_list/restaurant_list_event.dart';
import 'package:user_app/bloc/restaurant_list/restaurant_list_state.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';
import 'package:user_app/presentation/my_orders/my_orders_screen.dart';
import 'package:user_app/presentation/restaurant_details/restaurant_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantListBloc(
        RepositoryProvider.of<RestaurantRepository>(context),
      )..add(FetchRestaurants()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurants'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // --- NEW BUTTON ADDED HERE ---
            IconButton(
              icon: const Icon(Icons.receipt_long),
              tooltip: 'My Orders',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<RestaurantListBloc, RestaurantListState>(
          builder: (context, state) {
            if (state is RestaurantListLoading ||
                state is RestaurantListInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RestaurantListLoaded) {
              return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                RestaurantDetailsScreen(restaurant: restaurant),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(
                          restaurant.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(restaurant.name),
                        subtitle: Text(restaurant.cuisine),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is RestaurantListError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
