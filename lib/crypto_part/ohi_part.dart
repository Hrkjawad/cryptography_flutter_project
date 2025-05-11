import 'package:cryptography_project/Widgets/textform_custom.dart';
import 'package:flutter/material.dart';

import '../Widgets/button_custom.dart';
import '../Widgets/responsive.dart';

class OhiPart extends StatelessWidget {
  OhiPart({super.key});
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
  final TextEditingController _keyController = TextEditingController();
  String showCypherText = "Give input first...";

  int _charToInt(String c) => c.codeUnitAt(0) - 65;
  String _intToChar(int i) => String.fromCharCode(i + 65);

  String vigenereEncrypt(String plainText, String keyText) {
    plainText = plainText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    keyText = keyText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

    List<String> cipherList = [];
    int keyIndex = 0;

    for (int i = 0; i < plainText.length; i++) {
      int m = _charToInt(plainText[i]);
      int k = _charToInt(keyText[keyIndex % keyText.length]);

      int c = (m + k) % 26;
      cipherList.add(_intToChar(c));

      keyIndex++;
    }

    return cipherList.join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: Column(
        spacing: Responsive.sizeW(context, 30),
        children: [
           SizedBox(height: Responsive.sizeW(context, 20)),
           Text(
            "Vigenere Cipher \n(Plain Text to Cipher Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 22), fontWeight: FontWeight.bold),
          ),
          TextFormFieldCustomized(
            hintText: 'Enter PlainText (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          TextFormFieldCustomized(
            hintText: 'Enter Key (A–Z only)',
            keyboardType: TextInputType.text,
            controller: _keyController,
          ),
          ButtonCustom(
            onPressed: () {
              String input = _controller.text.trim();
              String key = _keyController.text.trim();
              if (input.isEmpty || key.isEmpty) {
                setState(() {
                  showCypherText = "Please enter both PlainText and Key!";
                });
              } else {
                setState(() {
                  showCypherText = vigenereEncrypt(input, key);
                });
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
  final TextEditingController _cipherController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String showPlainText = "Give input first...";

  int _charToInt(String c) => c.codeUnitAt(0) - 65;
  String _intToChar(int i) => String.fromCharCode(i + 65);

  String vigenereDecrypt(String cipherText, String keyText) {
    cipherText = cipherText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    keyText = keyText.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

    List<String> plainList = [];
    int keyIndex = 0;

    for (int i = 0; i < cipherText.length; i++) {
      int c = _charToInt(cipherText[i]);
      int k = _charToInt(keyText[keyIndex % keyText.length]);

      int m = (c - k + 26) % 26; // Ensure positive result
      plainList.add(_intToChar(m));

      keyIndex++;
    }

    return plainList.join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: Column(
        spacing: Responsive.sizeW(context, 30),
        children: [
           SizedBox(height: Responsive.sizeW(context, 20)),
           Text(
            "Vigenere Cipher \n(Cipher Text to Plain Text)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Responsive.sizeW(context, 22), fontWeight: FontWeight.bold),
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
                  showPlainText = "Please enter both CipherText and Key!";
                });
              } else {
                setState(() {
                  showPlainText = vigenereDecrypt(cipher, key);
                });
              }
            },
          ),
           Text(
            "Decrypted PlainText:",
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
