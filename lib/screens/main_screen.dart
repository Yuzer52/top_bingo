// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:audioplayers/audioplayers.dart';
import 'package:bingocaller/screens/secondary_admin_screen.dart';
import 'package:bingocaller/screens/super_admin_screen.dart';
import 'package:bingocaller/widgets/lucky_numbers.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:async';
import 'package:bingocaller/assets/Utils/app_styles.dart';
import 'package:bingocaller/assets/Utils/theme_provide.dart';
import 'package:bingocaller/screens/admin_screen.dart';
import 'package:bingocaller/services/game_record.dart';
import 'package:bingocaller/services/game_service.dart';
import 'package:bingocaller/services/player_record.dart';
import 'package:bingocaller/widgets/custom_adminBoard.dart';
import 'package:bingocaller/widgets/custom_board.dart';
import 'package:bingocaller/widgets/custom_button.dart';
import 'package:bingocaller/widgets/custom_call.dart';
import 'package:bingocaller/widgets/custom_pattern_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  final double generalFontSize;

  final double totalNumbersCalledWidth;
  final double totalNumbersCalledHeight;
  final double totalNumbersCalledFontSize;
  final double totalNumbersCalledHeaderFontSize;

  final double patternBoardWidth;
  final double patternBoardHeight;
  final double patternHeaderFontSize;

  final double payTextFieldWidth;
  final double payTextFieldHeight;
  final double payTextFieldFontSize;
  final double payHeaderFontSize;

  final double winningsTextFieldWidth;
  final double winningsTextFieldHeight;
  final double winningsTextFieldFontSize;
  final double winningsHeaderFontSize;

  final double adminBoardWidth;
  final double adminBoardHeight;
  final double adminBoardFontSize;

  final double customBallSize;
  final double customBallFontSize;
  final double customBallOffset;

  final double buttonWidth;
  final double buttonHeight;
  final double buttonFontSize;
  final double buttonGapsWidth;
  final double buttonGapsHeight;

  final double luckyNumbersContainerWidth;
  final double luckyNumbersContainerHeight;
  final double luckyNumbersHeaderFontSize;
  final double luckyNumbersTextFieldWidth;
  final double luckyNumbersTextFieldHeight;
  final double luckyNumbersTextFieldFontsize;
  final double luckyNumbersBallWidth;
  final double luckyNumbersBallHeight;
  final double luckyNumberOffset;

  final double bonusHeaderFontSize;
  final double bonusTextFieldWidth;
  final double bonusTextFieldHeight;
  final double bonusTextFieldFontSize;

  const MainScreen({
    super.key,
    required this.generalFontSize,
    required this.totalNumbersCalledWidth,
    required this.totalNumbersCalledHeight,
    required this.patternBoardWidth,
    required this.patternBoardHeight,
    required this.payTextFieldWidth,
    required this.payTextFieldHeight,
    required this.payTextFieldFontSize,
    required this.winningsTextFieldWidth,
    required this.winningsTextFieldHeight,
    required this.winningsTextFieldFontSize,
    required this.adminBoardWidth,
    required this.adminBoardHeight,
    required this.adminBoardFontSize,
    required this.customBallSize,
    required this.customBallFontSize,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonFontSize,
    required this.patternHeaderFontSize,
    required this.luckyNumbersContainerWidth,
    required this.luckyNumbersContainerHeight,
    required this.luckyNumbersHeaderFontSize,
    required this.luckyNumbersTextFieldWidth,
    required this.luckyNumbersTextFieldHeight,
    required this.luckyNumbersTextFieldFontsize,
    required this.luckyNumbersBallWidth,
    required this.luckyNumbersBallHeight,
    required this.totalNumbersCalledFontSize,
    required this.totalNumbersCalledHeaderFontSize,
    required this.customBallOffset,
    required this.payHeaderFontSize,
    required this.winningsHeaderFontSize,
    required this.luckyNumberOffset,
    required this.buttonGapsWidth,
    required this.buttonGapsHeight,
    required this.bonusHeaderFontSize,
    required this.bonusTextFieldWidth,
    required this.bonusTextFieldHeight,
    required this.bonusTextFieldFontSize,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  Timer? _autoCallTimer;
  final FocusNode _mainfocusNode = FocusNode();
  //Holds the list of called numbers
  bool hasSavedBonusForCurrentGame = false; // Add this line
  final Set<int> calledNumbers = {};
  //Holds the key of the admin board
  final GlobalKey<CustomAdminBoardState> customBoardKey =
      GlobalKey<CustomAdminBoardState>();
  final GlobalKey<LuckyNumbersState> luckyNumbersKey =
      GlobalKey<LuckyNumbersState>();
  final GlobalKey<CustomBoardState> customKey = GlobalKey<CustomBoardState>();

  TextEditingController payController = TextEditingController();
  TextEditingController winningsController = TextEditingController();
  final Map<String, double> winningsPercentageMap = {
    'A': 0,
    'B': 20,
    'C': 25,
    'D': 30,
    'E': 35,
    'F': 40,
    'G': 45,
    'H': 50,
  };

/* Flags for -
        Dark Mode
        Game Progress
        Automatic calling
        Automatic call active or not
*/
  bool isDarkMode = false;
  bool isGameInProgress = false;
  bool hasGameStarted = false;
  bool isAutomaticMode = true;
  bool hasShownWarning = false;
  bool isAutoCallingActive = false;
  final int MAX_GAME_RECORDS = 700;
  final double MAX_TOTAL_PROFIT = 10000;
  double currentTotalProfit = 0;
  bool hasShownProfitWarning = false;
  bool showLuckyNumbers = true;
  bool isTwoLineMode = true;
  bool isAutomaticPercentage = true;
  int? lastCalledNumber;
  double winningsPercentage = 0; // Default value
  String selectedWinningsPercentage = 'B'; // Default to 'A' (20%)
  String bonusController = '';
  bool wonWithLuckyNumber = false;
  int? bonusDeduction;

  //List of available voices
/* String for gender
  String for pattern

*/
  List<Map<String, String>> voices = [];
  String selectedVoiceGender = 'Male'; // Default to female voice
  String pattern = 'noPattern';
  String enteredPrice = '';
  String enteredWinnings = '';
  String playerName = '';

  int j = 0;
  int currentCall = 0;
  int autoDuration = 4; // Default to 5 seconds
  int? cartelNumber = 0;

  List<GameRecord> gameRecords = [];
  List<GameRecord> superGameRecords = [];
  List<PlayerRecord> playerRecords = [];
  Set<int> usedCartelaNumbers = {};
  Set<int> lockedCartelas = {};
  Set<int> lockedBoards = {};
  int gameCount = 0;
  int playerCount = 0;

  BingoPattern currentPattern = BingoPattern.noPattern;
  TextEditingController playerNamecontroller = TextEditingController();

//Function that updates the pattern
  void updatePattern(BingoPattern newPattern) {
    setState(() {
      currentPattern = newPattern;
    });
  }

  // Add this method to handle board locking
  void handleBoardLock(int boardNumber) {
    setState(() {
      lockedBoards.add(boardNumber);
    });
  }

//Function that saves the game record
  Future<void> saveGameRecord() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – T hh:mm a').format(now);
    gameCount++;

    // Only proceed if it's a regular game start

    final newRecord = GameRecord(
        name: 'Game $gameCount',
        date: formattedDate,
        calledNumbers: calledNumbers.toList(),
        playerCount: playerCount,
        pay: enteredPrice.isNotEmpty ? double.parse(enteredPrice) : 0,
        winnings: winningsController.text.isNotEmpty
            ? double.parse(winningsController.text)
            : 0,
        wonWithLuckyNumber: false,
        bonusAmount: 0);

    await _saveToAdminStorage(newRecord);
    await _saveToSuperAdminStorage(newRecord);
  }

  Future<void> savePlayerRecord(PlayerRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    playerRecords.add(record);
    final String encodedRecords =
        json.encode(playerRecords.map((record) => record.toJson()).toList());
    await prefs.setString('playerRecords', encodedRecords);
    setState(() {
      playerCount = playerRecords.length;
      calculateWinnings();
    });
  }

  Future<void> loadPlayerRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedRecords = prefs.getString('playerRecords');
    if (encodedRecords != null) {
      final List<dynamic> decodedRecords = json.decode(encodedRecords);
      playerRecords = decodedRecords
          .map((record) => PlayerRecord.fromJson(record))
          .toList();
      setState(() {
        playerCount = playerRecords.length;
      });
    }
  }

//Function that loads the game records
  Future<void> loadGameRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedRecords = prefs.getString('gameRecords');
    if (encodedRecords != null) {
      final List<dynamic> decodedRecords = json.decode(encodedRecords);
      gameRecords =
          decodedRecords.map((record) => GameRecord.fromJson(record)).toList();
    }
    gameCount = prefs.getInt('gameCount') ?? 0;
  }

//Innit function that loads the game records when the app starts
  @override
  void initState() {
    super.initState();
    _mainfocusNode.requestFocus();
    _clearPlayerRecords();
    loadGameRecords();
    loadPlayerRecords();
    calculateWinnings(); // Add this line
  }

  @override
  void dispose() {
    payController.dispose();
    winningsController.dispose();
    _mainfocusNode.dispose();
    super.dispose();
  }

  double getWinningsPercentage() {
    return winningsPercentage;
  }

  void refreshLuckyNumbers() {
    if (showLuckyNumbers) {
      luckyNumbersKey.currentState?.refreshLuckyNumbers();
    } else {
      luckyNumbersKey.currentState
          ?.clearAllNumbers(); // Call a new method to clear all numbers
    }
  }

//Main build widget where we build the UI
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _mainfocusNode,
      onKeyEvent: _handleKeyPress,
      child: GestureDetector(
        onTap: () {
          _mainfocusNode.requestFocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(24, 152, 213, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/top_text_image.jpg',
                  fit: BoxFit.contain,
                  height: 50,
                ),
                SizedBox(width: 8), // Add some space between the images
                Image.asset(
                  'assets/bingo_text_image_transparent.png',
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ],
            ),
            leading: Container(), // This removes the default drawer icon
            actions: [
              Opacity(
                opacity: isGameInProgress ? 0.5 : 1.0,
                child: IconButton(
                  icon: Icon(Icons.lock_clock_sharp),
                  onPressed: isGameInProgress
                      ? null
                      : () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => SecondaryAdminScreen())),
                ),
              ),
              Opacity(
                opacity: isGameInProgress ? 0.5 : 1.0,
                child: IconButton(
                  icon: Icon(Icons.admin_panel_settings_sharp),
                  onPressed: isGameInProgress
                      ? null
                      : () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => AdminScreen())),
                ),
              ),
              Opacity(
                opacity: isGameInProgress ? 0.5 : 1.0,
                child: IconButton(
                  icon: Icon(Icons.account_box_sharp),
                  onPressed: isGameInProgress
                      ? null
                      : () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => SuperAdminScreen())),
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
          endDrawer: Drawer(
            width: 400,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(),
                          child: Text(
                            'Top Bingo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text('Bonus'),
                              trailing: Switch(
                                value: showLuckyNumbers,
                                onChanged: (value) {
                                  setState(() {
                                    showLuckyNumbers = value;
                                  });
                                },
                              ),
                              subtitle: Text(showLuckyNumbers ? 'ON' : 'OFF'),
                            ),
                            //Automatic or Manual
                            ListTile(
                              title: Text('Calling Mode'),
                              trailing: Switch(
                                value: isAutomaticMode,
                                onChanged: (value) {
                                  setState(() {
                                    isAutomaticMode = value;
                                  });
                                },
                              ),
                              subtitle: Text(
                                  isAutomaticMode ? 'Automatic' : 'Manual'),
                            ),
                            ListTile(
                              title: Text('Call Sound'),
                              trailing: Switch(
                                value: isAutomaticPercentage,
                                onChanged: (value) {
                                  setState(() {
                                    isAutomaticPercentage = value;
                                    if (isAutomaticPercentage) {
                                      winningsPercentage =
                                          getAutomaticPercentage();
                                    }
                                    calculateWinnings();
                                  });
                                },
                              ),
                              subtitle: Text(isAutomaticPercentage
                                  ? 'Automatic'
                                  : 'Manual'),
                            ),
                            if (isAutomaticMode)
                              ListTile(
                                title: Text('Auto Call Duration'),
                                subtitle:
                                    Text('${autoDuration.round()} seconds'),
                                trailing: SizedBox(
                                  width: 200,
                                  child: Slider(
                                    value: autoDuration.toDouble(),
                                    min: 1,
                                    max: 60,
                                    divisions: 59,
                                    label: autoDuration.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        autoDuration = value.round();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            // Voice options (male/female)
                            ListTile(
                              title: Text('Winning Mode'),
                              trailing: Switch(
                                value: isTwoLineMode,
                                onChanged: (value) {
                                  setState(() {
                                    isTwoLineMode = value;
                                  });
                                },
                              ),
                              subtitle: Text(isTwoLineMode
                                  ? 'Two Lines Required'
                                  : 'One Line Required'),
                            ),
                            ListTile(
                              title: Text('Voice Gender'),
                              trailing: DropdownButton<String>(
                                value: selectedVoiceGender,
                                items: ['Female', 'Male'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.accent,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedVoiceGender = newValue;
                                    });
                                  }
                                },
                              ),
                            ),

                            ListTile(
                              title: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          255, 114, 114, 116)),
                                  children: [
                                    TextSpan(
                                        text: DateFormat('EEEE, MMMM d, y ')
                                            .format(DateTime.now())),
                                    TextSpan(
                                      text: selectedWinningsPercentage,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 110, 110, 110)),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Focus(
                                autofocus: true,
                                onKey: (_, RawKeyEvent event) {
                                  if (event is RawKeyDownEvent) {
                                    if (event.logicalKey ==
                                        LogicalKeyboardKey.arrowUp) {
                                      _changeBonusSelection(-1);
                                      return KeyEventResult.handled;
                                    } else if (event.logicalKey ==
                                        LogicalKeyboardKey.arrowDown) {
                                      _changeBonusSelection(1);
                                      return KeyEventResult.handled;
                                    }
                                  }
                                  return KeyEventResult.ignored;
                                },
                                child: Builder(
                                  builder: (BuildContext context) {
                                    final FocusNode focusNode =
                                        Focus.of(context);
                                    return MouseRegion(
                                      onHover: (_) => FocusScope.of(context)
                                          .requestFocus(focusNode),
                                      child: Listener(
                                        onPointerSignal: (pointerSignal) {
                                          if (pointerSignal
                                              is PointerScrollEvent) {
                                            _changeBonusSelection(
                                                pointerSignal.scrollDelta.dy > 0
                                                    ? 1
                                                    : -1);
                                          }
                                        },
                                        child: SizedBox(width: 24, height: 24),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            //Dark/Light mode
                            ListTile(
                              title: Text('Dark Mode'),
                              trailing: Consumer<ThemeProvider>(
                                builder: (context, themeProvider, child) {
                                  return Switch(
                                    value: themeProvider.isDarkMode,
                                    onChanged: (value) {
                                      themeProvider.toggleTheme(value);
                                    },
                                  );
                                },
                              ),
                            ),
                            // Pattern selection
                            DropdownButton<BingoPattern>(
                              value: currentPattern,
                              onChanged: (BingoPattern? newValue) {
                                setState(() {
                                  currentPattern = newValue!;
                                });
                              },
                              items: BingoPattern.values
                                  .map((BingoPattern pattern) {
                                return DropdownMenuItem<BingoPattern>(
                                  value: pattern,
                                  child:
                                      Text(pattern.toString().split('.').last),
                                );
                              }).toList(),
                            ),

                            PatternBoard(
                              boardHeight: 280,
                              boardWidth: 200,
                              headerFontSize: 25,
                              key: ValueKey(
                                currentPattern,
                              ),
                              initialPattern: currentPattern,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Row(
            children: [
              Row(
                children: [
                  //The total and current call here
                  Padding(padding: EdgeInsets.all(10)),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Total Numbers Called",
                        style: TextStyle(
                            fontSize: widget.totalNumbersCalledHeaderFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.totalNumbersCalledWidth,
                          vertical: widget.totalNumbersCalledHeight,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(
                          "${calledNumbers.length}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.totalNumbersCalledFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PatternBoard(
                        boardHeight: widget.patternBoardHeight,
                        boardWidth: widget.patternBoardWidth,
                        headerFontSize: widget.patternHeaderFontSize,
                        key: ValueKey(
                          currentPattern,
                        ),
                        initialPattern: currentPattern,
                      ),
                      Column(
                        children: [
                          Text(
                            "ደራሽ",
                            style: TextStyle(
                              fontSize:
                                  40, // Increased size for better visibility
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Algerian',
                              color: Colors.blue,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: widget.winningsTextFieldWidth,
                            height: widget.winningsTextFieldHeight,
                            child: TextField(
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Algerian',
                                color: Colors.red,
                              ),
                              controller: winningsController,
                              enabled: false, // Disable the TextField
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(padding: EdgeInsets.all(1)),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "መደብ",
                                style: TextStyle(
                                  fontSize:
                                      30, // Increased size for better visibility
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Algerian',
                                  color: Colors.blue,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: const Color.fromARGB(
                                          255, 138, 138, 138),
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: widget.payTextFieldWidth,
                                height: widget.payTextFieldHeight,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: widget.payTextFieldFontSize,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Algerian',
                                    color: Colors.red,
                                  ),
                                  controller: payController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  enabled: !isGameInProgress,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      enteredPrice = value;
                                    });
                                    calculateWinnings();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      SizedBox(
                        width: widget.adminBoardWidth,
                        // Adjust this value as needed
                        child: CustomAdminBoard(
                          headerFontSize: 30,
                          luckyFontSize: 20,
                          numberFontSize: widget.adminBoardFontSize,
                          luckyLableFontSize: 8,
                          kumet: widget.adminBoardHeight,
                          key: customBoardKey,
                        ),
                      ),
                      Row(
                        children: [
                          CustomCall(
                            sizeFont: widget.customBallFontSize,
                            size: widget.customBallSize,
                            margin: EdgeInsets.fromLTRB(
                                0, 20, widget.customBallOffset, 0),
                            text: currentCall.toString(),
                            color: Color.fromARGB(255, 255, 203, 34),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 170,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, widget.luckyNumberOffset, 0),
                                      child: LuckyNumbers(
                                        key: showLuckyNumbers
                                            ? luckyNumbersKey
                                            : null,
                                        bonusNumber: showLuckyNumbers
                                            ? bonusController
                                            : "",
                                        showAmounts: showLuckyNumbers,
                                        luckyNumbersContainerWidth:
                                            widget.luckyNumbersContainerWidth,
                                        luckyNumbersContainerHeight:
                                            widget.luckyNumbersContainerHeight,
                                        luckyNumbersBallHeight:
                                            widget.luckyNumbersBallHeight,
                                        luckyNumbersBallWidth:
                                            widget.luckyNumbersBallWidth,
                                        luckyNumbersHeaderFontSize:
                                            widget.luckyNumbersHeaderFontSize,
                                        luckyNumbersTextFieldFontsize: widget
                                            .luckyNumbersTextFieldFontsize,
                                        luckyNumbersTextFieldWidth:
                                            widget.luckyNumbersTextFieldWidth,
                                        luckyNumbersTextFieldHeight:
                                            widget.luckyNumbersTextFieldHeight,
                                        headerFontSize:
                                            widget.luckyNumbersHeaderFontSize,
                                        textFieldWidth:
                                            widget.luckyNumbersTextFieldWidth,
                                        textFieldHeight:
                                            widget.luckyNumbersTextFieldHeight,
                                        textFieldFontsize: widget
                                            .luckyNumbersTextFieldFontsize,
                                        ballWidth: widget.luckyNumbersBallWidth,
                                        ballHeight:
                                            widget.luckyNumbersBallHeight,
                                        bonusHeaderFontSize:
                                            widget.bonusHeaderFontSize,
                                        bonusTextFieldWidth:
                                            widget.bonusTextFieldWidth,
                                        bonusTextFieldHeight:
                                            widget.bonusTextFieldHeight,
                                        bonusTextFieldFontSize:
                                            widget.bonusTextFieldFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CustomElevatedButton(
                                    text: "Add Player",
                                    onPressed: _addPlayer,
                                    foregroundColor: AppTheme.accent,
                                    backgroundColor: AppTheme.light,
                                    isEnabled: !isGameInProgress,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                  SizedBox(
                                    width: widget.buttonGapsWidth,
                                  ), // Adds space between buttons
                                  CustomElevatedButton(
                                    text: isAutomaticMode
                                        ? (isAutoCallingActive
                                            ? "Stop"
                                            : "Start")
                                        : "Next Call",
                                    isEnabled: isGameInProgress,
                                    onPressed: isAutomaticMode
                                        ? _toggleAutoCalling
                                        : _makeNextCall,
                                    foregroundColor: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    backgroundColor: isAutoCallingActive
                                        ? const Color.fromARGB(
                                            255, 0, 136, 18) // Red when active
                                        : const Color.fromARGB(255, 216, 2,
                                            2), // Green when stopped
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                  SizedBox(
                                    width: widget.buttonGapsWidth,
                                  ), // Adds space between buttons
                                  CustomElevatedButton(
                                    text: "Start Game",
                                    foregroundColor: AppTheme.light,
                                    backgroundColor: AppTheme.accent,
                                    isEnabled: !isGameInProgress,
                                    onPressed: _startGame,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                  SizedBox(width: widget.buttonGapsWidth),
                                  // New Shuffle Button
                                  CustomElevatedButton(
                                    text: "Shuffle",
                                    foregroundColor: AppTheme.light,
                                    backgroundColor: AppTheme.accent,
                                    isEnabled: !isGameInProgress,
                                    onPressed: _shuffleBoard,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: widget.buttonGapsWidth,
                                height: widget.buttonGapsHeight,
                              ),
                              Row(
                                children: [
                                  CustomElevatedButton(
                                    text: "View Players",
                                    onPressed: _showPlayersDialog,
                                    foregroundColor: AppTheme.darkBlue,
                                    backgroundColor: AppTheme.light,
                                    isEnabled: true,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                  SizedBox(
                                    width: widget.buttonGapsWidth,
                                  ),
                                  CustomElevatedButton(
                                    text: "Check Board",
                                    onPressed: _showCheckBoard,
                                    foregroundColor: AppTheme.darkBlue,
                                    backgroundColor: AppTheme.light,
                                    isEnabled: true,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                  SizedBox(
                                    width: widget.buttonGapsWidth,
                                  ),
                                  CustomElevatedButton(
                                    text: "Reset Game",
                                    foregroundColor: AppTheme.accent,
                                    backgroundColor: AppTheme.light,
                                    isEnabled: isGameInProgress,
                                    onPressed: _resetGame,
                                    buttonFontSize: widget.buttonFontSize,
                                    buttonHeight: widget.buttonHeight,
                                    buttonWidth: widget.buttonWidth,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame() {
    SharedPreferences.getInstance().then((prefs) {
      double totalProfit = prefs.getDouble('totalProfitAmount') ?? 0.0;

      if (totalProfit >= MAX_TOTAL_PROFIT) {
        _showMaxProfitReachedDialog();
        return;
      } else if (totalProfit >= MAX_TOTAL_PROFIT - 500 &&
          !hasShownProfitWarning) {
        _showProfitLimitWarningDialog();
        setState(() {
          hasShownProfitWarning = true;
        });
      } else {
        setState(() {
          isGameInProgress = true;
        });

        luckyNumbersKey.currentState?.refreshLuckyNumbers();
        calculateWinnings();
        winningsController.text = calculatedWinnings.toStringAsFixed(0);

        // Calculate and set bonus based on winnings
        String bonus = "";
        double winnings = calculatedWinnings;

        if (winnings <= 350) {
          bonus = "50";
        } else if (winnings <= 550) {
          bonus = "100";
        } else if (winnings <= 650) {
          bonus = "150";
        } else if (winnings <= 750) {
          bonus = "200";
        } else {
          bonus = "300";
        }

        setState(() {
          bonusController = bonus;
        });

        // Beep sequence moved here
        final beepPlayer = AudioPlayer();
        beepPlayer.setVolume(0.55); // Set volume to 30%
        beepPlayer
            .play(AssetSource('audio_recordings/beep_sound.mp3'))
            .then((_) {
          return Future.delayed(Duration(seconds: 4));
        }).then((_) {
          saveGameRecord().then((_) {
            int randomNumber = GameService.generateRandomNumber();
            GameService.updateAdminBoard(randomNumber, (number, textColor) {
              customBoardKey.currentState?.updateNumber(number, textColor);
              setState(() {
                currentCall = randomNumber;
                calledNumbers.add(randomNumber);
              });
              _speakNumber(randomNumber);
            });

            if (isAutomaticMode) {
              setState(() {
                isAutoCallingActive = true;
              });
              _startAutoCalling();
            }
          });
        });
      }
    });
  }

  void _shuffleBoard() async {
    final shufflePlayer = AudioPlayer();
    final random = Random();
    List<int> allNumbers = List.generate(75, (index) => index + 1);
    shufflePlayer.setVolume(0.25); // Set volume to 30%
    await shufflePlayer.play(AssetSource('audio_recordings/shuffle.mp3'));

    // Create more visible animation
    for (int i = 0; i < 25; i++) {
      // Bold numbers and change background colors
      for (int j = 0; j < 10; j++) {
        int randomIndex = random.nextInt(allNumbers.length);
        int number = allNumbers[randomIndex];
        customBoardKey.currentState?.toggleNumberBold(number, true);
        // Add background color change based on number range
        Color backgroundColor = _getBackgroundColorForNumber(number);
        customBoardKey.currentState?.updateNumber(number, Colors.black);
      }
      await Future.delayed(Duration(milliseconds: 100));

      // Clear all bold numbers and reset background colors
      customBoardKey.currentState?.clearBoldNumbers();
      customBoardKey.currentState?.resetBoard();
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

// Helper method to determine background color
  Color _getBackgroundColorForNumber(int number) {
    if (number <= 15) return Colors.red[100]!;
    if (number <= 30) return Colors.blue[100]!;
    if (number <= 45) return Colors.green[100]!;
    if (number <= 60) return Colors.orange[100]!;
    return Colors.purple[100]!;
  }

//Function that resets the game
  void _resetGame() {
    final gameOver = AudioPlayer();
    GameService.showResetConfirmation(
      context,
      () {
        GameService.resetAdminBoard(() {
          customBoardKey.currentState?.resetBoard();

          currentCall = 0;
          calledNumbers.clear();
          GameService.resetCalledNumbers();
          _clearPlayerRecords();
          usedCartelaNumbers.clear();
          _autoCallTimer?.cancel();
          _autoCallTimer = null;
          winningsController.clear();
          lockedCartelas.clear();
          setState(() {
            isGameInProgress = false;
            lockedBoards.clear();
            playerCount = 0;
            hasSavedBonusForCurrentGame = false; // Reset the flag here
            gameOver.play(AssetSource(
                'audio_recordings/gameOver-$selectedVoiceGender.mp3'));
            isAutoCallingActive = false;
          });
        });
      },
    );
  }

  Future<void> _clearPlayerRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('playerRecords');
    int currentPlayerCount = playerCount;
    playerRecords.clear();
    setState(() {
      playerCount = currentPlayerCount;
    });
  }

//Function to start the auto calling process based on a timer
  void _startAutoCalling() {
    if (!isGameInProgress) return;

    // Cancel any existing timer
    _autoCallTimer?.cancel();

    Future.delayed(Duration(seconds: 1), () {
      Duration duration = Duration(seconds: autoDuration);
      _autoCallTimer = Timer.periodic(duration, (Timer timer) {
        if (!isGameInProgress || !isAutomaticMode || !isAutoCallingActive) {
          timer.cancel();
          _autoCallTimer = null;
          setState(() {
            isAutoCallingActive = false;
          });
          return;
        }
        _callNextNumber();
      });
    });
  }

  void _makeNextCall() {
    if (!isGameInProgress) return;
    _callNextNumber();
  }

//Function to call the next number
  void _callNextNumber() {
    if (calledNumbers.length >= 75) {
      _showGameOverPopup();
      return;
    }

    int randomNumber = GameService.generateRandomNumber();
    GameService.updateAdminBoard(randomNumber, (number, color) {
      customBoardKey.currentState?.updateNumber(number, color);
      setState(() {
        currentCall = randomNumber;
        lastCalledNumber = randomNumber; // Add this line
        calledNumbers.add(randomNumber);
      });
      _speakNumber(randomNumber);
    });

    if (calledNumbers.length == 75) {
      _showGameOverPopup();
    }
  }

  void _showGameOverPopup() {
    setState(() {
      isAutoCallingActive = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GAME OVER'),
          content: Text('All 75 numbers have been called.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//Function to toggle the auto calling mode on and off
  void _toggleAutoCalling() {
    final gamePaused = AudioPlayer();
    final gameResumed = AudioPlayer();
    setState(() {
      isAutoCallingActive = !isAutoCallingActive;
    });

    if (isAutoCallingActive) {
      gameResumed.setVolume(1);
      gameResumed.play(
          AssetSource('audio_recordings/gameresumed-$selectedVoiceGender.mp3'));

      _startAutoCalling();
    } else {
      gamePaused.setVolume(1);
      gamePaused.play(
          AssetSource('audio_recordings/gamepaused-$selectedVoiceGender.mp3'));
      Future.delayed(Duration(seconds: 2), () {
        // If there's an active timer, cancel it here
      });
      // If there's an active timer, cancel it here
    }
  }

//Function to speak the letter + number
  Future<void> _speakNumber(int number) async {
    String letter = _getLetterForNumber(number);
    final player = AudioPlayer();

    try {
      await player.play(AssetSource(
          'audio_recordings/$letter-$number-$selectedVoiceGender.mp3'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to play audio for $letter-$number'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

//Function to get the letter for a given number
  String _getLetterForNumber(int number) {
    if (number <= 15) return "B";
    if (number <= 30) return "I";
    if (number <= 45) return "N";
    if (number <= 60) return "G";
    return "O";
  }

//Function that displays the board and allows the user to check the numbers called

  void _addPlayer() {
    TextEditingController cartelaNumberController = TextEditingController();
    FocusNode focusNode = FocusNode();
    String errorMessage = '';
    final AudioPlayer audioPlayer =
        AudioPlayer(); // Initialize the audio player
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Player'),
              content: SizedBox(
                width: 350,
                height: 500,
                child: Column(
                  children: [
                    TextField(
                      focusNode: focusNode,
                      controller: cartelaNumberController,
                      onSubmitted: (value) {
                        errorMessage = '';
                        int cartela =
                            int.tryParse(cartelaNumberController.text) ?? 0;
                        if (cartela >= 1 &&
                            cartela <= 200 &&
                            !usedCartelaNumbers.contains(cartela)) {
                          usedCartelaNumbers.add(cartela);
                          savePlayerRecord(PlayerRecord(cartela: cartela));
                          calculateWinnings();

                          cartelaNumberController.clear();
                        } else if (usedCartelaNumbers.contains(cartela)) {
                          errorMessage =
                              'This cartela number is already in use. Please choose another.';
                          audioPlayer.play(
                            AssetSource(
                                'audio_recordings/error_sound.mp3'), // Play error sound
                          );
                        } else {
                          errorMessage =
                              'Please enter a valid cartela number (1-200).';
                          audioPlayer.play(
                            AssetSource(
                                'audio_recordings/error_sound.mp3'), // Play error sound
                          );
                        }
                        focusNode.requestFocus();
                        setState(() {
                          calculateWinnings();
                        });
                      },
                      decoration:
                          InputDecoration(labelText: 'Cartela Number (1-200)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                    ),
                    ElevatedButton(
                      child: Text('Add Player'),
                      onPressed: () {
                        errorMessage = '';
                        int cartela =
                            int.tryParse(cartelaNumberController.text) ?? 0;
                        if (cartela >= 1 &&
                            cartela <= 100 &&
                            !usedCartelaNumbers.contains(cartela)) {
                          usedCartelaNumbers.add(cartela);
                          savePlayerRecord(PlayerRecord(cartela: cartela));

                          cartelaNumberController.clear();
                        } else if (usedCartelaNumbers.contains(cartela)) {
                          errorMessage =
                              'This cartela number is already in use. Please choose another. ይህ ካርቴላ ተይዟል';
                          audioPlayer.play(
                            AssetSource(
                                'audio_recordings/error_sound.mp3'), // Play error sound
                          );
                        } else {
                          errorMessage =
                              'Please enter a valid cartela number (1-200).';
                          audioPlayer.play(
                            AssetSource(
                                'audio_recordings/error_sound.mp3'), // Play error sound
                          );
                        }
                        focusNode.requestFocus();
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: playerRecords.length,
                        itemBuilder: (context, index) {
                          final player =
                              playerRecords[playerRecords.length - 1 - index];
                          return ListTile(
                            title: Text(
                              'Cartela: ${player.cartela}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Player'),
                                    content: Text(
                                        'Are you sure you want to delete this player?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          _deletePlayerRecord(player);
                                          Navigator.of(context).pop();
                                          setState(
                                              () {}); // Refresh the dialog to update the player list
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 181, 197, 36)),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showPlayersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              '${DateTime.now().toString().substring(0, 19)}.$playerCount.${DateTime.now().toString().substring(20, 25)}',
              style: TextStyle(fontSize: 16)),
          content: showplayers(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget showplayers() {
    return SizedBox(
      width: 400,
      height: 600,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: 200,
        itemBuilder: (BuildContext context, int index) {
          final cartelaNumber = index + 1;
          final isSelected = usedCartelaNumbers.contains(cartelaNumber);

          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  cartelaNumber.toString(),
                  style: const TextStyle(
                    fontSize: 20.0, // Decreased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCheckBoard() {
    TextEditingController controller = TextEditingController();
    ValueNotifier<int?> enteredNumber = ValueNotifier<int?>(null);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 350,
            height: 630,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Enter a number (1-200)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    int? number = int.tryParse(value);
                    if (number != null && number >= 1 && number <= 200) {
                      enteredNumber.value = number;
                    } else {
                      enteredNumber.value = null;
                    }
                  },
                ),
                SizedBox(height: 20),
                ValueListenableBuilder<int?>(
                  valueListenable: enteredNumber,
                  builder: (context, number, child) {
                    if (number == null) {
                      return Text(
                        'Enter a valid number to display the board',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      );
                    }

                    if (!usedCartelaNumbers.contains(number)) {
                      return Text(
                        'Cartela Number was not Selected',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      );
                    }

                    return CustomBoard(
                      key: ValueKey(number),
                      calledNumberss: calledNumbers,
                      number: number,
                      currentPattern: currentPattern,
                      lastCalledNumber: lastCalledNumber ?? 0,
                      requiredLines: isTwoLineMode ? 2 : 1,
                      luckyNumbers: luckyNumbersKey.currentState
                              ?.getCurrentLuckyNumbers() ??
                          {},
                      onBonusWin: (luckyNumber) {
                        if (!hasSavedBonusForCurrentGame) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              bonusDeduction = int.parse(bonusController);
                              hasSavedBonusForCurrentGame = true;
                            });

                            String formattedDate =
                                DateFormat('yyyy-MM-dd – T hh:mm a')
                                    .format(DateTime.now());

                            final bonusRecord = GameRecord(
                                name: 'Game $gameCount',
                                date: formattedDate,
                                calledNumbers: calledNumbers.toList(),
                                playerCount: playerCount,
                                pay: enteredPrice.isNotEmpty
                                    ? double.parse(enteredPrice)
                                    : 0,
                                winnings: winningsController.text.isNotEmpty
                                    ? double.parse(winningsController.text)
                                    : 0,
                                wonWithLuckyNumber: true,
                                bonusAmount: bonusDeduction);

                            _saveToAdminStorage(bonusRecord);
                            _saveToSuperAdminStorage(bonusRecord);
                          });
                        }
                      },
                      onBingoCheck: (isWinner) {},
                      bonusAmount: bonusController,
                      initialLockState: lockedCartelas.contains(number),
                      onLock: () {
                        setState(() {
                          lockedCartelas.add(number);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ValueListenableBuilder<int?>(
              valueListenable: enteredNumber,
              builder: (context, number, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (number != null)
                      // IconButton(
                      //   icon: Icon(
                      //     lockedCartelas.contains(number)
                      //         ? Icons.lock
                      //         : Icons.lock_open,
                      //     color: lockedCartelas.contains(number)
                      //         ? Colors.red
                      //         : Colors.blue,
                      //   ),
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: Icon(
                          lockedCartelas.contains(number)
                              ? Icons.lock
                              : Icons.lock_open,
                          color: lockedCartelas.contains(number)
                              ? Colors.red
                              : Colors.blue,
                        ),
                        onPressed: () {
                          String currentNumber = controller.text;
                          int currentValue = int.parse(currentNumber);

                          setState(() {
                            if (lockedCartelas.contains(number)) {
                              lockedCartelas.remove(number);
                            } else {
                              lockedCartelas.add(number);
                            }
                          });

                          Navigator.of(context).pop();

                          // Create new dialog with pre-populated values
                          TextEditingController newController =
                              TextEditingController(text: currentNumber);
                          ValueNotifier<int?> newEnteredNumber =
                              ValueNotifier<int?>(currentValue);
                          _showCheckBoard();

                          // Set the values after dialog is shown
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            newController.text = currentNumber;
                            newEnteredNumber.value = currentValue;
                          });
                        },
                      ),
                    TextButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveToAdminStorage(GameRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    gameRecords.add(record);
    final String encodedRecords =
        json.encode(gameRecords.map((record) => record.toJson()).toList());
    await prefs.setString('gameRecords', encodedRecords);
    await prefs.setInt('gameCount', gameCount);
  }

  Future<void> _saveToSuperAdminStorage(GameRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> superGameRecords = [];
    String? encodedSuperRecords = prefs.getString('superGameRecords');
    if (encodedSuperRecords != null) {
      superGameRecords =
          List<Map<String, dynamic>>.from(json.decode(encodedSuperRecords));
    }
    superGameRecords.add(record.toJson());
    await prefs.setString('superGameRecords', json.encode(superGameRecords));
  }

  void _deletePlayerRecord(PlayerRecord player) {
    final index = playerRecords.indexOf(player);
    if (index != -1) {
      playerCount--;
      usedCartelaNumbers.remove(player.cartela);
      playerRecords.removeAt(index);
      calculateWinnings();
      setState(() {});
    }
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      if (!isGameInProgress) {
        _startGame();
      } else if (isAutomaticMode) {
        _toggleAutoCalling();
      }
    } else if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      if (isGameInProgress) {
        _resetGame();
      }
    }
  }

  void _showMaxGamesReachedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Maximum Games Reached "የጨዋታዉ ገደብ አልቋል"'),
          content: Text(
              'Sorry, you are not able to play more games. Please contact the Super Admin for assistance with starting a new game."ጨዋታውን ለማስቀጠል እባክዎ ሀላፊዎችን ያነጋግሩ"'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showGameLimitWarningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Limit Warning ማስጠንቀቅያ!!'),
          content: Text(
              'You are approaching the maximum game limit. Please contact the Super Admin soon for assistance. "ጨዋታዉ የሚቋረጥበት ጊዜ እየደረሰ ስለሆነ እባክዎ ቀድመው ለሀላፊዎች  ያሳውቁ"'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMaxProfitReachedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Maximum Profit Reached "የትርፍ መጠኑ ሞልቷል"'),
          content: Text(
              'Sorry, you have reached the maximum profit limit. Please contact the Super Admin for assistance."እባክዎ ሀላፊዎችን ያነጋግሩ"'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showProfitLimitWarningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profit Limit Warning ማስጠንቀቅያ!!'),
          content: Text(
              'You are approaching the maximum profit limit. Please contact the Super Admin soon for assistance. "የትርፍ መጠኑ እየደረሰ ስለሆነ እባክዎ ቀድመው ለሀላፊዎች ያሳውቁ"'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double calculatedWinnings = 0;
  double getAutomaticPercentage() {
    if (playerCount <= 20) return 20;
    if (playerCount <= 35) return 25;
    if (playerCount <= 46) return 30;
    if (playerCount <= 59) return 35;
    return 40;
  }

  void calculateWinnings() {
    if (enteredPrice.isNotEmpty && playerCount >= 1) {
      double pay = double.parse(enteredPrice);
      double totalPot = pay * playerCount;
      double percentage = isAutomaticPercentage
          ? getAutomaticPercentage()
          : winningsPercentageMap[selectedWinningsPercentage]!;
      double winnings = totalPot * (percentage / 100);
      calculatedWinnings = totalPot - winnings;
    } else {
      calculatedWinnings = 0;
    }
  }

  void _changeBonusSelection(int direction) {
    if (!isGameInProgress) {
      List<String> options = winningsPercentageMap.keys.toList();
      int currentIndex = options.indexOf(selectedWinningsPercentage);
      int newIndex = (currentIndex + direction) % options.length;
      if (newIndex < 0) newIndex = options.length - 1;
      setState(() {
        selectedWinningsPercentage = options[newIndex];
        winningsPercentage = winningsPercentageMap[selectedWinningsPercentage]!;
        calculateWinnings();
      });
    }
  }
}
