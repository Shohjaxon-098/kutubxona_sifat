import 'package:kutubxona/core/core_exports.dart';

class GreetingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  GreetingHeaderDelegate(this.child);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  double get maxExtent => 70;
  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant GreetingHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
