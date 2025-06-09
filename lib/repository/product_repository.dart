import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ProductRepository {
  static const String baseUrl =
      'https://www.io.pixelsoftwares.com/task_api.php';

  Future<List<Product>> fetchProducts({String? search}) async {
    var headers = {'apikey': 'pixel'};
    try {
      final uri = Uri.parse(baseUrl);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // The response has the expected structure
        if (data['status'] == 200 && data['data'] != null) {
          final List<dynamic> productsJson = data['data'];

          List<Product> products =
              productsJson.map((json) => Product.fromJson(json)).toList();

          // Apply search filter
          if (search != null && search.isNotEmpty) {
            products =
                products
                    .where(
                      (product) =>
                          product.title.toLowerCase().contains(
                            search.toLowerCase(),
                          ) ||
                          product.category.toLowerCase().contains(
                            search.toLowerCase(),
                          ) ||
                          product.description.toLowerCase().contains(
                            search.toLowerCase(),
                          ),
                    )
                    .toList();
          }

          return products;
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> getProductById(String productId) async {
    var body = {'product_id': productId};
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'apikey': 'pixel'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Product.fromJson(data['product']);
        }
      }
      throw Exception('Failed to load product details');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
