import 'package:cryptography_project/Widgets/textform_custom.dart';
import 'package:flutter/material.dart';

import '../Widgets/button_custom.dart';

class JawadPart extends StatelessWidget {
  JawadPart({super.key});
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: [
        Page1(),
        Page2(),
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 30,
        children: [
          SizedBox(),
          Text("Playfair \n(Plain Text to Cypher Text)", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),),
          TextFormFieldCustomized(
            hintText: 'Give PlainText',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          ButtonCustom(onPressed: () {  },),
          Text(
            "Cypher:",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Show Cypher Show Cypher Show Cypher Show Cypher Show Cypher",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple
            ),
          ),
        ],
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  Page2({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 30,
        children: [
          SizedBox(),
          Text("Playfair Cipher \n(Cypher Text to Plain Text)", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),),
          TextFormFieldCustomized(
            hintText: 'Give CypherText',
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
          ButtonCustom(onPressed: () { },),
          Text(
            "Plain Text:",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Show Cypher Show Cypher Show Cypher Show Cypher Show Cypher",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple
            ),
          ),
        ],
      ),
    );
  }
}

