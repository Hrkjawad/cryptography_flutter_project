import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonCustom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Color(0xffffa62b)),
        child: Text(
          "Check",
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}