import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/features/auth/controller/auth_controller.dart';
import 'package:redditclone_linux/features/home/drawers/community_list_drawer.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer( BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
            );
          }
        ),
        title: const Text('Home', 
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search),),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 13.0,
            ),
            onPressed: () {},
          )
        ],
        ),
      body: Center(
        child : Text(user.karma.toString()),
      ),
      drawer: CommunityListDrawer(),
    );
  }
}