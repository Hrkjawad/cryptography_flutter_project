//---------Encrypt Logic Start---------//
import 'package:flutter_riverpod/flutter_riverpod.dart';

int? depth = 2;

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

class RailFenceResult {
  String cypherText;
  RailFenceResult({required this.cypherText});
}

final railFenceProvider =
    StateNotifierProvider<RailFenceLogic, RailFenceResult>((ref) {
      return RailFenceLogic();
    });

class RailFenceLogic extends StateNotifier<RailFenceResult> {
  RailFenceLogic() : super(RailFenceResult(cypherText: "Give input first..."));

  void encrypt(String input) {
    if (input.isEmpty) {
      state = RailFenceResult(cypherText: "Please enter text!");
      return;
    }
    final result = encryptRailFence(input);
    state = RailFenceResult(cypherText: result);
  }
}
//---------Encrypt Logic End---------//

//---------Decrypt Logic Start---------//

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

class RailFenceDecResult {
  String plaintext;
  RailFenceDecResult({required this.plaintext});
}

class RailFenceDecLogic extends StateNotifier<RailFenceDecResult> {
  RailFenceDecLogic()
    : super(RailFenceDecResult(plaintext: "Give input first..."));

  void decrypt(String input) {
    if (input.isEmpty) {
      state = RailFenceDecResult(plaintext: "Please enter text!");
      return;
    }
    final result = decryptRailFence(input);
    state = RailFenceDecResult(plaintext: result);
  }
}

final railFenceDecProvider =
    StateNotifierProvider<RailFenceDecLogic, RailFenceDecResult>((ref) {
      return RailFenceDecLogic();
    });

//---------Decrypt Logic End---------//
