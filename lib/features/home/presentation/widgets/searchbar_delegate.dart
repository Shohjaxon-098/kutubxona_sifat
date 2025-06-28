import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';

class GreetingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  GreetingHeaderDelegate(this.child);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  double get maxExtent => 70.h;

  @override
  double get minExtent => 70.h;

  @override
  bool shouldRebuild(covariant GreetingHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
