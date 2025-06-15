import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic_part/rail_fence_logic.dart';
import 'Widgets/button_custom.dart';
import 'Widgets/output_show_box.dart';
import 'Widgets/responsive.dart';
import 'Widgets/textform_custom.dart';


final pageController = PageController();

class RailFence extends StatelessWidget {
  const RailFence({super.key});
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
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: SingleChildScrollView(
        child: Column(
          spacing: Responsive.sizeH(context, 40),
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
              hintText: 'Enter depth',
              keyboardType: TextInputType.number,
              controller: _numberController,
            ),
            ButtonCustom(
              onPressed: () {
                String input = _controller.text.trim();
                depth = int.tryParse(_numberController.text) ?? 2;
                ref.read(railFenceProvider.notifier).encrypt(input);
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final result = ref.watch(railFenceProvider);
                return OutputShowBox(
                  result: result.cypherText,
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
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.sizeW(context, 20)),
      child: SingleChildScrollView(
        child: Column(
          spacing: Responsive.sizeH(context, 40),
          children: [
            SizedBox(height: Responsive.sizeW(context, 5)),
            Text(
              "------Cipher Text to Plain Text-------",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.sizeW(context, 16),
                fontWeight: FontWeight.bold,
              ),
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
                ref.read(railFenceDecProvider.notifier).decrypt(input);
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final result = ref.watch(railFenceDecProvider);
                return OutputShowBox(result: result.plaintext, text: 'Plain Text');
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
