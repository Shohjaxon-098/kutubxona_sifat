part of 'about_us_bloc.dart';

abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  final AboutUsEntity aboutUs;

  AboutUsLoaded(this.aboutUs);
}

class AboutUsError extends AboutUsState {
  final String message;

  AboutUsError(this.message);
}
