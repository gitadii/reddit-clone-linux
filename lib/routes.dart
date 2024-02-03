import 'package:flutter/material.dart';
import 'package:redditclone_linux/features/auth/screens/login_screen.dart';
import 'package:redditclone_linux/features/community/screens/community_screen.dart';
import 'package:redditclone_linux/features/community/screens/create_community_screen.dart';
import 'package:redditclone_linux/features/community/screens/edit_community_screen.dart';
import 'package:redditclone_linux/features/community/screens/mod_tools_screen.dart';
import 'package:redditclone_linux/features/community/screens/moderator_screen.dart';
import 'package:redditclone_linux/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

//LoggedOut route : after logging out where sould the user go :
final loggedOutRoute =
    RouteMap(routes: {'/': (_) => const MaterialPage(child: LoginScreen())});

// When we have the user data then the user should navigate to homescreen:
final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) =>
      MaterialPage(child: CommunityScreen(name: route.pathParameters['name']!)),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(name: routeData.pathParameters['name']!),
      ),
  '/mod-screen/:name': (routeData) => MaterialPage(
          child: ModeratorScreen(
        name: routeData.pathParameters['name']!,
      )),
  '/edit-community/:name': (routeData) => MaterialPage(
          child: EditCommunityScreen(
        name: routeData.pathParameters['name']!,
      )),
});
