// ignore_for_file: file_names

import 'package:bingocaller/widgets/custom_numbers.dart';
import 'package:flutter/material.dart';

class CustomAdminBoard extends StatefulWidget {
  final double kumet;
  final double headerFontSize;
  final double numberFontSize;
  final double luckyFontSize;
  final double luckyLableFontSize;
  const CustomAdminBoard({
    super.key,
    required this.kumet,
    required this.headerFontSize,
    required this.numberFontSize,
    required this.luckyFontSize,
    required this.luckyLableFontSize,
  });

  @override
  State<CustomAdminBoard> createState() => CustomAdminBoardState();
}

class CustomAdminBoardState extends State<CustomAdminBoard> {
  final List<String> headers = ['B', 'I', 'N', 'G', 'O'];
  late List<List<int>> boardNumbers;
  late List<List<Color>> boardColors;
  late List<List<Color>> boardBackgroundColors;
    Set<int> boldNumbers = {};

    double opacity = 1.0; // 

  bool isGameInProgress = true;

  @override
  void initState() {
    super.initState();
    boardNumbers = generateBoardNumbers();
    boardColors = List.generate(
        5, (_) => List.filled(15, const Color.fromRGBO(202, 202, 202, 1)));
    boardBackgroundColors =
        List.generate(5, (_) => List.filled(15, Colors.white));
  }
 
  void updateNumber(int number, Color color) {
    setState(() {
      isGameInProgress = false;
      for (int i = 0; i < 5; i++) {
        int index = boardNumbers[i].indexOf(number);
        if (index != -1) {
          boardColors[i][index] = color;
          boardBackgroundColors[i][index] =
              _getBackgroundColorForNumber(number);
          break;
        }
      }
    });
  }

  Color _getBackgroundColorForNumber(int number) {
    if (number <= 15) return Colors.red[100]!;
    if (number <= 30) return Colors.blue[100]!;
    if (number <= 45) return Colors.green[100]!;
    if (number <= 60) return Colors.orange[100]!;
    return Colors.purple[100]!;
  }

  List<List<int>> generateBoardNumbers() {
    return List.generate(5, (col) {
      int start = col * 15 + 1;
      return List.generate(15, (row) => start + row);
    });
  }

  void resetBoard() {
    setState(
      () {
        boardColors = List.generate(
          5,
          (_) => List.filled(15, const Color.fromRGBO(202, 202, 202, 1)),
        );
        boardBackgroundColors = List.generate(
          5,
          (_) => List.filled(15, const Color.fromARGB(255, 255, 255, 255)),
        );
        isGameInProgress = true;
      },
    );
  }
 void toggleNumberBold(int number, bool bold) {
    setState(() {
      if (bold) {
        boldNumbers.add(number);
      } else {
        boldNumbers.remove(number);
      }
    });
  }

  void clearBoldNumbers() {
    setState(() {
      boldNumbers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
   return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 100),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          color: const Color.fromARGB(200, 243, 243, 243)
        ),
      child: Column(
        children: [
          Table(
            children: List.generate(
              5,
              (col) {
                return TableRow(
                  children: [
                    Container(
                      height: widget.kumet,
                      color: const Color.fromRGBO(24, 152, 213, 1),
                      child: Center(
                        child: Text(
                          headers[col],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.headerFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      15,
                      (row) {
                        return _buildCell(
                            boardNumbers[col][row].toString(), col, row);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
   );
  }
 Widget _buildCell(String number, int col, int row) {
    return SizedBox(
      child: Row(
        children: [
          CustomTextButton(
            text: number,
            color: boldNumbers.contains(int.parse(number)) 
                ? const Color.fromARGB(255, 0, 0, 0) 
                : boardColors[col][row],
            backgroundColor: boardBackgroundColors[col][row],
            onPressed: () {},
            fontsize: widget.numberFontSize,
            fontWeight: boldNumbers.contains(int.parse(number)) 
                ? FontWeight.w900 
                : FontWeight.normal,
          ),
        ],
      ),
    );
  }
}