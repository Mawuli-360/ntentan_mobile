import 'package:flutter/material.dart';

class LoginFieldLabel extends StatelessWidget {
  final String label;

  const LoginFieldLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}
