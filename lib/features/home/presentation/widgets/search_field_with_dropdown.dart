import 'package:kutubxona/export.dart';

class SearchFieldWithDropdown extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final LayerLink layerLink;
  final bool showDropdown;
  final ValueChanged<bool> onDropdownVisibilityChanged;

  const SearchFieldWithDropdown({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.layerLink,
    required this.showDropdown,
    required this.onDropdownVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(child: _buildSearchField(context)),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => showFilterModal(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
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
      onChanged: (query) {
        context.read<SearchBloc>().add(SearchQueryChanged(query));
        onDropdownVisibilityChanged(query.isNotEmpty && focusNode.hasFocus);
      },
    );
  }

  Widget _buildDropdown() {
    return CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      offset: const Offset(0, 56), // searchField height + margin
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
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              } else if (state is SearchLoaded) {
                final books = state.books;
                if (books.isEmpty) {
                  return _dropdownCard(
                    context: context,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Hech qanday kitob topilmadi."),
                    ),
                  );
                }
                return _dropdownList(books, context);
              } else if (state is SearchError) {
                return _dropdownCard(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text("Xatolik: ${state.message}"),
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        separatorBuilder:
            (_, __) => Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(book.image, fit: BoxFit.cover, height: 100),
            ),
            title: Text(
              book.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.author,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  book.category,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDate(book.publishedDate)),

                Text(
                  book.rating,
                  style: TextStyle(
                    color: AppColors().rateCount,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () {
              controller.text = book.name;
              focusNode.unfocus();
              onDropdownVisibilityChanged(false);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hoverColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
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
