import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_rounded_images.dart';
import '../../../manager/edit_profile/edit_profile_cubit.dart';
import 'profile_container.dart';
import 'profile_info_loading.dart';

class ProfileViewBodyInfoSection extends StatelessWidget {
  const ProfileViewBodyInfoSection({super.key});
  @override
  Widget build(BuildContext context) {
    return ProfileContainer(
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchProfileLoadingState) {
            return const ProfileInfoLoading();
          } else if (state is FetchProfileSuccessState) {
            final userProfile = state.userProfileModel;
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: userProfile.profileImageUrl != null
                      ? Hero(
                          tag: userProfile.profileImageUrl!,
                          child: CustomRoundedImage(
                            imageUrl: userProfile.profileImageUrl!,
                            aspectRatio: 1,
                            width: 80,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                      : CustomRoundedImage(
                          imageUrl: "assets/icons/user.png",
                          isAsset: true,
                          aspectRatio: 1,
                          width: 80,
                          borderRadius: BorderRadius.circular(8),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userProfile.firstName} ${userProfile.lastName}",
                      style: TextStyles.medium20.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      userProfile.email,
                      style: TextStyles.medium12.copyWith(
                        color: context.colors.onSecondary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is FetchProfileFailureState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyles.bold16.copyWith(color: context.colors.error),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
