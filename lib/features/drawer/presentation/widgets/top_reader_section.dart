import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/features/drawer/domain/entities/top_reader_entity.dart';

class TopReadersSection extends StatelessWidget {
  final List<TopReaderEntity?> readers;

  const TopReadersSection({super.key, required this.readers});

  @override
  Widget build(BuildContext context) {
    if (readers.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Энг фаол китобхонлар',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            letterSpacing: 0.15,
          ),
        ),
        SizedBox(height: 12.h),
        ...readers.map(
          (reader) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${reader!.firstName} ${reader.lastName}",
                  style: TextStyle(fontSize: 14.sp),
                ),
                Text(
                  "${reader.total} та китоб",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
