import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class SingleCategories extends StatelessWidget {
  const SingleCategories({super.key});

  @override
  Widget build(BuildContext context) {
    List ruknlar = [
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
      "Жахон адабиёти",
    ];
    return SizedBox(
      width: double.infinity,
      height: 158,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.3,
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder:
            (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: AppColors().black),
                child: Center(
                  child: Text(
                    ruknlar[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors().white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
