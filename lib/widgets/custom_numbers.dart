import 'package:flutter/material.dart';

// class CustomTextButton extends StatelessWidget {
//   final String text;
//   final Color color;
//   final VoidCallback onPressed;
//   final TextStyle textStyle;

//   const CustomTextButton({
//     super.key,
//     required this.text,
//     required this.color,
//     required this.onPressed,
//     required this.textStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         backgroundColor: color,
//         textStyle: const TextStyle(fontSize: 16),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       onPressed: onPressed,
//       child: Text(text, style: textStyle,),
//     );
//   }
// }

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double fontsize;
    final FontWeight fontWeight; 

  const CustomTextButton({
    super.key,
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
    required this.fontsize,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: color,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 38,
          fontFamily: 'algerian',
          
        ),
      ),
    );
  }
}
