import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/about_us_entity.dart';
import '../../../domain/usecases/get_about_us_usecase.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final GetAboutUsUseCase useCase;

  AboutUsBloc(this.useCase) : super(AboutUsInitial()) {
    on<LoadAboutUsEvent>((event, emit) async {
      emit(AboutUsLoading());
      try {
        final aboutUs = await useCase();
        emit(AboutUsLoaded(aboutUs));
      } catch (e) {
        emit(AboutUsError(e.toString()));
      }
    });
  }
}
