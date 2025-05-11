import 'package:cryptography_project/crypto_part/ayesha_part.dart';
import 'package:cryptography_project/crypto_part/jawad_part.dart';
import 'package:cryptography_project/crypto_part/ohi_part.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cryptography Project"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("ID: 10 - Ayesha")),
              Tab(child: Text("ID: 11 - Jawad")),
              Tab(child: Text("ID: 33 - Ohi")),
            ],
          ),
        ),
        body: TabBarView(children: [AyeshaPart(), JawadPart(), OhiPart()]),
      ),
    );
  }
}
