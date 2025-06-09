import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_bloc.dart';
import 'repository/product_repository.dart';
import 'screen/product_listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Listing App',
      home: BlocProvider(
        create: (context) => ProductBloc(repository: ProductRepository()),
        child: const ProductListingScreen(),
      ),
    );
  }
}