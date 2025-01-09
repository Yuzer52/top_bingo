import 'package:flutter/material.dart';

class CustomCall extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final Color color;
  final double size;
  final double sizeFont;
  final bool isCalled; // New property to track if called

  const CustomCall({
    super.key,
    required this.text,
    required this.margin,
    required this.color,
    required this.size,
    required this.sizeFont,
    this.isCalled = false, // Default is not called
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: margin,
  //     width: size,
  //     height: size,
  //     decoration: BoxDecoration(
  //       color: const Color.fromRGBO(24, 152, 213, 1),
  //       shape: BoxShape.circle,
  //       border:
  //           Border.all(color: const Color.fromARGB(255, 13, 94, 160), width: 2),
  //     ),
  //     alignment: Alignment.center,
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: sizeFont,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: margin,
  //     width: size,
  //     height: size,
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 255, 203, 34),
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Colors.black, width: 2),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.3),
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           width: size * 0.8,
  //           height: size * 0.8,
  //           decoration: BoxDecoration(
  //             color: color,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontFamily: 'Algerian',
  //             color: Colors.black,
  //             fontSize: sizeFont,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: margin,
  //     width: size,
  //     height: size,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       gradient: const RadialGradient(
  //         colors: [
  //           Color.fromARGB(255, 255, 223, 84),
  //           Color.fromARGB(255, 255, 203, 34),
  //           Color.fromARGB(255, 225, 173, 4),
  //         ],
  //         stops: [0.2, 0.6, 1.0],
  //       ),
  //       border: Border.all(color: Colors.black, width: 2),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(1),
  //           blurRadius: 5,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           width: size * 0.75,
  //           height: size * 0.75,
  //           decoration: BoxDecoration(
  //             color: Colors.black.withOpacity(1),
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         Container(
  //           width: size * 0.7,
  //           height: size * 0.7,
  //           decoration: BoxDecoration(
  //             color: color,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontFamily: 'Algerian',
  //             color: Colors.black,
  //             fontSize: sizeFont,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Positioned(
  //           top: size * 0.1,
  //           left: size * 0.1,
  //           child: Container(
  //             width: size * 0.3,
  //             height: size * 0.15,
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.3),
  //               shape: BoxShape.circle,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //THIRD VERSION
   @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color.fromARGB(255, 255, 245, 184),
            Color.fromARGB(255, 255, 223, 84),
            Color.fromARGB(255, 255, 203, 34),
            Color.fromARGB(255, 225, 173, 4),
          ],
          stops: [0.0, 0.3, 0.6, 1.0],
        ),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: isCalled
                ? Colors.yellow.withOpacity(0.8) // Yellow shadow when called
                : Colors.black.withOpacity(0.5), // Default black shadow
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner shadow for glossy effect
          Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(1),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
          // Main color
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          // Text with white background for better contrast
          Stack(
            alignment: Alignment.center,
            children: [
              // White background
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Algerian',
                  color: Colors.white,
                  fontSize: sizeFont + 2, // Slightly larger for the background
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Black text
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Algerian',
                  color: Colors.black,
                  fontSize: sizeFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Glossy highlight
          Positioned(
            top: size * 0.1,
            left: size * 0.1,
            child: Container(
              width: size * 0.4,
              height: size * 0.2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Additional glossy highlight
          Positioned(
            bottom: size * 0.15,
            right: size * 0.15,
            child: Container(
              width: size * 0.25,
              height: size * 0.12,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
