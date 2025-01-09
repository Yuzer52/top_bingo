// import 'package:bingocaller/screens/main_screen.dart';
// import 'package:flutter/material.dart';

// class MainLayoutScreen extends StatelessWidget {
//   const MainLayoutScreen({super.key});

// /*
// Standard RESOLUTIONS
//  */
// // 1920×1080 (Full HD)
// // 1366×768.
// // 1280×1024.
// // 1440×900.
// // 1600×900.
// // 1680×1050.
// // 1280×800.
// // 1024×768.
// // 800x600
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(24, 152, 213, 1),
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           //DEFAULT WIDGET
//           Widget contentWidget = const MainScreen(
//             generalFontSize: 30,
//             totalNumbersCalledFontSize: 40,
//             totalNumbersCalledHeaderFontSize: 22,
//             totalNumbersCalledWidth: 30,
//             totalNumbersCalledHeight: 0,
//             patternBoardWidth: 150,
//             patternBoardHeight: 230,
//             patternHeaderFontSize: 28,
//             payTextFieldWidth: 160,
//             payTextFieldHeight: 70,
//             payTextFieldFontSize: 50,
//             payHeaderFontSize: 32,
//             winningsTextFieldWidth: 180,
//             winningsTextFieldHeight: 75,
//             winningsTextFieldFontSize: 55,
//             winningsHeaderFontSize: 28,
//             adminBoardWidth: 910,
//             adminBoardHeight: 57,
//             adminBoardFontSize: 26,
//             customBallSize: 250,
//             customBallFontSize: 130,
//             customBallOffset: 30,
//             buttonWidth: 160,
//             buttonHeight: 0,
//             buttonFontSize: 20,
//             buttonGapsHeight: 20,
//             buttonGapsWidth: 20,
//             luckyNumbersContainerWidth: 0.51,
//             luckyNumbersContainerHeight: 300,
//             luckyNumbersHeaderFontSize: 26,
//             luckyNumbersBallHeight: 115,
//             luckyNumbersBallWidth: 115,
//             luckyNumbersTextFieldWidth: 50,
//             luckyNumbersTextFieldHeight: 50,
//             luckyNumbersTextFieldFontsize: 36,
//             luckyNumberOffset: 0,
//           );

//           if (constraints.maxWidth >= 1900 && constraints.maxHeight >= 1000) {
//             //FOR 1900*1000
//             contentWidget = const MainScreen(
//               generalFontSize: 30,
//               totalNumbersCalledFontSize: 60,
//               totalNumbersCalledHeaderFontSize: 20,
//               totalNumbersCalledWidth: 40,
//               totalNumbersCalledHeight: 0,
//               patternBoardWidth: 290,
//               patternBoardHeight: 400,
//               patternHeaderFontSize: 28,
//               payTextFieldWidth: 160,
//               payTextFieldHeight: 90,
//               payTextFieldFontSize: 58,
//               payHeaderFontSize: 32,
//               winningsTextFieldWidth: 250,
//               winningsTextFieldHeight: 120,
//               winningsTextFieldFontSize: 70,
//               winningsHeaderFontSize: 40,
//               adminBoardWidth: 1550,
//               adminBoardHeight: 90,
//               adminBoardFontSize: 40,
//               customBallSize: 400,
//               customBallFontSize: 230,
//               customBallOffset: 150,
//               buttonWidth: 20,
//               buttonHeight: 20,
//               buttonFontSize: 20,
//               buttonGapsHeight: 30,
//               buttonGapsWidth: 30,
//               luckyNumbersContainerWidth: 0.41,
//               luckyNumbersContainerHeight: 400,
//               luckyNumbersHeaderFontSize: 22,
//               luckyNumbersBallHeight: 124,
//               luckyNumbersBallWidth: 124,
//               luckyNumbersTextFieldWidth: 52,
//               luckyNumbersTextFieldHeight: 52,
//               luckyNumbersTextFieldFontsize: 38,
//               luckyNumberOffset: 0,
//             );
//           } else if (constraints.maxWidth >= 1600 &&
//               constraints.maxHeight >= 950) {
//             //FOR 1600*950
//             contentWidget = const MainScreen(
//               generalFontSize: 30,
//               totalNumbersCalledFontSize: 60,
//               totalNumbersCalledHeaderFontSize: 20,
//               totalNumbersCalledWidth: 40,
//               totalNumbersCalledHeight: 0,
//               patternBoardWidth: 250,
//               patternBoardHeight: 350,
//               patternHeaderFontSize: 28,
//               payTextFieldWidth: 160,
//               payTextFieldHeight: 90,
//               payTextFieldFontSize: 58,
//               payHeaderFontSize: 32,
//               winningsTextFieldWidth: 250,
//               winningsTextFieldHeight: 120,
//               winningsTextFieldFontSize: 70,
//               winningsHeaderFontSize: 40,
//               adminBoardWidth: 1300,
//               adminBoardHeight: 90,
//               adminBoardFontSize: 40,
//               customBallSize: 360,
//               customBallFontSize: 200,
//               customBallOffset: 140,
//               buttonWidth: 20,
//               buttonHeight: 20,
//               buttonFontSize: 20,
//               buttonGapsHeight: 50,
//               buttonGapsWidth: 40,
//               luckyNumbersContainerWidth: 0.4,
//               luckyNumbersContainerHeight: 400,
//               luckyNumbersHeaderFontSize: 24,
//               luckyNumbersBallHeight: 116,
//               luckyNumbersBallWidth: 116,
//               luckyNumbersTextFieldWidth: 50,
//               luckyNumbersTextFieldHeight: 50,
//               luckyNumbersTextFieldFontsize: 34,
//               luckyNumberOffset: 0,
//             );
//           } else if (constraints.maxWidth >= 1440 &&
//               constraints.maxHeight >= 900) {
//             //FOR 1400*900
//             contentWidget = const MainScreen(
//               generalFontSize: 30,
//               totalNumbersCalledFontSize: 60,
//               totalNumbersCalledHeaderFontSize: 20,
//               totalNumbersCalledWidth: 40,
//               totalNumbersCalledHeight: 0,
//               patternBoardWidth: 250,
//               patternBoardHeight: 350,
//               patternHeaderFontSize: 28,
//               payTextFieldWidth: 160,
//               payTextFieldHeight: 90,
//               payTextFieldFontSize: 58,
//               payHeaderFontSize: 32,
//               winningsTextFieldWidth: 250,
//               winningsTextFieldHeight: 100,
//               winningsTextFieldFontSize: 65,
//               winningsHeaderFontSize: 40,
//               adminBoardWidth: 1100,
//               adminBoardHeight: 90,
//               adminBoardFontSize: 38,
//               customBallSize: 290,
//               customBallFontSize: 190,
//               customBallOffset: 100,
//               buttonWidth: 20,
//               buttonHeight: 20,
//               buttonFontSize: 20,
//               buttonGapsHeight: 30,
//               buttonGapsWidth: 30,
//               luckyNumbersContainerWidth: 0.4,
//               luckyNumbersContainerHeight: 400,
//               luckyNumbersHeaderFontSize: 26,
//               luckyNumbersBallHeight: 110,
//               luckyNumbersBallWidth: 110,
//               luckyNumbersTextFieldWidth: 50,
//               luckyNumbersTextFieldHeight: 50,
//               luckyNumbersTextFieldFontsize: 34,
//               luckyNumberOffset: 0,
//             );
//           } else if (constraints.maxWidth >= 1300 &&
//               constraints.maxHeight >= 720) {
//             //FOR 1280*800
//             contentWidget = const MainScreen(
//               generalFontSize: 30,
//               totalNumbersCalledFontSize: 50,
//               totalNumbersCalledHeaderFontSize: 22,
//               totalNumbersCalledWidth: 40,
//               totalNumbersCalledHeight: 0,
//               patternBoardWidth: 220,
//               patternBoardHeight: 290,
//               patternHeaderFontSize: 28,
//               payTextFieldWidth: 160,
//               payTextFieldHeight: 85,
//               payTextFieldFontSize: 58,
//               payHeaderFontSize: 32,
//               winningsTextFieldWidth: 250,
//               winningsTextFieldHeight: 95,
//               winningsTextFieldFontSize: 65,
//               winningsHeaderFontSize: 35,
//               adminBoardWidth: 970,
//               adminBoardHeight: 70,
//               adminBoardFontSize: 31,
//               customBallSize: 300,
//               customBallFontSize: 170,
//               customBallOffset: 50,
//               buttonWidth: 20,
//               buttonHeight: 20,
//               buttonFontSize: 20,
//               buttonGapsHeight: 30,
//               buttonGapsWidth: 30,
//               luckyNumbersContainerWidth: 0.45,
//               luckyNumbersContainerHeight: 400,
//               luckyNumbersHeaderFontSize: 24,
//               luckyNumbersBallHeight: 110,
//               luckyNumbersBallWidth: 110,
//               luckyNumbersTextFieldWidth: 50,
//               luckyNumbersTextFieldHeight: 50,
//               luckyNumbersTextFieldFontsize: 34,
//               luckyNumberOffset: 0,
//             );
//           } else if (constraints.maxWidth >= 1280 &&
//               constraints.maxHeight >= 700) {
//             //FOR 1280*800
//             contentWidget = const MainScreen(
//               generalFontSize: 30,
//               totalNumbersCalledFontSize: 50,
//               totalNumbersCalledHeaderFontSize: 22,
//               totalNumbersCalledWidth: 40,
//               totalNumbersCalledHeight: 0,
//               patternBoardWidth: 200,
//               patternBoardHeight: 260,
//               patternHeaderFontSize: 28,
//               payTextFieldWidth: 160,
//               payTextFieldHeight: 70,
//               payTextFieldFontSize: 50,
//               payHeaderFontSize: 30,
//               winningsTextFieldWidth: 250,
//               winningsTextFieldHeight: 85,
//               winningsTextFieldFontSize: 65,
//               winningsHeaderFontSize: 30,
//               adminBoardWidth: 970,
//               adminBoardHeight: 60,
//               adminBoardFontSize: 31,
//               customBallSize: 280,
//               customBallFontSize: 170,
//               customBallOffset: 50,
//               buttonWidth: 20,
//               buttonHeight: 20,
//               buttonFontSize: 20,
//               buttonGapsHeight: 30,
//               buttonGapsWidth: 30,
//               luckyNumbersContainerWidth: 0.45,
//               luckyNumbersContainerHeight: 400,
//               luckyNumbersHeaderFontSize: 24,
//               luckyNumbersBallHeight: 110,
//               luckyNumbersBallWidth: 110,
//               luckyNumbersTextFieldWidth: 50,
//               luckyNumbersTextFieldHeight: 50,
//               luckyNumbersTextFieldFontsize: 34,
//               luckyNumberOffset: 0,
//             );
//           }

//           print("Width: " +
//               constraints.maxWidth.toString() +
//               "Height: " +
//               constraints.maxHeight.toString());
//           return AnimatedSwitcher(
//             duration: const Duration(milliseconds: 50),
//             child: contentWidget,
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:bingocaller/screens/main_screen.dart';
import 'package:flutter/material.dart';

class ResponsiveValues {
  final BuildContext context;
  final Size screenSize;

  ResponsiveValues(this.context) : screenSize = MediaQuery.of(context).size;

  double get width => screenSize.width;
  double get height => screenSize.height;

  double interpolate(double start, double end, double t) {
    return start + (end - start) * t;
  }

  double responsiveValue(double small, double large) {
    double t = (width - 800) / (1920 - 800);
    t = t.clamp(0.0, 1.0);

    return interpolate(small, large, t);
  }
}

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 152, 213, 1),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final responsive = ResponsiveValues(context);

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 50),
            child: MainScreen(
              generalFontSize: responsive.responsiveValue(10, 30),
              totalNumbersCalledFontSize: responsive.responsiveValue(20, 60),
              totalNumbersCalledHeaderFontSize:
                  responsive.responsiveValue(9, 22),
              totalNumbersCalledWidth: responsive.responsiveValue(15, 40),
              totalNumbersCalledHeight: 0,
              patternBoardWidth: responsive.responsiveValue(75, 290),
              patternBoardHeight: responsive.responsiveValue(115, 400),
              patternHeaderFontSize: 28,
              payTextFieldWidth: responsive.responsiveValue(90, 220),
              payTextFieldHeight: responsive.responsiveValue(60, 90),
              payTextFieldFontSize: responsive.responsiveValue(30, 60),
              payHeaderFontSize: responsive.responsiveValue(16, 32),
              winningsTextFieldWidth: responsive.responsiveValue(100, 300),
              winningsTextFieldHeight: responsive.responsiveValue(70, 120),
              winningsTextFieldFontSize: responsive.responsiveValue(36, 80),
              winningsHeaderFontSize: responsive.responsiveValue(16, 40),
              adminBoardWidth: responsive.responsiveValue(700, 1550),
              adminBoardHeight: responsive.responsiveValue(25, 98),
              adminBoardFontSize: responsive.responsiveValue(18, 58),
              customBallSize: responsive.responsiveValue(125, 400),
              customBallFontSize: responsive.responsiveValue(65, 230),
              customBallOffset: responsive.responsiveValue(15, 150),
              buttonWidth: responsive.responsiveValue(80, 180),
              buttonHeight: responsive.responsiveValue(25, 60),
              buttonFontSize: 20,
              buttonGapsHeight: responsive.responsiveValue(10, 30),
              buttonGapsWidth: responsive.responsiveValue(10, 30),
              luckyNumbersContainerWidth:
                  responsive.responsiveValue(0.45, 0.51),
              luckyNumbersContainerHeight: responsive.responsiveValue(150, 450),
              luckyNumbersHeaderFontSize: responsive.responsiveValue(20, 26),
              luckyNumbersBallHeight: responsive.responsiveValue(90, 140),
              luckyNumbersBallWidth: responsive.responsiveValue(90, 140),
              luckyNumbersTextFieldWidth: 50,
              luckyNumbersTextFieldHeight: 50,
              luckyNumbersTextFieldFontsize: responsive.responsiveValue(37, 40),
              luckyNumberOffset: 0,
              bonusHeaderFontSize: responsive.responsiveValue(17, 35),
              bonusTextFieldFontSize: responsive.responsiveValue(17, 60),
              bonusTextFieldWidth: responsive.responsiveValue(50, 200),
              bonusTextFieldHeight: responsive.responsiveValue(50, 70),
            ),
          );
        },
      ),
    );
  }
}

class CustomFlex extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;

  const CustomFlex(
      {super.key, required this.children, this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalFlex = children.length.toDouble();
        double unitSize = (direction == Axis.horizontal
                ? constraints.maxWidth
                : constraints.maxHeight) /
            totalFlex;

        return Flex(
          direction: direction,
          children: children.map((child) {
            return Flexible(
              flex: 1,
              child: SizedBox(
                width: direction == Axis.horizontal ? unitSize : null,
                height: direction == Axis.vertical ? unitSize : null,
                child: child,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
