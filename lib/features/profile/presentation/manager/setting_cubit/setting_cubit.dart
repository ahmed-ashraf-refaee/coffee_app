import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:meta/meta.dart';


part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  final ProfileRepoImpl _profileRepoImpl = ProfileRepoImpl();
  logout() async {
    var result = await _profileRepoImpl.logoutUser();
    result.fold(
      (failure) => emit(ProfileFailureState(error: failure.error)),
      (_) {},
    );
  }

  launchPhoneDialer({required String phone}) async {
    var result = await _profileRepoImpl.launchPhoneDialer(phone: phone);
    result.fold(
      (failure) => emit(ProfileFailureState(error: failure.error)),
      (_) {},
    );
  }

  launchWhatsApp({required String phone}) async {
    var result = await _profileRepoImpl.launchWhatsApp(phone: phone);
    result.fold(
      (failure) => emit(ProfileFailureState(error: failure.error)),
      (_) {},
    );
  }
}
