import 'package:cryptography_project/ui_part/Widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutputShowBox extends StatelessWidget {
  const OutputShowBox({super.key, required this.result, required this.text});
  final String result, text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.sizeW(context, 330),
      child: TextFormField(
        initialValue: result,
        key: ValueKey(result),
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
        readOnly: true,
        maxLines: null,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Color(0xffdcdfe4)),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: result)).then((_) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Copied')));
              });
            },
            icon: Icon(Icons.copy_all, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
