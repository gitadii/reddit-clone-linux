import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/commons/errorText.dart';
import 'package:redditclone_linux/core/commons/loader.dart';
import 'package:redditclone_linux/features/auth/controller/community_controller.dart';
import 'package:redditclone_linux/model/community_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunityByName(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          ListTile(
            title: const Text('Create a community'),
            leading: const Icon(Icons.add),
            onTap: () => navigateToCreateCommunity(context),
          ),
          ref.watch(userCommunitiesProvider).when(
              data: (communities) => Expanded(
                    child: ListView.builder(
                      itemCount: communities.length,
                      itemBuilder: (context, index) {
                        final community = communities[index];
                        return ListTile(
                          onTap: () {
                            navigateToCommunityByName(context, community);
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(community.avatar),
                          ),
                          title: Text(community.name),
                        );
                      },
                    ),
                  ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader())
        ],
      )),
    );
  }
}
