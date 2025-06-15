import 'package:flutter/material.dart';

class TextFormFieldCustomized extends StatelessWidget {
  const TextFormFieldCustomized(
      {super.key,
        required this.hintText,
        required this.keyboardType,
        required this.controller,
        this.validator});
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: StatefulBuilder(builder: (context, setState) {
          return TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: null,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 18,
                color: const Color(0xff959eae),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                borderSide: BorderSide(
                  color: Color(0xffdcdfe4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                borderSide: BorderSide(
                  color: Color(0xffdcdfe4),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              errorStyle: TextStyle(fontSize: 14),
              filled: true,
              fillColor: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}