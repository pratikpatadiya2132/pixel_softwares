
// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_softwares/mixin/utility_mixins.dart';

import '../widgets/custom_rating_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String title;
  final String description;
  final int price;
  final double rating;
  final int count;
  final String image;
  final String category;
  final String brand;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.count,
    required this.image,
    required this.category,
    required this.brand,
  });

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen>
    with UtilityMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Icon(Icons.favorite_border, color: Colors.black),
          const SizedBox(width: 8),
          Icon(Icons.shopping_cart_outlined, color: Colors.black),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                image:
                    widget.image.isNotEmpty
                        ? DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.contain,
                        )
                        : null,
                color: Colors.white,
              ),
              child:
                  widget.image.isEmpty
                      ? const Center(
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.white,
                        ),
                      )
                      : null,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.brand,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.5,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.title.toUpperCase()}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.5,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xB8000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Ratings',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.5,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Row(
                    children: [
                      CustomRatingBar(rating: widget.rating, itemSize: 15),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.rating}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.6,
                          color: const Color(0xAC000000),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(${widget.count})',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.6,
                          color: const Color(0xAC000000),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 75,
        child: Column(
          children: [
            Divider(color: Colors.black.withOpacity(0.3), thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${widget.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Add to Cart',
                     style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
