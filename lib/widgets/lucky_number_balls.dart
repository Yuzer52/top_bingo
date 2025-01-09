import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LuckyNumberBalls extends StatefulWidget {
  final GlobalKey<LuckyNumberBallsState> _key =
      GlobalKey<LuckyNumberBallsState>();
  final String letter;
  final int minNumber;
  final int maxNumber;
  final Function(int) onNumberEntered;
  final Color ballColor;
  final double luckyNumbersHeaderFontSize;
  final double luckyNumbersTextFieldWidth;
  final double luckyNumbersTextFieldHeight;
  final double luckyNumbersTextFieldFontsize;
  final double luckyNumbersBallWidth;
  final double luckyNumbersBallHeight;
  final bool showAmounts;

  void setRandomNumber() {
    _key.currentState?.setRandomNumber();
  }

  LuckyNumberBalls({
    super.key,
    required this.letter,
    required this.minNumber,
    required this.maxNumber,
    required this.onNumberEntered,
    required this.ballColor,
    required this.luckyNumbersHeaderFontSize,
    required this.luckyNumbersTextFieldWidth,
    required this.luckyNumbersTextFieldHeight,
    required this.luckyNumbersTextFieldFontsize,
    required this.luckyNumbersBallWidth,
    required this.luckyNumbersBallHeight,
    required String initialNumber,
     required this.showAmounts,
  });
  @override
  State<LuckyNumberBalls> createState() => LuckyNumberBallsState();
}

class LuckyNumberBallsState extends State<LuckyNumberBalls> {
  final Random _random = Random();
  String? currentNumber; 
  late TextEditingController _controller;
   TextEditingController get controller => _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    setRandomNumber();
  }

  void setRandomNumber() {
    int randomNum = widget.minNumber +
        _random.nextInt(widget.maxNumber - widget.minNumber + 1);
    _controller.text = widget.showAmounts ? randomNum.toString() : " ";
    widget.onNumberEntered(randomNum.toInt());
  }

  void refreshRandomNumber() {
    setRandomNumber();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
void clearNumber() {
  setState(() {
    _controller.text = "";
  });
}
String? getCurrentNumber() {
    return currentNumber;
  }

  void setNumber(String number) {
    setState(() {
      currentNumber = number;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.luckyNumbersBallWidth,
      height: widget.luckyNumbersBallHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            widget.ballColor.lighter(),
            widget.ballColor,
            widget.ballColor.darker(),
          ],
          stops: const [0.2, 0.5, 1.0],
          center: const Alignment(-0.2, -0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Glossy effect
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          // Colored ring
          Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: widget.ballColor.darker(), width: 3),
              ),
            ),
          ),
          // White ring
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
          // White center background
          Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.letter,
                  style: TextStyle(
                    fontSize: widget.luckyNumbersHeaderFontSize,
                    fontWeight: FontWeight.bold,
                    color: widget.ballColor,
                  ),
                ),
                SizedBox(
                  width: widget.luckyNumbersTextFieldWidth,
                  height: widget.luckyNumbersTextFieldHeight,
                  child: TextField(
                    enabled: false,
                    controller: _controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NumberRangeInputFormatter(
                          widget.minNumber, widget.maxNumber),
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.onNumberEntered(int.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: widget.luckyNumbersTextFieldFontsize,
                      fontWeight: FontWeight.bold,
                      color: widget.ballColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NumberRangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumberRangeInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}

extension ColorExtension on Color {
  Color darker([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 3.0));
    return hslDark.toColor();
  }

  // Add this extension to your existing ColorExtension
  Color lighter([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  // Add this method to generate a new random number on demand
}
