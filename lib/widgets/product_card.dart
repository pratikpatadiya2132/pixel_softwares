// ignore_for_file: use_super_parameters, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_softwares/mixin/utility_mixins.dart';
import '../model/product_model.dart';
import '../screen/product_detail_screen.dart';

class ProductCard extends StatelessWidget with UtilityMixin {
  final Product product;
  final bool isListView;

  const ProductCard({Key? key, required this.product, this.isListView = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isListView) {
      return GestureDetector(
        onTap: () {
          navigationPush(
            context,
            ProductDetailScreen(
              productId: product.id.toString(),
              image: product.image,
              title: product.title,
              description: product.description,
              price: product.price.toInt(),
              category: product.category,
              brand: product.brand,
              rating: product.rating.rate,
              count: product.rating.count,
            ),
          );
        },
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            title: Text(
              product.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13.5,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '₹${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: product.rating.rate > 0
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        product.rating.rate.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        navigationPush(
          context,
          ProductDetailScreen(
            productId: product.id.toString(),
            image: product.image,
            title: product.title,
            description: product.description,
            price: product.price.toInt(),
            category: product.category,
            brand: product.brand,
            rating: product.rating.rate,
            count: product.rating.count,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.rating.rate > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            ' ${product.rating.rate.toStringAsFixed(1)}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Text(
                    product.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.5,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
