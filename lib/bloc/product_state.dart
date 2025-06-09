import 'package:equatable/equatable.dart';

import '../model/product_model.dart';

enum ViewMode { grid, list }

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final Map<String, List<Product>> groupedProducts;
  final ViewMode viewMode;
  final String searchQuery;
  final int totalCount;

  const ProductLoaded({
    required this.products,
    required this.groupedProducts,
    required this.viewMode,
    required this.searchQuery,
    required this.totalCount,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    Map<String, List<Product>>? groupedProducts,
    ViewMode? viewMode,
    String? searchQuery,
    int? totalCount,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      groupedProducts: groupedProducts ?? this.groupedProducts,
      viewMode: viewMode ?? this.viewMode,
      searchQuery: searchQuery ?? this.searchQuery,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [products, groupedProducts, viewMode, searchQuery, totalCount];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
