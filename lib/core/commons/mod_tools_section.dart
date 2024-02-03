import 'package:flutter/material.dart';

class ModToolSection extends StatelessWidget {
  final List<Widget> items;
  const ModToolSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: items,
      ),
    );
  }
}
