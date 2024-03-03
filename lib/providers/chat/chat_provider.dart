import 'package:flutter_riverpod/flutter_riverpod.dart';

//created to control the display of the send button on the chat screen

class SendTextNotifier extends StateNotifier<bool> {
  SendTextNotifier() : super(false);

  void sendTextTrue() {
    state = true;
  }

  void sendTextFalse() {
    state = false;
  }
}

final sendTextProvider = StateNotifierProvider<SendTextNotifier, bool>((ref) {
  return SendTextNotifier();
});
