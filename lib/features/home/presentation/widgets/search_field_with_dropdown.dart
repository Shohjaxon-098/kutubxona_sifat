import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/screens/book_detail_screen.dart';

class SearchFieldWithDropdown extends StatelessWidget {
  const SearchFieldWithDropdown({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.layerLink,
    required this.showDropdown,
    required this.onDropdownVisibilityChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final LayerLink layerLink;
  final bool showDropdown;
  final ValueChanged<bool> onDropdownVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(context),
          SizedBox(height: 4.h),
          if (showDropdown) _buildDropdown(),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return search(
      controller: controller,
      focusNode: focusNode,
      context: context,
      enabled: true,
      onSubmitted: (query) {
        context.read<SearchBloc>().add(SearchQueryChanged(query));
        onDropdownVisibilityChanged(query.isNotEmpty && focusNode.hasFocus);
      },
    );
  }

  Widget _buildDropdown() {
    return CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, 56.h), // searchField height + margin
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            },
            child: () {
              if (state is SearchLoading) {
                return _dropdownCard(
                  context: context,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: SizedBox(
                        width: 26.w,
                        height: 26.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                );
              } else if (state is SearchLoaded) {
                final books = state.books;
                if (books.isEmpty) {
                  return _dropdownCard(
                    context: context,
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Text(
                        "Hech qanday kitob topilmadi.",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  );
                }
                return _dropdownList(books, context);
              } else if (state is SearchError) {
                return _dropdownCard(
                  context: context,
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Text(
                      "Xatolik: ${state.message}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }(),
          );
        },
      ),
    );
  }

  Widget _dropdownCard({required Widget child, required BuildContext context}) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 400.w,
        constraints: BoxConstraints(maxHeight: 300.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: child,
      ),
    );
  }

  Widget _dropdownList(List books, BuildContext context) {
    return _dropdownCard(
      context: context,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: books.length,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        separatorBuilder:
            (_, __) => Divider(height: 1.h, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: book.image,
                fit: BoxFit.cover,
                height: 100.h,
                width: 45.w,
              ),
            ),
            title: Text(
              book.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.author,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  book.category,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDate(book.publishedDate),
                  style: TextStyle(fontSize: 10.sp),
                ),
                Text(
                  book.rating,
                  style: TextStyle(
                    color: AppColors().rateCount,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  isIos: true,
                  child: BookDetailScreen(book: book),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 400),
                ),
              );
              controller.text = book.name;
              focusNode.unfocus();
              onDropdownVisibilityChanged(false);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            hoverColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 4.h,
            ),
          );
        },
      ),
    );
  }
}

String formatDate(String publishedDate) {
  final dateTime = DateTime.parse(publishedDate);
  return DateFormat('yyyy').format(dateTime);
}
