abstract class ContributionEvent {}
class LoadContributions extends ContributionEvent {
  final String libraryId;
  LoadContributions(this.libraryId);
}