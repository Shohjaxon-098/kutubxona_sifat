import '../../../domain/entities/statistic_entity.dart';

abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final StatisticEntity statistic;

  StatisticLoaded(this.statistic);
}

class StatisticError extends StatisticState {
  final String message;

  StatisticError(this.message);
}
