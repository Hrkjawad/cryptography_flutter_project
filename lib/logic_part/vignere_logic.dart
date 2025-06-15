//---------- Encrypt logic start---------//

import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class VigenereEncryptResult {
  final String cipherText;
  VigenereEncryptResult({required this.cipherText});
}

class VigenereEncryptLogic extends StateNotifier<VigenereEncryptResult> {
  VigenereEncryptLogic()
    : super(VigenereEncryptResult(cipherText: "Give input first..."));

  void vigenereEncryption(String input, String key) {
    if (input.isEmpty || key.isEmpty) {
      state = VigenereEncryptResult(
        cipherText: "Please fill PlainText and Key!",
      );
      return;
    }

    final result = vigenereEncrypt(input, key);
    state = VigenereEncryptResult(cipherText: result);
  }
}

final vigenereEncryptProvider =
    StateNotifierProvider<VigenereEncryptLogic, VigenereEncryptResult>((ref) {
      return VigenereEncryptLogic();
    });

//---------- Encrypt logic end---------//

//---------- Decrypt logic start---------//

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

class VigenereDecResult {
  final String plaintext;
  VigenereDecResult({required this.plaintext});
}

class VigenereDecLogic extends StateNotifier<VigenereDecResult> {
  VigenereDecLogic()
    : super(VigenereDecResult(plaintext: "Give input first..."));

  void vigenereDec(String input, String key) {
    if (input.isEmpty || key.isEmpty) {
      state = VigenereDecResult(plaintext: "Please fill CipherText and Key!");
      return;
    }
    final result = vigenereDecrypt(input, key);
    state = VigenereDecResult(plaintext: result);
  }
}

final vigenereDecProvider =
    StateNotifierProvider<VigenereDecLogic, VigenereDecResult>((ref) {
      return VigenereDecLogic();
    });

//---------- Decrypt logic end---------//
