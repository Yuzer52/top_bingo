import 'package:bingocaller/widgets/lucky_number_balls.dart';
import 'package:flutter/material.dart';

class LuckyNumbers extends StatefulWidget {
  final double luckyNumbersContainerWidth;
  final double luckyNumbersContainerHeight;
  final double luckyNumbersHeaderFontSize;
  final double luckyNumbersTextFieldWidth;
  final double luckyNumbersTextFieldHeight;
  final double luckyNumbersTextFieldFontsize;
  final double luckyNumbersBallWidth;
  final double luckyNumbersBallHeight;
  final double headerFontSize;
  final double textFieldWidth;
  final double textFieldHeight;
  final double textFieldFontsize;
  final double ballWidth;
  final double ballHeight;
  final double bonusHeaderFontSize;
  final double bonusTextFieldWidth;
  final double bonusTextFieldHeight;
  final double bonusTextFieldFontSize;
  final String bonusNumber;
  final bool showAmounts;

  const LuckyNumbers({
    super.key,
    required this.luckyNumbersContainerWidth,
    required this.luckyNumbersContainerHeight,
    required this.headerFontSize,
    required this.textFieldWidth,
    required this.textFieldHeight,
    required this.textFieldFontsize,
    required this.ballWidth,
    required this.ballHeight,
    required this.luckyNumbersHeaderFontSize,
    required this.luckyNumbersTextFieldWidth,
    required this.luckyNumbersTextFieldHeight,
    required this.luckyNumbersTextFieldFontsize,
    required this.luckyNumbersBallWidth,
    required this.luckyNumbersBallHeight,
    required this.bonusHeaderFontSize,
    required this.bonusTextFieldWidth,
    required this.bonusTextFieldHeight,
    required this.bonusTextFieldFontSize,
    required this.bonusNumber,
    required this.showAmounts, 
  });

  @override
  State<LuckyNumbers> createState() => LuckyNumbersState();
}

class LuckyNumbersState extends State<LuckyNumbers> {
  final GlobalKey<LuckyNumberBallsState> bBallKey =
      GlobalKey<LuckyNumberBallsState>();
  final GlobalKey<LuckyNumberBallsState> iBallKey =
      GlobalKey<LuckyNumberBallsState>();
  final GlobalKey<LuckyNumberBallsState> nBallKey =
      GlobalKey<LuckyNumberBallsState>();
  final GlobalKey<LuckyNumberBallsState> gBallKey =
      GlobalKey<LuckyNumberBallsState>();
  final GlobalKey<LuckyNumberBallsState> oBallKey =
      GlobalKey<LuckyNumberBallsState>();
       Set<int> luckyNumbers = {};

 void refreshLuckyNumbers() {
  luckyNumbers.clear();
    
  bBallKey.currentState?.setRandomNumber();
  luckyNumbers.add(int.parse(bBallKey.currentState!.controller.text));

  iBallKey.currentState?.setRandomNumber();
  luckyNumbers.add(int.parse(iBallKey.currentState!.controller.text));

  nBallKey.currentState?.setRandomNumber();
  luckyNumbers.add(int.parse(nBallKey.currentState!.controller.text));

  gBallKey.currentState?.setRandomNumber();
  luckyNumbers.add(int.parse(gBallKey.currentState!.controller.text));

  oBallKey.currentState?.setRandomNumber();
  luckyNumbers.add(int.parse(oBallKey.currentState!.controller.text));
    
  debugPrint("Stored Lucky Numbers: $luckyNumbers");
} 
  void clearAllNumbers() {
  bBallKey.currentState?.setRandomNumber();
  iBallKey.currentState?.setRandomNumber();
  nBallKey.currentState?.setRandomNumber();
  gBallKey.currentState?.setRandomNumber();
  oBallKey.currentState?.setRandomNumber();
}
Set<int> getCurrentLuckyNumbers() {
    debugPrint("Retrieved Lucky Numbers: $luckyNumbers");
    return luckyNumbers;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            widget.luckyNumbersContainerWidth,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lucky Numbers",
                  style: TextStyle(
                    fontSize: widget.headerFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times-new-roman',
                    color: const Color.fromRGBO(24, 152, 213, 1),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Bonus",
                      style: TextStyle(
                        fontSize: widget.bonusHeaderFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times-new-roman',
                        color: const Color.fromRGBO(24, 152, 213, 1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: widget.bonusTextFieldWidth,
                      height: widget.bonusTextFieldHeight,
                      child: TextField(
                        enabled: false,
                        controller:
                            TextEditingController(text: widget.bonusNumber),
                        style: TextStyle(
                          fontSize: widget.bonusTextFieldFontSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Algerian',
                          color: Colors.red,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(24, 152, 213, 1), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LuckyNumberBalls(
                        key: bBallKey,
                        showAmounts: widget.showAmounts,
                        letter: 'B',
                        minNumber: 1,
                        maxNumber: 15,
                        ballColor: const Color.fromARGB(255, 4, 19, 156),
                        onNumberEntered: (number) {},
                        luckyNumbersBallHeight: widget.luckyNumbersBallHeight,
                        luckyNumbersBallWidth: widget.luckyNumbersBallWidth,
                        luckyNumbersHeaderFontSize:
                            widget.luckyNumbersHeaderFontSize,
                        luckyNumbersTextFieldWidth:
                            widget.luckyNumbersTextFieldWidth,
                        luckyNumbersTextFieldHeight:
                            widget.luckyNumbersTextFieldHeight,
                        luckyNumbersTextFieldFontsize:
                            widget.luckyNumbersTextFieldFontsize,
                        initialNumber: '',
                      ),
                      LuckyNumberBalls(
                        key: iBallKey,
                        showAmounts: widget.showAmounts,
                        letter: 'I',
                        minNumber: 16,
                        maxNumber: 30,
                        ballColor: const Color.fromARGB(255, 219, 37, 24),
                        onNumberEntered: (number) {},
                        luckyNumbersBallHeight: widget.luckyNumbersBallHeight,
                        luckyNumbersBallWidth: widget.luckyNumbersBallWidth,
                        luckyNumbersHeaderFontSize:
                            widget.luckyNumbersHeaderFontSize,
                        luckyNumbersTextFieldWidth:
                            widget.luckyNumbersTextFieldWidth,
                        luckyNumbersTextFieldHeight:
                            widget.luckyNumbersTextFieldHeight,
                        luckyNumbersTextFieldFontsize:
                            widget.luckyNumbersTextFieldFontsize,
                        initialNumber: '',
                      ),
                      LuckyNumberBalls(
                        key: nBallKey,
                        showAmounts: widget.showAmounts,
                        letter: 'N',
                        minNumber: 31,
                        maxNumber: 45,
                        ballColor: const Color.fromARGB(255, 102, 101, 101),
                        onNumberEntered: (number) {},
                        luckyNumbersBallHeight: widget.luckyNumbersBallHeight,
                        luckyNumbersBallWidth: widget.luckyNumbersBallWidth,
                        luckyNumbersHeaderFontSize:
                            widget.luckyNumbersHeaderFontSize,
                        luckyNumbersTextFieldWidth:
                            widget.luckyNumbersTextFieldWidth,
                        luckyNumbersTextFieldHeight:
                            widget.luckyNumbersTextFieldHeight,
                        luckyNumbersTextFieldFontsize:
                            widget.luckyNumbersTextFieldFontsize,
                        initialNumber: '',
                      ),
                      LuckyNumberBalls(
                        key: gBallKey,
                        showAmounts: widget.showAmounts,
                        letter: 'G',
                        minNumber: 46,
                        maxNumber: 60,
                        ballColor: const Color.fromARGB(255, 15, 122, 19),
                        onNumberEntered: (number) {},
                        luckyNumbersBallHeight: widget.luckyNumbersBallHeight,
                        luckyNumbersBallWidth: widget.luckyNumbersBallWidth,
                        luckyNumbersHeaderFontSize:
                            widget.luckyNumbersHeaderFontSize,
                        luckyNumbersTextFieldWidth:
                            widget.luckyNumbersTextFieldWidth,
                        luckyNumbersTextFieldHeight:
                            widget.luckyNumbersTextFieldHeight,
                        luckyNumbersTextFieldFontsize:
                            widget.luckyNumbersTextFieldFontsize,
                        initialNumber: '',
                      ),
                      LuckyNumberBalls(
                        key: oBallKey,
                        showAmounts: widget.showAmounts,
                        letter: 'O',
                        minNumber: 61,
                        maxNumber: 75,
                        ballColor: const Color.fromARGB(255, 184, 167, 19),
                        onNumberEntered: (number) {},
                        luckyNumbersBallHeight: widget.luckyNumbersBallHeight,
                        luckyNumbersBallWidth: widget.luckyNumbersBallWidth,
                        luckyNumbersHeaderFontSize:
                            widget.luckyNumbersHeaderFontSize,
                        luckyNumbersTextFieldWidth:
                            widget.luckyNumbersTextFieldWidth,
                        luckyNumbersTextFieldHeight:
                            widget.luckyNumbersTextFieldHeight,
                        luckyNumbersTextFieldFontsize:
                            widget.luckyNumbersTextFieldFontsize,
                        initialNumber: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ); 
  }
}
