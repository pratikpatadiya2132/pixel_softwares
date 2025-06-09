// ignore_for_file: use_super_parameters, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        _searchController.clear();
        context.read<ProductBloc>().add(SearchProducts(''));
      }
    });
  }

  void _performSearch(String query) {
    context.read<ProductBloc>().add(SearchProducts(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title:
            isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  onChanged: _performSearch,
                  onSubmitted: _performSearch,
                )
                : Text(
                  'Products',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        leading:
            isSearching
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _toggleSearch,
                )
                : null,
        actions: [
          if (!isSearching) ...[
            GestureDetector(onTap: _toggleSearch, child: Icon(Icons.search)),
            const SizedBox(width: 8),
            Icon(Icons.favorite_border),
            const SizedBox(width: 8),
            Icon(Icons.shopping_bag_outlined),
            const SizedBox(width: 8),
          ] else ...[
            if (_searchController.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  _performSearch('');
                },
                child: Icon(Icons.clear),
              ),
          ],
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => context.read<ProductBloc>().add(LoadProducts()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is ProductLoaded) {
            return Column(
              children: [
                _buildHeader(state),
                Expanded(child: _buildProductList(state)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(ProductLoaded state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      color: const Color(0xFFF6F6F6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.totalCount} Items',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => context.read<ProductBloc>().add(ToggleViewMode()),
                child: Icon(
                  state.viewMode == ViewMode.list
                      ? Icons.view_list
                      : Icons.grid_view,
                  color: Colors.black.withOpacity(0.4),
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(ProductLoaded state) {
    if (state.groupedProducts.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return ListView.builder(
      itemCount: state.groupedProducts.length,
      itemBuilder: (context, index) {
        final entry = state.groupedProducts.entries.elementAt(index);
        final dateGroup = entry.key;
        final products = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                dateGroup,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
            if (state.viewMode == ViewMode.grid)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, productIndex) {
                  return ProductCard(product: products[productIndex]);
                },
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, productIndex) {
                  return ProductCard(
                    product: products[productIndex],
                    isListView: true,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
