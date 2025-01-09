import 'package:flutter/material.dart';

class PatternBoard extends StatefulWidget {
  final BingoPattern initialPattern;

  final double boardHeight;
  final double boardWidth;
  final double headerFontSize;

  const PatternBoard({
    super.key,
    this.initialPattern = BingoPattern.noPattern,
    required this.boardHeight,
    required this.boardWidth,
    required this.headerFontSize,
  });

  @override
  PatternBoardState createState() => PatternBoardState();
}

enum BingoPattern {
  noPattern,
  fourCorners,
  letterX,
  blackout,
  letterT,
  diamond,
  postageStamp,
  smallFrame,
  largeFrame,
  crazyL,
  centerSquare
}

class PatternBoardState extends State<PatternBoard> {
  List<bool> clickedTiles = List.generate(25, (_) => false);
  final List<String> headerLetters = ['B', 'I', 'N', 'G', 'O'];

  void _handleTileTap(int index) {
    setState(() {
      clickedTiles[index] = !clickedTiles[index];
    });
  }

  @override
  void initState() {
    super.initState();
    applyPattern(widget.initialPattern);
  }

  void applyPattern(BingoPattern pattern) {
    setState(() {
      clickedTiles = List.generate(25, (_) => false);
      switch (pattern) {
        case BingoPattern.fourCorners:
          for (var index in [0, 4, 20, 24]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.letterX:
          for (var index in [0, 4, 6, 8, 12, 16, 18, 20, 24]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.blackout:
          clickedTiles = List.generate(25, (_) => true);
          break;
        case BingoPattern.letterT:
          for (var index in [0, 1, 2, 3, 4, 12]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.diamond:
          for (var index in [2, 6, 8, 12, 16, 18, 22]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.postageStamp:
          for (var index in [0, 1, 5, 6]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.smallFrame:
          for (var index in [1, 2, 3, 5, 9, 10, 14, 15, 19, 21, 22, 23]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.largeFrame:
          for (var index in [
            0,
            1,
            2,
            3,
            4,
            5,
            9,
            10,
            14,
            15,
            19,
            20,
            21,
            22,
            23,
            24
          ]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.crazyL:
          for (var index in [0, 5, 10, 15, 20, 21, 22, 23, 24]) {
            clickedTiles[index] = true;
          }
          break;
        case BingoPattern.centerSquare:
          clickedTiles[12] = true;
          break;
        default: // No pattern
      }
    });
  }

  Widget createBoard() {
    return SizedBox(
      width: widget.boardWidth,
      height: widget.boardHeight,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: headerLetters
                .map((letter) => Container(
                      width: 10,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: widget.headerFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: 25,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTileTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: clickedTiles[index]
                          ? Theme.of(context).hintColor
                          : Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: index == 12
                        ? const Center(
                            child: Text(
                              'FREE',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createBoard();
  }
}
