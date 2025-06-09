import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: double.tryParse(json['rate']?.toString() ?? '0') ?? 0.0,
      count: int.tryParse(json['count']?.toString() ?? '0') ?? 0,
    );
  }

  @override
  List<Object?> get props => [rate, count];
}

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final DateTime date;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.date,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      rating: Rating.fromJson(json['rating'] ?? {}),
    );
  }

  // Helper getter for brand (extracted from category)
  String get brand => category.replaceAll("'s", "").split(' ').map((word) => 
    word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');

  // Helper getter for discount calculation (if needed)
  int get discount => 0; 

  @override
  List<Object?> get props => [id, title, price, description, category, image, date, rating];
}