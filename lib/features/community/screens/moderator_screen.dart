import 'package:flutter/material.dart';

class ModeratorScreen extends StatelessWidget {
  final String name;
  const ModeratorScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moderators'),
          actions: const [
            Icon(Icons.add),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Editable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.blue,
          ),
        ),
        body: const TabBarView(
          children: [
            Column(),
            Column(),
          ],
        ),
      ),
    );
  }
}
