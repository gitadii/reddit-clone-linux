import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/commons/errorText.dart';
import 'package:redditclone_linux/core/commons/loader.dart';
import 'package:redditclone_linux/core/constants/constants.dart';
import 'package:redditclone_linux/core/utils.dart';
import 'package:redditclone_linux/features/auth/controller/community_controller.dart';
import 'package:redditclone_linux/theme/pallet.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  // Pop-up to select banner image
  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  // Pop-up to select profile image
  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            backgroundColor: Pallete.darkModeAppTheme.colorScheme.background,
            appBar: AppBar(
              backgroundColor: Pallete.darkModeAppTheme.colorScheme.background,
              title: const Text(
                'Edit community',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorder(
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            radius: const Radius.circular(10),
                            color: Pallete
                                .darkModeAppTheme.textTheme.bodyMedium!.color!,
                            borderType: BorderType.RRect,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: bannerFile !=
                                      null // If the use has selected a custom banner immage than show it else show default
                                  ? Image.file(bannerFile!)
                                  : community.banner.isEmpty ||
                                          community.banner ==
                                              Constants.bannerDefault
                                      ? const Center(
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 40,
                                          ),
                                        )
                                      : Image.network(community.banner),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileFile != null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(profileFile!),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: community.avatar.isEmpty ||
                                            community.avatar ==
                                                Constants.avatarDefault
                                        ? const NetworkImage(
                                            Constants.avatarDefault)
                                        : NetworkImage(community.avatar),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
