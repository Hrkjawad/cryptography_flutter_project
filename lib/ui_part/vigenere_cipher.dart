import 'package:cryptography_project/logic_part/vignere_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Widgets/button_custom.dart';
import 'Widgets/output_show_box.dart';
import 'Widgets/responsive.dart';
import 'Widgets/textform_custom.dart';

final pageController = PageController();
class VigenereCipher extends StatelessWidget {
  const VigenereCipher({super.key});
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.vertical,
      children: [Page1(), Page2()],
    );
  }
}

class Page1 extends ConsumerStatefulWidget {
  const Page1({super.key});

  @override
  ConsumerState<Page1> createState() => _Page1State();
}

class _Page1State extends ConsumerState<Page1> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _keyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: SingleChildScrollView(
        child: Column(
          spacing: Responsive.sizeW(context, 40),
          children: [
            SizedBox(height: Responsive.sizeW(context, 5)),
            Text(
              "------Plain Text to Cipher Text------",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.sizeW(context, 16),
                fontWeight: FontWeight.bold,
              ),
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
                ref
                    .read(vigenereEncryptProvider.notifier)
                    .vigenereEncryption(input, key);
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final result = ref.watch(vigenereEncryptProvider);
                return OutputShowBox(
                  result: result.cipherText,
                  text: 'Cipher Text',
                );
              },
            ),
            IconButton(
              onPressed: () {
                pageController.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.easeIn);
              },
              icon: Icon(
                Icons.arrow_drop_down_circle_rounded,
                size: Responsive.sizeW(context, 50),
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends ConsumerStatefulWidget {
  const Page2({super.key});

  @override
  ConsumerState<Page2> createState() => _Page2State();
}

class _Page2State extends ConsumerState<Page2> {
  final TextEditingController _cipherController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _cipherController.dispose();
    _keyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: SingleChildScrollView(
        child: Column(
          spacing: Responsive.sizeW(context, 40),
          children: [
            SizedBox(height: Responsive.sizeW(context, 5)),
            Text(
              "------Cipher Text to Plain Text------",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.sizeW(context, 16),
                fontWeight: FontWeight.bold,
              ),
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
                ref.read(vigenereDecProvider.notifier).vigenereDec(cipher, key);
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final result = ref.watch(vigenereDecProvider);
                return OutputShowBox(
                  result: result.plaintext,
                  text: 'Plain Text',
                );
              },
            ),
            IconButton(
              onPressed: () {
                pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.easeIn);
              },
              icon: Icon(
                Icons.arrow_circle_up,
                size: Responsive.sizeW(context, 50),
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
