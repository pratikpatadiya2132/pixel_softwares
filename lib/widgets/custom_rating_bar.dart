// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  final int itemCount;
  final double itemSize;
  final Color activeColor;
  final Color inactiveColor;

  const CustomRatingBar({
    Key? key,
    required this.rating,
    this.itemCount = 5,
    this.itemSize = 16,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_outline,
          color: index < rating ? activeColor : inactiveColor,
          size: itemSize,
        );
      }),
    );
  }
}