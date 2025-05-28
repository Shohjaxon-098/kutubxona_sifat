import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_contributions.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_event.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_state.dart';

class ContributionBloc extends Bloc<ContributionEvent, ContributionState> {
  final GetContributions getContributions;

  ContributionBloc(this.getContributions) : super(ContributionInitial()) {
    on<LoadContributions>((event, emit) async {
      emit(ContributionLoading());
      try {
        final contributions = await getContributions(event.libraryId);
        emit(ContributionLoaded(contributions));
      } catch (e) {
        emit(ContributionError(e.toString()));
      }
    });
  }
}
