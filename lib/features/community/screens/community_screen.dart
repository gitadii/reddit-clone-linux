// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/commons/errorText.dart';
import 'package:redditclone_linux/core/commons/loader.dart';
import 'package:redditclone_linux/features/auth/controller/auth_controller.dart';
import 'package:redditclone_linux/features/auth/controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      floating: true,
                      snap: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(community.banner),
                              fit: BoxFit
                                  .cover, // You may adjust the fit based on your requirement
                            ),
                          ),
                        ),
                      ),
                      // flexibleSpace: Stack(
                      //   children: [
                      //     Positioned.fill(
                      //       child: Image.network(
                      //         community.banner,
                      //         fit: BoxFit.fill,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                                radius: 35,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'r/${community.name}',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                community.mods.contains(user.uid)
                                    ? OutlinedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                          ),
                                          side: const BorderSide(
                                              color: Colors.blue),
                                        ),
                                        child: const Text(
                                          'Mod Tools',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    // : ElevatedButton(
                                    //     onPressed: () {},
                                    //     style: ElevatedButton.styleFrom(
                                    //         shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(20),
                                    //         ),
                                    //         padding: const EdgeInsets.symmetric(
                                    //           horizontal: 25,
                                    //         ),
                                    //         backgroundColor: Colors.blue),
                                    //     child: Text(
                                    //       community.members.contains(user.uid)
                                    //           ? 'Joined'
                                    //           : 'join',
                                    //       style: const TextStyle(
                                    //         color: Colors.white,
                                    //         fontWeight: FontWeight.w600,
                                    //       ),
                                    //     ),
                                    //   ),
                                    : community.members.contains(user.uid)
                                        ? ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 25,
                                                ),
                                                backgroundColor: Colors.blue),
                                            child: const Text(
                                              'Joined',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : OutlinedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 25,
                                                ),
                                                backgroundColor: Colors.blue),
                                            child: const Text(
                                              'Join',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child:
                                  Text('${community.members.length} members'),
                            )
                          ],
                        ),
                      ),
                    )
                  ];
                },
                body: const Text('Displaying posts.'),
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
