part of 'setting_cubit.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class ProfileFailureState extends SettingState {
  final String error;

  ProfileFailureState({required this.error});
}
