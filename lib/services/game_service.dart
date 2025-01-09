import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameService {
  static Set<int> calledNumbers = {};

  static int generateRandomNumber() {
    if (calledNumbers.length == 75) {
      // All numbers have been called
      return -1;
    }

    int number;
    do {
      number = Random().nextInt(75) + 1;
    } while (calledNumbers.contains(number));

    calledNumbers.add(number);
    return number;
  }

  static void updateAdminBoard(
      int number, Function(int, Color) updateCallback) {
    Color boldWhite = Colors.black;
    updateCallback(number, boldWhite);
  }

  static void resetAdminBoard(Function resetCallback) {
    resetCallback();
  }

  static void resetCalledNumbers() {
    calledNumbers.clear();
  }

  static void showResetConfirmation(
      BuildContext context, Function resetCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return KeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKeyEvent: (KeyEvent event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.enter) {
              Navigator.of(context).pop();
              resetCallback();
            }
          },
          child: AlertDialog(
            title: const Text('Reset Game'),
            content: const Text('Are you sure you want to reset the game?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Reset'),
                onPressed: () {
                  Navigator.of(context).pop();
                  resetCallback();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
