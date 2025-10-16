part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  final String error;
  EditProfileFailure({required this.error});
}

final class FetchProfileFailureState extends EditProfileState {
  final String error;

  FetchProfileFailureState({required this.error});
}

final class FetchProfileSuccessState extends EditProfileState {
  final UserProfileModel userProfileModel;

  FetchProfileSuccessState({required this.userProfileModel});
}

final class FetchProfileLoadingState extends EditProfileState {}
