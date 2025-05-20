import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/user_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  UserProfileBloc(this.getUserProfileUseCase) : super(UserProfileInitial()) {
    on<GetUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final result = await getUserProfileUseCase();
        emit(UserProfileLoaded(result));
      } catch (e) {
        emit(UserProfileError(e.toString()));
      }
    });
  }
}

