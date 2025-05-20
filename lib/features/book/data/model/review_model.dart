import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.score,
    required super.review,
    required super.createdAt,
    required super.libraryMember,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      score: json['score'],
      review: json['review'],
      createdAt: json['created_at'],
      libraryMember:
          json['library_member'] != null
              ? LibraryMemberModel.fromJson(json['library_member'])
              : LibraryMemberEntity(
                user: UserEntity(firstName: '', lastName: '', id: 0),
              ), // fallback
    );
  }
}

class LibraryMemberModel extends LibraryMemberEntity {
  LibraryMemberModel({required super.user});

  factory LibraryMemberModel.fromJson(Map<String, dynamic> json) {
    return LibraryMemberModel(
      user: UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        middleName: json['middle_name'],
        photoUrl: json['photo'], // photo: null => safe access
      ),
    );
  }
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,

    required super.firstName,
    required super.lastName,
    super.middleName,
    super.photoUrl,
  });
}
