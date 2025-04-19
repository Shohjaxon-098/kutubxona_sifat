// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kutubxona/core/util/app_images.dart';
// import 'package:kutubxona/features/kutubxona/data/models/book.dart';
// import 'package:kutubxona/features/kutubxona/enums/filter_type.dart';
// import 'package:kutubxona/features/kutubxona/presentation/blocs/book_search/book_search_bloc.dart';
// import 'package:kutubxona/features/kutubxona/presentation/blocs/book_search/book_search_event.dart';
// import 'package:kutubxona/features/kutubxona/presentation/blocs/book_search/book_search_state.dart';
// import 'package:kutubxona/features/kutubxona/presentation/home/widgets/search_widget.dart';

// class BookSearchScreen extends StatefulWidget {
//   const BookSearchScreen({super.key, });

//   @override
//   State<BookSearchScreen> createState() => _BookSearchScreenState();
// }

// class _BookSearchScreenState extends State<BookSearchScreen> {
//   final FocusNode _focusNode = FocusNode();
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // Sahifa ochilganda fokusni avtomatik berish
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_focusNode);
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

//   FilterType selectedFilter = FilterType.none;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         title: Text(
//           "Китоблар",
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.tertiary,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               search(
//                 context: context,
//                 enabled: true,
//                 focusNode: _focusNode,
//                 controller: _controller,
//                 onChanged: (value) {
//                   final query = value.trim();
                
//                 },
//               ),
//               const SizedBox(height: 25),
//               BlocBuilder<BookSearchBloc, BookSearchState>(
//                 builder: (context, state) {
//                   if (state is BookSearchLoading) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 100),
//                       child: CircularProgressIndicator(
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     );
//                   } else if (state is BookSearchLoaded) {
//                     if (state.results.isEmpty) {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 100),
//                           SvgPicture.asset(AppImages().noResult),
//                           const SizedBox(height: 30),
//                           const Text(
//                             textAlign: TextAlign.center,
//                             "Сизнинг сўровингиз бўйича\nхеч нарса топилмади!",
//                           ),
//                         ],
//                       );
//                     }
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: state.results.length,
//                       itemBuilder: (context, index) {
//                         final book = state.results[index];
//                         return ListTile(title: Text(book.name), onTap: () {});
//                       },
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
