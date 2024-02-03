import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModToolTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const ModToolTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(icon),
      title: Text(title),
      trailing: const FaIcon(FontAwesomeIcons.arrowRight),
      onTap: () {
        onTap();
      },
    );
  }
}
