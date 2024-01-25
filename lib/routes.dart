import 'package:flutter/material.dart';
import 'package:redditclone_linux/features/auth/screens/login_screen.dart';
import 'package:redditclone_linux/features/community/screens/create_community_screen.dart';
import 'package:redditclone_linux/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';


//LoggedOut route : after logging out where sould the user go :
final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

// When we have the user data then the user should navigate to homescreen:
final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen()),
  '/create-community' : (_) => const MaterialPage(child: CreateCommunityScreen()),
});