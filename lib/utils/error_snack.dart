import 'package:flutter/material.dart';

class ShowSnack {
  static showSnackBar(BuildContext context, {String? error}) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error!)));
  }
}
