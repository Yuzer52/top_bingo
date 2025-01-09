import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double buttonWidth;
  final double buttonHeight;
  final double buttonFontSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.isEnabled,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? backgroundColor : Colors.black26,
        foregroundColor: isEnabled ? foregroundColor : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle:
            TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.bold),
      ),
      onPressed: isEnabled ? onPressed : null,
      child: Text(text),
    );
  }
}
