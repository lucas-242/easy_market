import 'package:flutter/material.dart';

class ShowPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool showing;

  const ShowPasswordButton(
      {Key? key, required this.onPressed, required this.showing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(showing ? Icons.visibility : Icons.visibility_off),
    );
  }
}
