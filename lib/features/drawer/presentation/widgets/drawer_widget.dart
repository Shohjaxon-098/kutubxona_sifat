import 'package:kutubxona/core/core_exports.dart';

class DrawerItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 1.0,
          height: 1.2,
          shadows: const [
            Shadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 2),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
