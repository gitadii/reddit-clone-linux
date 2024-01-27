import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/commons/loader.dart';
import 'package:redditclone_linux/features/auth/controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return isLoading
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Create a community'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Comunnity name'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: communityNameController,
                    maxLength: 21,
                    decoration: const InputDecoration(
                      hintText: 'r/Community_name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      filled: true,
                      fillColor: Color(0xff111111),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1D8AEA),
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                    child: const Text(
                      'Create community',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
