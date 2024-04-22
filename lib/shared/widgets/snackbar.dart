import 'package:flutter/material.dart';


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar ({required text ,required context}) =>

    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    padding: const EdgeInsetsDirectional.all(20),
    content: Text(text , style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold , color: Colors.white), ),
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 5),
  ),
);