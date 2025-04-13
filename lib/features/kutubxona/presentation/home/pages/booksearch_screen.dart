import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/features/kutubxona/data/models/book.dart';
import 'package:kutubxona/features/kutubxona/enums/filter_type.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_state.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/widgets/fileter_panel.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/widgets/search_widget.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key, this.onBookSelected});
  final void Function(Book)? onBookSelected;
  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final List<Book> offlineBooks = [
    Book(
      id: 1,
      name: "Alkimyogar",
      janr: 'Fantastika,Siyosat',
      year: 1768,
      rate: 4.2,
    ),
    Book(
      id: 2,
      name: "Shaytanat",
      janr: 'Fantastika,Siyosat',
      year: 1984,
      rate: 4.7,
    ),
    Book(
      id: 3,
      name: "Temur tuzuklari",
      janr: 'Fantastika,Siyosat',
      year: 1945,
      rate: 4.4,
    ),
    Book(
      id: 4,
      name: "Ikki eshik orasi",
      janr: 'Fantastika,Siyosat',
      year: 1923,
      rate: 5,
    ),
    Book(
      id: 5,
      name: "O‘tkan kunlar",
      janr: 'Fantastika,Siyosat',
      year: 1890,
      rate: 4.0,
    ),
    Book(id: 6, name: "Ufq", janr: 'Fantastika,Siyosat', year: 2000, rate: 4.4),
  ];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Sahifa ochilganda fokusni avtomatik berish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  FilterType selectedFilter = FilterType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors().white,
        title: Text(
          "Китоблар",
          style: TextStyle(color: AppColors().textColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              search(
                enabled: true,
                focusNode: _focusNode,
                controller: _controller,
                onChanged: (value) {
                  final query = value.trim();
                  context.read<BookSearchBloc>().add(SearchBooks(query));
                },
              ),
              const FilterPanel(),
              BlocBuilder<BookSearchBloc, BookSearchState>(
                builder: (context, state) {
                  if (state is BookSearchLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BookSearchLoaded) {
                    if (state.results.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Натижа топилмади"),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final book = state.results[index];
                        return ListTile(title: Text(book.name), onTap: () {});
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
