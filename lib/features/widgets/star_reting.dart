import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SvgPicture.asset(
              AppImages().rate,
              height: 24.h,
              width: 24.w,
              color: index < widget.rating
                  ? const Color(0xffFF7F4D)
                  : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
