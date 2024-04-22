import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightingTheme() => ThemeData(

  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),

    elevation: 0.0,

    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);