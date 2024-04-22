import 'package:flutter/material.dart';

Widget customButton({
  double height = 55.0,
  double width = double.infinity,
  required String text,
  required Color color,
  required Function onPressed,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          )),
    );