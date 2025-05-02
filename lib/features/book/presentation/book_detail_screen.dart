import 'package:cached_network_image/cached_network_image.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/book_reviews_event.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/book_reviews_state.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_event.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_state.dart';
import 'package:kutubxona/features/widgets/book_detail_loading.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ReviewBloc>().add(
      FetchReviews(
        libraryId: AppConfig.libraryId.toString(),
        slug: AppConfig.slug.toString(),
      ),
    );
    _loadBookDetailOnce();
  }

  Future<void> _loadBookDetailOnce() async {
    context.read<BookDetailBloc>().add(
      FetchBookDetail(
        AppConfig.libraryId.toString(),
        AppConfig.slug.toString(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return const BookDetailLoadingScreen();
          } else if (state is BookDetailLoaded) {
            return _buildDetailContent(context, state);
          } else if (state is BookDetailError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
      title: Text(
        "Китоб ҳақида",
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildDetailContent(BuildContext context, BookDetailLoaded state) {
    final book = state.book;
    final textColor = Theme.of(context).colorScheme.tertiary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookHeader(context, book),
          const SizedBox(height: 24),
          Text(
            'Қисқача',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(book.description),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {},
            ttext: Text(
              "Банд қилиш",
              style: TextStyle(color: AppColors().white),
            ),
          ),
          const SizedBox(height: 20),
          _buildTabSection(context, book),
        ],
      ),
    );
  }

  Widget _buildBookHeader(BuildContext context, book) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            placeholder:
                (context, url) => _buildShimmerBox(width: 123, height: 158),
            imageUrl: book.image,
            width: 123,
            height: 158,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                book.author,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              _buildLabelValueRow("Рукн:", book.category),
              const SizedBox(height: 5),
              _buildLabelValueRow("Тил:", book.language),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  Text('${book.rating}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelValueRow(String label, String value) {
    final labelColor = Theme.of(context).colorScheme.tertiary;
    final valueColor = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: labelColor),
        ),
        Text(value, style: TextStyle(color: valueColor)),
      ],
    );
  }

  Widget _buildTabSection(BuildContext context, book) {
    final textColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          labelColor: textColor,
          unselectedLabelColor: Colors.grey,
          tabs: const [Tab(text: "Маълумотлар"), Tab(text: "Фикрлар")],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [_buildInfoTab(context, book), _buildCommentTab(context)],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTab(BuildContext context, book) {
    final textColor = Theme.of(context).colorScheme.tertiary;

    Widget buildField(String title, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, color: textColor),
            ),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(color: textColor)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildField("ISBN", book.isbn),
        buildField("Тил", book.language),
        buildField("Сахифалар", book.pageCount.toString()),
      ],
    );
  }

  Widget _buildCommentTab(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewLoaded) {
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  state.reviews.map((review) {
                    final user = review.libraryMember!.user;
                    return Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 47,
                            height: 47,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl!),
                              child:
                                  user.photoUrl == null
                                      ? Icon(Icons.person)
                                      : null,
                            ),
                          ),
                          title: Text(
                            "${user.firstName} ${user.lastName}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          subtitle: Text(
                            formatDate(review.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          review.review,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          );
        } else if (state is ReviewError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
      ),
    );
  }
}

String formatDate(String createdAt) {
  final dateTime = DateTime.parse(createdAt);
  return DateFormat('yyyy.MM.dd').format(dateTime);
}
