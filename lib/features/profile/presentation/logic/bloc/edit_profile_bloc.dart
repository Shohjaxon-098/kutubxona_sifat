import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase updateProfile;

  ProfileBloc(this.updateProfile) : super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await updateProfile( event.entity);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
