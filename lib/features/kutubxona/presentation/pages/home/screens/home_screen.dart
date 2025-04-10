import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/home/widgets/all_categories.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/home/widgets/single_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors().cardColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors().cardColor,
                image: DecorationImage(
                  image: AssetImage(AppImages().mask),

                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ассалому алайкум!\nИсмоилбек',
                    style: TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.clip,
                      color: AppColors().white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors().white,
                    radius: 28,
                    child: SvgPicture.asset(AppImages().person, width: 40),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(33),
                topRight: Radius.circular(33),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors().white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          style: TextStyle(color: AppColors().black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors().searchBack,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors().searchIcon,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors().searchIcon,
                            ),
                            hintText: "Қидириш",
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Рукнлар',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Барчаси',
                                style: TextStyle(
                                  color: AppColors().blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          AllCategories(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Куннинг енг яхшилари',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleCategories(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
