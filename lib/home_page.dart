import 'package:cryptography_project/ui_part/rail_fence.dart';
import 'package:cryptography_project/ui_part/vernam_cipher.dart';
import 'package:cryptography_project/ui_part/vigenere_cipher.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffffa62b),
          title: Text("Cryptography", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffede7e3),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Color(0xffffa62b),
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(child: Text("Vernam \nCipher", textAlign: TextAlign.center)),
                    Tab(child: Text("Rail Fence Cipher", textAlign: TextAlign.center)),
                    Tab(child: Text("Vigenere Cipher", textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ),
            Expanded(child: TabBarView(children: [VernamCipher(), RailFence(), VigenereCipher()])),
          ],
        ),
      ),
    );
  }
}
