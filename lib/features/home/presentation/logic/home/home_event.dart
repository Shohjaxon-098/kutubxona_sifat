import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

// lib/features/kutubxona/presentation/blocs/home/home_event.dart

class GetAllHomeDataEvent extends HomeEvent {
  final int? categoryId;
  final String? year;
  final List<int>? ratings;
  const GetAllHomeDataEvent({this.categoryId, this.year, this.ratings});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError(); // Bu event, HomeBloc'da barcha ma'lumotlarni olish uchun chaqiriladi
}
