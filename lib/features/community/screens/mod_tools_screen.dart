import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redditclone_linux/core/commons/mod_tool_tile.dart';
import 'package:redditclone_linux/core/commons/mod_tools_section.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends ConsumerWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});

  void nevigateToModScreen(BuildContext context) {
    Routemaster.of(context).push('/mod-screen/$name');
  }

  void navigateToEditCommunityScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Moderator Tools',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('GENERAL'),
            ModToolSection(
              items: [
                ModToolTile(
                  icon: FontAwesomeIcons.bars,
                  title: 'Mod Log',
                  onTap: () {},
                ),
                ModToolTile(
                  icon: FontAwesomeIcons.chartLine,
                  title: 'Insights',
                  onTap: () {},
                ),
                ModToolTile(
                  icon: FontAwesomeIcons.pen,
                  title: 'Edit community',
                  onTap: () => navigateToEditCommunityScreen(context),
                ),
                ModToolTile(
                  icon: FontAwesomeIcons.solidMessage,
                  title: 'Welcome message',
                  onTap: () {},
                ),
              ],
            ),
            const Text('CONTENT & REGULATIONS'),
            ModToolSection(
              items: [
                ModToolTile(
                  icon: FontAwesomeIcons.key,
                  title: 'Safety',
                  onTap: () {},
                ),
                ModToolTile(
                  icon: FontAwesomeIcons.xmark,
                  title: 'Removal reasons',
                  onTap: () {},
                ),
                ModToolTile(
                  icon: FontAwesomeIcons.clock,
                  title: 'Scheduled post',
                  onTap: () {},
                ),
              ],
            ),
            const Text('USER MANAGEMENT'),
            ModToolSection(
              items: [
                ModToolTile(
                    icon: FontAwesomeIcons.shield,
                    title: 'Moderators',
                    onTap: () => nevigateToModScreen(context)),
                ModToolTile(
                  icon: FontAwesomeIcons.user,
                  title: 'Approved users',
                  onTap: () {},
                ),
              ],
            ),
            const Text('RESOURCE LINKS'),
          ],
        ),
      ),
    );
  }
}
