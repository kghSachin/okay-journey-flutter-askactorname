import 'package:flutter/material.dart';

class TextFieldWid extends StatelessWidget {
  final TextEditingController controller;
  const TextFieldWid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter your Favourite actor name',
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.greenAccent),
        // ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
      ),
    );
  }
}
