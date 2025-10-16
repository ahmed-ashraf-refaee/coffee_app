import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../../authentication/data/model/user_profile_model.dart';
import '../../../../authentication/data/repo/auth_repo_impl.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  void editProfileData({
    required String firstName,
    required String lastName,
    required String userName,
    required File? imageFile,
  }) async {
    emit(EditProfileLoading());
    var result = await ProfileRepoImpl().editProfileData(
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      imageFile: imageFile,
    );
    result.fold(
      (failure) => emit(EditProfileFailure(error: failure.error)),
      (_) => emit(EditProfileSuccess()),
    );
  }

  fetchUserData() async {
    emit(FetchProfileLoadingState());
    var result = await AuthRepoImpl().getUserData();
    result.fold(
      (failure) => emit(FetchProfileFailureState(error: failure.error)),
      (user) => emit(FetchProfileSuccessState(userProfileModel: user)),
    );
  }
}
