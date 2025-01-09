import 'package:bingocaller/widgets/custom_call.dart';
import 'package:flutter/material.dart';

class CustomCalls extends StatelessWidget {
  final String text;
  final Set<int> calledNumbers;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  const CustomCalls({
    super.key,
    required this.calledNumbers,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      height: 120,
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromRGBO(24, 152, 213, 1), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: calledNumbers
              .toList()
              .reversed
              .take(5) //the last 5 numbers
              .map((number) {
            Color clr;
            if (number <= 15) {
              clr = Colors.blue; // B column
            } else if (number <= 30) {
              clr = Colors.red; // I column
            } else if (number <= 45) {
              clr = Colors.orange; // N column
            } else if (number <= 60) {
              clr = Colors.green; // G column
            } else {
              clr = Colors.yellow; // O column
            }

            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CustomCall(
                sizeFont: 28,
                size: 60, // Increased size for previously called numbers
                margin: const EdgeInsets.all(10),
                text: number.toString(),
                color: clr,

                
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
