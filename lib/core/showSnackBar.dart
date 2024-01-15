import 'package:flutter/material.dart';

void showSnackBar( BuildContext context, String mssg) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(mssg)));
}