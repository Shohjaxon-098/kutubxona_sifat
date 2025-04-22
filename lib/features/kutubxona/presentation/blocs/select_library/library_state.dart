import 'package:kutubxona/features/kutubxona/domain/entities/library_entity.dart';

abstract class LibraryState {}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<LibraryEntity> libraries;
  LibraryLoaded(this.libraries);
}

class LibraryError extends LibraryState {
  final String message;
  LibraryError(this.message);
}