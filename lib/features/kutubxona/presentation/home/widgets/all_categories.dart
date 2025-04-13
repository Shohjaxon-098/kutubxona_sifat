import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

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
      height: 270,
      child: GridView.builder(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 3,
        ),
        itemBuilder:
            (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(5),
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
