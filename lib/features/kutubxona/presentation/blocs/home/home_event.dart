import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

// lib/features/kutubxona/presentation/blocs/home/home_event.dart

class GetAllHomeDataEvent extends HomeEvent {
  GetAllHomeDataEvent();
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();  // Bu event, HomeBloc'da barcha ma'lumotlarni olish uchun chaqiriladi
}

class SearchBooksEvent extends HomeEvent {
  final String query;

  const SearchBooksEvent(this.query);

  @override
  List<Object?> get props => [query];
}
