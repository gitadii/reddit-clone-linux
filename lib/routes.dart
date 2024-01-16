import 'package:flutter/material.dart';
import 'package:redditclone_linux/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';


//LoggedOut route : after logging out where sould the user go :
final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});