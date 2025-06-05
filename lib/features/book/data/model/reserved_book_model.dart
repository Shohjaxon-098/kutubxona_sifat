import 'package:kutubxona/features/book/domain/entities/reserved_book_entity.dart';

class ReserveBookModel extends ReserveBookEntity {
  ReserveBookModel({
    String? takenAt,
    int? reservationId,
    String? message,
    int? book,
  }) : super(
         takenAt: takenAt,
         reservationId: reservationId,
         message: message,
         book: book,
       );

  factory ReserveBookModel.fromJson(Map<String, dynamic> json) {
    return ReserveBookModel(
      book: json['data']['book'] ?? 0,
      message: json['message'] ?? '',
      takenAt: json['data']['taken_at'] ?? '',
      reservationId: json['data']['reservation_id'] ?? 0,
    );
  }
}
