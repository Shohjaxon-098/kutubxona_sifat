import 'package:kutubxona/features/drawer/domain/entities/contribution.dart';

abstract class ContributionState {}
class ContributionInitial extends ContributionState {}
class ContributionLoading extends ContributionState {}
class ContributionLoaded extends ContributionState {
  final Contribution contributions;
  ContributionLoaded(this.contributions);
}
class ContributionError extends ContributionState {
  final String message;
  ContributionError(this.message);
}