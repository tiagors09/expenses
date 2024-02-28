import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  final String? label;

  const AdaptativeTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.onSubmitted,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            placeholder: label,
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              label: Text(label ?? ''),
            ),
          );
  }
}
