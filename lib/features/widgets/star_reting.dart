// star_rating.dart
import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

// ignore: must_be_immutable
class StarRating extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;
  int rating;
  StarRating({super.key, required this.onRatingChanged, required this.rating});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.rating = index + 1;
              widget.onRatingChanged(widget.rating);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset(
              AppImages().rate,

              color: index < widget.rating ? Color(0xffFF7F4D) : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
