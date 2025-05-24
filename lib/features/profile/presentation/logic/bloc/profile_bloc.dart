import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/profile_event.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase updateUseCase;

  ProfileBloc(this.updateUseCase) : super(ProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        await updateUseCase(event.model);
        emit(ProfileUpdated());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
