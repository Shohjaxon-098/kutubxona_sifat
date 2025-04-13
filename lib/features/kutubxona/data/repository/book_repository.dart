// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:kutubxona/features/kutubxona/data/models/book.dart';


// class BookRepository {
//   Future<List<Book>> searchBooks(String query) async {
//     final response = await http.get(
//       Uri.parse('https://api.example.com/books?search=$query'),
//     );

//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//       return data.map((json) => Book.fromJson(json)).toList();
//     } else {
//       throw Exception("Kitoblarni yuklab bo‘lmadi");
//     }
//   }
// }
