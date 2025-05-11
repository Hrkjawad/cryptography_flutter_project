import 'package:cryptography_project/Widgets/textform_custom.dart';
import 'package:flutter/material.dart';

import '../Widgets/button_custom.dart';
import '../Widgets/responsive.dart';

class JawadPart extends StatelessWidget {
  JawadPart({super.key});
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: [Page1(), Page2()],
    );
  }
}

class Page1 extends StatefulWidget {
   const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  String showCypherText = "Give input first...";
  int? depth;

  String encryptRailFence(String text) {
    if (depth! <= 1 || text.isEmpty) return text;

    text = text.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    List<StringBuffer> rail = List.generate(depth!, (_) => StringBuffer());

    int row = 0;
    bool down = true;

    for (var ch in text.split('')) {
      rail[row].write(ch);
      if (row == 0) {
        down = true;
      } else if (row == depth! - 1) {
        down = false;
      }
      row += down ? 1 : -1;
    }

    return rail.map((e) => e.toString()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: Column(
        spacing: Responsive.sizeH(context, 30),
        children: [
           SizedBox(height: Responsive.sizeW(context, 20)),
           Text(
            "Rail Fence Cipher\n(Plain Text to Cipher Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 22), fontWeight: FontWeight.bold),
          ),
          TextFormFieldCustomized(
            hintText: 'Enter PlainText (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          TextFormFieldCustomized(
            hintText: 'Enter depth',
            keyboardType: TextInputType.number,
            controller: _numberController,
          ),
          ButtonCustom(
            onPressed: () {
              String input = _controller.text.trim();
              depth = int.tryParse(_numberController.text) ?? 3;
              if (input.isEmpty) {
                setState(() => showCypherText = "Please enter text!");
              } else {
                setState(() => showCypherText = encryptRailFence(input));
              }
            },
          ),
           Text(
            "Cipher Text:",
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          Text(
            showCypherText,
            style:  TextStyle(fontSize: Responsive.sizeW(context, 18), color: Colors.deepPurple),
          ),
          Expanded(child: Icon(Icons.arrow_drop_down_circle_rounded, size: Responsive.sizeW(context, 50), color: Colors.deepPurpleAccent,))
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
   const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String showPlainText = "Give input first...";
  int? depth;

  String decryptRailFence(String cipher) {
    if (depth! <= 1 || cipher.isEmpty) return cipher;

    cipher = cipher.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    List<List<bool>> mark = List.generate(
      depth!,
      (_) => List.filled(cipher.length, false),
    );
    List<String> rail = List.generate(depth!, (_) => '');

    // Marking zigzag pattern
    int row = 0;
    bool down = true;
    for (int i = 0; i < cipher.length; i++) {
      mark[row][i] = true;
      if (row == 0) {
        down = true;
      } else if (row == depth! - 1) {
        down = false;
      }
      row += down ? 1 : -1;
    }

    // Fill the rail matrix
    int index = 0;
    for (int i = 0; i < depth!; i++) {
      for (int j = 0; j < cipher.length; j++) {
        if (mark[i][j] && index < cipher.length) {
          rail[i] += cipher[index++];
        }
      }
    }

    // Reruct the plaintext
    StringBuffer result = StringBuffer();
    row = 0;
    down = true;
    List<int> railPos = List.filled(depth!, 0);

    for (int i = 0; i < cipher.length; i++) {
      result.write(rail[row][railPos[row]]);
      railPos[row]++;
      if (row == 0) {
        down = true;
      } else if (row == depth! - 1) {
        down = false;
      }
      row += down ? 1 : -1;
    }

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: Column(
        spacing: Responsive.sizeH(context, 30),
        children: [
           SizedBox(height: Responsive.sizeW(context, 20)),
           Text(
            "Rail Fence Cipher\n(Cipher Text to Plain Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 22), fontWeight: FontWeight.bold),
          ),
          TextFormFieldCustomized(
            hintText: 'Enter CipherText (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          TextFormFieldCustomized(
            hintText: 'Enter depth',
            keyboardType: TextInputType.number,
            controller: _numberController,
          ),
          ButtonCustom(
            onPressed: () {
              String input = _controller.text.trim();
              depth = int.tryParse(_numberController.text);
              if (input.isEmpty) {
                setState(() => showPlainText = "Please enter text!");
              } else {
                setState(() => showPlainText = decryptRailFence(input));
              }
            },
          ),
           Text(
            "PlainText:",
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          Text(
            showPlainText,
            style:  TextStyle(fontSize: Responsive.sizeW(context, 18), color: Colors.deepPurple),
          ),
          Expanded(child: Icon(Icons.arrow_circle_up, size: Responsive.sizeW(context, 50), color: Colors.deepPurpleAccent,))
        ],
      ),
    );
  }
}
