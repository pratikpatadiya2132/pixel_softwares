import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../model/product_model.dart';
import '../repository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<ToggleViewMode>(_onToggleViewMode);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();
      final groupedProducts = _groupProductsByDate(products);
      
      emit(ProductLoaded(
        products: products,
        groupedProducts: groupedProducts,
        viewMode: ViewMode.grid,
        searchQuery: '',
        totalCount: products.length,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(ProductLoading());
      
      try {
        final products = await repository.fetchProducts(search: event.query);
        final groupedProducts = _groupProductsByDate(products);
        
        emit(currentState.copyWith(
          products: products,
          groupedProducts: groupedProducts,
          searchQuery: event.query,
          totalCount: products.length,
        ));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }

  void _onToggleViewMode(ToggleViewMode event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final newViewMode = currentState.viewMode == ViewMode.grid 
          ? ViewMode.list 
          : ViewMode.grid;
      
      emit(currentState.copyWith(viewMode: newViewMode));
    }
  }

  Map<String, List<Product>> _groupProductsByDate(List<Product> products) {
    final Map<String, List<Product>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final product in products) {
      final productDate = DateTime(
        product.date.year,
        product.date.month,
        product.date.day,
      );

      String dateKey;
      if (productDate == today) {
        dateKey = 'Today';
      } else if (productDate == yesterday) {
        dateKey = 'Yesterday';
      } else {
        dateKey = DateFormat('dd MMM, yyyy').format(productDate);
      }

      grouped.putIfAbsent(dateKey, () => []).add(product);
    }

    // Sort the groups by date (most recent first)
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) {
        if (a.key == 'Today') return -1;
        if (b.key == 'Today') return 1;
        if (a.key == 'Yesterday') return -1;
        if (b.key == 'Yesterday') return 1;
        
        try {
          final dateA = DateFormat('dd MMM, yyyy').parse(a.key);
          final dateB = DateFormat('dd MMM, yyyy').parse(b.key);
          return dateB.compareTo(dateA);
        } catch (e) {
          return 0;
        }
      });

    return Map.fromEntries(sortedEntries);
  }
}