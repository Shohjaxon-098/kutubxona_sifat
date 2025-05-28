abstract class StatisticEvent {}

class LoadStatistics extends StatisticEvent {
  final String libraryId;

  LoadStatistics(this.libraryId);
}
