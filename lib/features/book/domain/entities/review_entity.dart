class ReviewEntity {
  final String score;
  final String review;
  final String createdAt;
  final LibraryMemberEntity? libraryMember;

  ReviewEntity({
    required this.score,
    required this.review,
    required this.createdAt,
    required this.libraryMember,
  });
}

class LibraryMemberEntity {
  final UserEntity user;

  LibraryMemberEntity({required this.user});
}

class UserEntity {
  final int id;

  final String firstName;
  final String lastName;
  final String? middleName;
  final String? photoUrl;

  UserEntity({
    required this.id,

    required this.firstName,
    required this.lastName,
    this.middleName,
    this.photoUrl,
  });
}
