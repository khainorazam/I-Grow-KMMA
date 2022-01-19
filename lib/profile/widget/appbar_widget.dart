import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: const BackButton(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
