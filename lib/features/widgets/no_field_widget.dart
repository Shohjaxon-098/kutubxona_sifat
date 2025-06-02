import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final double imageHeight;

  const NoDataWidget({
    Key? key,
    required this.imagePath,
    required this.text,
    this.imageHeight = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(imagePath, height: imageHeight),
        SizedBox(height: 40),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
