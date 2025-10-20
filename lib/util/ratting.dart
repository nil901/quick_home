import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RatingStarsComman extends StatelessWidget {
  final double rating; // e.g. 3.5
  final double size;

  const RatingStarsComman({
    super.key,
    required this.rating,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    const starColor = Color(0xFFFFD700);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        if (rating >= starIndex) {
          return Icon(Icons.star, color: HexColor("#6F6F6F"), size: size);
        } else if (rating > index && rating < starIndex) {
          return Icon(Icons.star_half, color: HexColor("#6F6F6F"), size: size);
        } else {
          return Icon(Icons.star_border, color:HexColor("#6F6F6F"), size: size);
        }
      }),
    );
  }
}
