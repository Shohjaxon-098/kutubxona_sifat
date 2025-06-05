import 'package:kutubxona/core/core_exports.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                fontSize: 13,
                letterSpacing: 0.25,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            textAlign: TextAlign.right,
            value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              letterSpacing: 0.25,
              fontSize: 13,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
