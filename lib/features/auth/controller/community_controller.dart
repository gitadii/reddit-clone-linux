import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/constants/constants.dart';
import 'package:redditclone_linux/core/showSnackBar.dart';
import 'package:redditclone_linux/features/auth/controller/auth_controller.dart';
import 'package:redditclone_linux/features/community/repository/community_repository.dart';
import 'package:redditclone_linux/model/community_model.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
    communityRepository: ref.watch(communityRepositoryProvider),
    ref: ref,
  );
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    Community community = Community(
      id: name,
      name: name,
      avatar: Constants.avatarDefault,
      banner: Constants.bannerDefault,
      members: [uid],
      mods: [uid],
    );

    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.mssg), (r) {
      showSnackBar(context, 'Community created');
      Routemaster.of(context).pop();
    });
  }
}
