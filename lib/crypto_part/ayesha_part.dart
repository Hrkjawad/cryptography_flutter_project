import 'package:cryptography_project/Widgets/textform_custom.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../Widgets/button_custom.dart';
import '../Widgets/responsive.dart';

class AyeshaPart extends StatelessWidget {

  AyeshaPart({super.key});
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
  String showCypherText = "Give input first...";
  String showKey = "";

  ///Convert A-Z to 0–25
  int _charToInt(String c) => c.codeUnitAt(0) - 65;

  ///Convert 0–25 to A-Z
  String _intToChar(int i) => String.fromCharCode(i + 65);

  Map<String, String> vernamEncrypt(String plainText) {
    plainText = plainText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    Random rand = Random();

    List<String> keyList = [];
    List<String> cipherList = [];

    for (int i = 0; i < plainText.length; i++) {
      int m = _charToInt(plainText[i]);
      int k = rand.nextInt(26); // random key generate
      int c = (m + k) % 26;

      keyList.add(_intToChar(k));
      cipherList.add(_intToChar(c));
    }

    return {'key': keyList.join(), 'cipher': cipherList.join()};
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: Responsive.sizeH(context, 20),
        children: [
          SizedBox(height: Responsive.sizeH(context, 20)),
          Text(
            "Vernam Cipher \n(Plain Text to Cipher Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          TextFormFieldCustomized(
            hintText: 'Enter PlainText (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          ButtonCustom(
            onPressed: () {
              String input = _controller.text.trim();
              if (input.isEmpty) {
                setState(() {
                  showCypherText = "Please enter some text!";
                  showKey = "";
                });
              } else {
                final result = vernamEncrypt(input);
                setState(() {
                  showCypherText = result['cipher']!;
                  showKey = result['key']!;
                });
              }
            },
          ),
          Text(
            "Cipher Text:",
            style: TextStyle(fontSize: Responsive.sizeW(context, 22), fontWeight: FontWeight.bold),
          ),
          Text(
            showCypherText,
            style:  TextStyle(fontSize: Responsive.sizeW(context, 18), color: Colors.deepPurple),
          ),
          Text(
            "Random Same Length Key Used:",
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          Text(
            showKey,
            style:  TextStyle(fontSize: Responsive.sizeW(context, 18), color: Colors.teal),
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
  final TextEditingController _cipherController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  String showPlainText = "Give input first...";

  int _charToInt(String c) => c.codeUnitAt(0) - 65;
  String _intToChar(int i) => String.fromCharCode(i + 65);

  String vernamDecrypt(String cipherText, String keyText) {
    cipherText = cipherText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    keyText = keyText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

    if (cipherText.length != keyText.length) {
      return "Cipher and Key must be the same length!";
    }

    List<String> plainList = [];

    for (int i = 0; i < cipherText.length; i++) {
      int c = _charToInt(cipherText[i]);
      int k = _charToInt(keyText[i]);

      int m = (c - k);
      if (m < 0) m += 26; // handle negative values

      plainList.add(_intToChar(m));
    }

    return plainList.join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: Responsive.sizeH(context, 20),
        children: [
           SizedBox(height: Responsive.sizeH(context, 20)),
           Text(
            "Vernam Cipher \n(Cipher Text to Plain Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          TextFormFieldCustomized(
            hintText: 'Enter CipherText (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _cipherController,
          ),
          TextFormFieldCustomized(
            hintText: 'Enter Key (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _keyController,
          ),
          ButtonCustom(
            onPressed: () {
              String cipher = _cipherController.text.trim();
              String key = _keyController.text.trim();
              if (cipher.isEmpty || key.isEmpty) {
                setState(() {
                  showPlainText = "Please enter both Cipher and Key!";
                });
              } else {
                setState(() {
                  showPlainText = vernamDecrypt(cipher, key);
                });
              }
            },
          ),
           Text(
            "PlainText:",
            style: TextStyle(fontSize: Responsive.sizeW(context, 20), fontWeight: FontWeight.bold),
          ),
          Text(
            showPlainText,
            style:  TextStyle(fontSize: Responsive.sizeW(context, 20), color: Colors.deepPurple),
          ),
          Expanded(child: Icon(Icons.arrow_circle_up, size: Responsive.sizeW(context, 50), color: Colors.deepPurpleAccent,))

        ],
      ),
    );
  }
}
