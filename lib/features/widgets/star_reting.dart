// star_rating.dart
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;

  const StarRating({super.key, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1;
              widget.onRatingChanged(_rating);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              size: 32,
              color: index < _rating ? Colors.amber : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
