import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String cuisine;
  final String imageUrl;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, cuisine, imageUrl];
}
