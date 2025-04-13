// class Book {
//   final int id;
//   final String title;

//   Book({required this.id, required this.title});

//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

class Book {
  final int id;
  final String name;
  final String janr;
  final int year;
  final double rate;

  Book( {required this.id,required this.name,required this.janr,required this.year,required this.rate});
}
