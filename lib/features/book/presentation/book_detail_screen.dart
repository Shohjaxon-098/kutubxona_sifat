import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/widgets/review_shimmer.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;

  const BookDetailScreen({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    _fetchInitialData();
  }

  void _fetchInitialData() {
    context.read<ReviewBloc>().add(
      FetchReviews(
        libraryId: AppConfig.libraryId.toString(),
        slug: AppConfig.slug.toString(),
      ),
    );
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
      appBar: _buildAppBar(),
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return const BookDetailLoadingScreen();
          } else if (state is BookDetailLoaded) {
            return _buildDetailContent(state.book);
          } else if (state is BookDetailError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar() {
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

  Widget _buildDetailContent(book) {
    final textColor = Theme.of(context).colorScheme.tertiary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookHeader(book),
          const SizedBox(height: 24),
          _buildSectionTitle('Қисқача', textColor),
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
          _buildTabSection(book),
        ],
      ),
    );
  }

  Widget _buildBookHeader(book) {
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

  Widget _buildTabSection(book) {
    final textColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
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
        IndexedStack(
          index: _currentTabIndex,
          children: [_buildInfoTab(book), _buildCommentTab()],
        ),
      ],
    );
  }

  Widget _buildInfoTab(book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField("ISBN", book.isbn),
        _buildField("Тил", book.language),
        _buildField("Сахифалар", book.pageCount.toString()),
      ],
    );
  }

  Widget _buildField(String title, String value) {
    final textColor = Theme.of(context).colorScheme.tertiary;
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

  Widget _buildCommentTab() {
    final _commentController = TextEditingController();
    int _selectedRating = 0;

    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return ReviewShimmer();
        } else if (state is ReviewLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCommentInputSection(_commentController, _selectedRating),
              const SizedBox(height: 12),
              Divider(color: AppColors().border),
              const SizedBox(height: 12),
              _buildReviewList(state.reviews),
            ],
          );
        } else if (state is ReviewError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCommentInputSection(
    TextEditingController controller,
    int selectedRating,
  ) {
    return BlocListener<PostReviewBloc, PostReviewState>(
      listener: (context, state) {
        if (state is PostReviewSuccess) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Фикр муваффақиятли юборилди")),
          );

          // Clear the input fields
          controller.clear();
          setState(() {
            selectedRating = 0;
          });

          // Option 1: Fetch the updated list of reviews (recommended if the list is large or frequently updated)
          context.read<ReviewBloc>().add(
            FetchReviews(
              libraryId: AppConfig.libraryId.toString(),
              slug: AppConfig.slug.toString(),
            ),
          );

          // Option 2: Directly add the new review to the list without fetching (useful for small lists)
          // context.read<ReviewBloc>().add(AddReview(newReview));
        } else if (state is PostReviewError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Хатолик: ${state.message}")));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Китоб хақида фикрингиз',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 16),
          StarRating(onRatingChanged: (rating) => selectedRating = rating),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Изох',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          BlocBuilder<PostReviewBloc, PostReviewState>(
            builder: (context, state) {
              return PrimaryButton(
                onPressed:
                    state is PostReviewLoading
                        ? null
                        : () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty && selectedRating > 0) {
                            context.read<PostReviewBloc>().add(
                              SubmitReview(
                                ReviewRequestEntity(
                                  score: selectedRating.toString(),
                                  review: text,
                                  bookId: widget.bookId,
                                ),
                              ),
                            );
                          }
                        },
                text: 'Юбориш',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(List reviews) {
    return Column(
      children:
          reviews.map((review) {
            final user = review.libraryMember!.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl ?? ''),
                    child:
                        user.photoUrl == null ? const Icon(Icons.person) : null,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  review.review,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Divider(color: AppColors().border),
              ],
            );
          }).toList(),
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

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  String formatDate(String createdAt) {
    final dateTime = DateTime.parse(createdAt);
    return DateFormat('yyyy.MM.dd').format(dateTime);
  }
}
