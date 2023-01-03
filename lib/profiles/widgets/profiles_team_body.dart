import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/profiles/models/human.dart';
import 'package:rhst/profiles/profiles.dart';
import 'package:rhst/profiles/widgets/rhst_profile_avatar.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

import '../../auth/bloc/auth_bloc.dart';
import 'rhst_image_carousel.dart';

class ProfileTeamBody extends StatelessWidget {
  const ProfileTeamBody({super.key});

  _buildDogAvatars(BuildContext context, Human human) => human.dogs.map(
        (dog) => GestureDetector(
          onTap: () => _selectNewDogAvatar(context, human.id!, dog.id!),
          child: RHSTProfileAvatar(
            name: dog.name,
            imagePath: dog.profilePicPath,
          ),
        ),
      );

  _selectNewDogAvatar(BuildContext context, String humanId, String dogId) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((result) {
      if (result == null) return;
      final path = result.path;
      context.read<ProfilesBloc>().updateDogProfilePicture(path, humanId, dogId);
    });
  }

  _selectNewHumanAvatar(BuildContext context, String humanId) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((result) {
      if (result == null) return;
      final path = result.path;
      context.read<ProfilesBloc>().updateHumanProfilePicture(path, humanId);
    });
  }

  _selectNewGalleryImage(BuildContext context, String humanId, int position) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((result) {
      if (result == null) return;
      final path = result.path;
      context.read<ProfilesBloc>().putGalleryPicture(path, position, humanId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final humanId = ModalRoute.of(context)!.settings.arguments as String;
    final canEdit = context.read<AuthBloc>().user?.uid == humanId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RHSTAppBar(),
        const RHSTSpacer(3),
        BlocBuilder<ProfilesBloc, ProfilesState>(
          builder: (context, state) {
            final human = state.profiles.firstWhere((p) => p.id == humanId);
            return Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.defaultSpace * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RHSTCard(
                        padding: const EdgeInsets.symmetric(vertical: Constants.defaultSpace * 2.5),
                        inverse: true,
                        child: Text(
                          "Profil",
                          textAlign: TextAlign.center,
                          style: Styles.headline.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const RHSTSpacer(3),
                      SizedBox(
                        height: 176,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap:
                                  canEdit ? () => _selectNewHumanAvatar(context, human.id!) : null,
                              child: RHSTProfileAvatar(
                                name: human.firstName,
                                imagePath: human.profilePicPath,
                              ),
                            ),
                            ..._buildDogAvatars(context, human),
                          ],
                        ),
                      ),
                      const RHSTSpacer(3),
                      RHSTImageCarousel(
                        galleryRefs: human.galleryReferences,
                        canEdit: canEdit,
                        onTap: (i) => _selectNewGalleryImage(context, human.id!, i),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
