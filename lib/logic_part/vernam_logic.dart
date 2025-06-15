import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//-------Vernam Encrypt Start--------


int _charToInt(String c) => c.codeUnitAt(0) - 65; ///Convert A-Z to 0–25

String _intToChar(int i) => String.fromCharCode(i + 65); ///Convert 0–25 to A-Z

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

class VernamResult {
  final String cipherText;
  final String key;
  VernamResult({required this.cipherText, required this.key});
}

final vernamProvider = StateNotifierProvider<VernamLogic, VernamResult>((ref) {
  return VernamLogic();
});

class VernamLogic extends StateNotifier<VernamResult> {
  VernamLogic()
    : super(VernamResult(cipherText: "Give input first...", key: ""));

  void encrypt(String input) {
    if (input.isEmpty) {
      state = VernamResult(cipherText: "Please enter some text!", key: "");
      return;
    }
    final result = vernamEncrypt(input);
    state = VernamResult(cipherText: result['cipher']!, key: result['key']!);
  }
}

//-------Vernam Encrypt End--------

//-------Vernam Decrypt Start--------

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

class VernamDecResult {
  final String plainText;
  VernamDecResult({required this.plainText});
}

final vernamDecProvider =
    StateNotifierProvider<VernamDecLogic, VernamDecResult>((ref) {
      return VernamDecLogic();
    });

class VernamDecLogic extends StateNotifier<VernamDecResult> {
  VernamDecLogic() : super(VernamDecResult(plainText: "Give input first..."));

  void decrypt(String input, String key) {
    if (input.isEmpty || key.isEmpty) {
      state = VernamDecResult(plainText: "Please enter both Cipher and Key!");
      return;
    }
    final result = vernamDecrypt(input, key);
    state = VernamDecResult(plainText: result);
  }
}

//-------Vernam Decrypt End--------
