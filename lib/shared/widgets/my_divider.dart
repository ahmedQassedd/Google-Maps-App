import 'package:flutter/material.dart';

Widget myDivider({context}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    height: 1.5,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
  ),
);