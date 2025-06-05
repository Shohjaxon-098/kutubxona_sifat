import 'package:flutter/material.dart';
import 'package:kutubxona/features/drawer/domain/entities/top_reader_entity.dart';

class TopReadersSection extends StatelessWidget {
  final List<TopReaderEntity> readers;

  const TopReadersSection({super.key, required this.readers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Энг фаол китобхонлар',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            letterSpacing: 0.15,
          ),
        ),
        const SizedBox(height: 12),
        ...readers.map(
          (reader) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${reader.firstName} ${reader.lastName}"),
                Text("${reader.total} та китоб"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
