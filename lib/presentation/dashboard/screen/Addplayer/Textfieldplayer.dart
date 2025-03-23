import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final controller;
  final String hintText;
  const InputField(
      {super.key,
      required this.label,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.only(left: 5.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10.0, top: 15.0),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              fillColor: Colors.grey,
              filled: true,
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
