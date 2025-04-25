import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'death_screen.dart';
import 'win_screen.dart';
import 'game_widgets.dart';
import 'database.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HangMeow extends StatefulWidget {
  final int startLevel;

  HangMeow({required this.startLevel});

  @override
  _HangMeowState createState() => _HangMeowState();
}

class _HangMeowState extends State<HangMeow> {
  late GameDatabase db;
  late List<Map<String, String>> gameData;
  late String word;
  late String hint;
  late String trivia;
  int currentLevel = 0;
  List<String> guessedLetters = [];
  int maxWrong = 6;
  int wrongGuesses = 0;

  Timer? countdownTimer;
  int remainingSeconds = 60;
  bool isTimerActive = false;

  @override
  void initState() {
    super.initState();
    db = GameDatabase();
    gameData = db.gameData;
    currentLevel = widget.startLevel;
    loadLevel();
  }

  void loadLevel() {
    word = gameData[currentLevel]['word']!;
    hint = gameData[currentLevel]['hint']!;
    trivia = gameData[currentLevel]['trivia']!;
    guessedLetters.clear();
    wrongGuesses = 0;
    stopTimer();

    int wordCount = word.trim().split(RegExp(r'\s+')).length;
    int lettersToReveal = 1;
    if (wordCount == 3) {
      lettersToReveal = 2;
    } else if (wordCount == 4) {
      lettersToReveal = 3;
    } else if (wordCount >= 5) {
      lettersToReveal = 4;
    }

    List<String> uniqueLetters = word
        .toUpperCase()
        .replaceAll(' ', '')
        .split('')
        .toSet()
        .toList();

    uniqueLetters.shuffle(Random());
    guessedLetters.addAll(uniqueLetters.take(lettersToReveal));

    if (currentLevel >= 5) {
      startTimer();
    }
  }

  void startTimer() {
    if (currentLevel >= 15) {
      remainingSeconds = 30;
    } else if (currentLevel >= 10) {
      remainingSeconds = 40;
    } else if (currentLevel >= 5) {
      remainingSeconds = 60;
    } else {
      remainingSeconds = 0;
    }

    if (remainingSeconds > 0) {
      isTimerActive = true;
      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            timer.cancel();
            isTimerActive = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DeathScreen()),
            );
          }
        });
      });
    }
  }

  void stopTimer() {
    countdownTimer?.cancel();
    isTimerActive = false;
  }

  void guessLetter(String letter) {
    letter = letter.toUpperCase();
    if (guessedLetters.contains(letter)) return;

    setState(() {
      if (!word.toUpperCase().contains(letter)) {
        wrongGuesses++;
      }
      guessedLetters.add(letter);

      if (wrongGuesses >= maxWrong) {
        stopTimer();
        Future.delayed(Duration(milliseconds: 300), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeathScreen()),
          );
        });
      }

      if (isGameWon()) {
        stopTimer();
        unlockNextLevel(currentLevel);

        if (currentLevel == gameData.length - 1) {
          Future.delayed(Duration(milliseconds: 800), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WinScreen()),
            );
          });
        } else {
          _showTriviaDialog();
        }
      }
    });
  }

  bool isGameWon() {
    for (var char in word.split('')) {
      if (char != ' ' && !guessedLetters.contains(char.toUpperCase())) {
        return false;
      }
    }
    return true;
  }

  void _showTriviaDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Trivia 🧠",
        style: TextStyle(fontSize: 24, fontFamily: "LuckiestGuy")),
        content: Text(trivia),
        actions: [
          TextButton(
            onPressed: () async {
              bool confirmed = await _showBackConfirmation(context);
              if (confirmed) {
                Navigator.of(context).pop(); // Close trivia dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainApp()),
                  (route) => false,
                );
              }
            },
            child: Text("Back", style: TextStyle(color: Colors.blue.shade700),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              nextLevel();
            },
            child: Text("Next Level", style: TextStyle(color: Colors.blue.shade700),),
          ),
        ],
      ),
    );
  }

  void nextLevel() {
    if (currentLevel < gameData.length - 1) {
      setState(() {
        currentLevel++;
        loadLevel();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WinScreen()),
      );
    }
  }

  Future<void> unlockNextLevel(int currentLevel) async {
    final prefs = await SharedPreferences.getInstance();
    int unlockedLevel = prefs.getInt('unlockedLevel') ?? 0;

    if (currentLevel == unlockedLevel) {
      await prefs.setInt('unlockedLevel', unlockedLevel + 1);
      print("Unlocked level updated to: ${unlockedLevel + 1}");
    } else {
      print("Level already unlocked or skipped");
    }
  }

  Future<bool> _showBackConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Return To Main Menu?"),
            content: Text("If you go back now, your progress will be saved. Are you sure?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            bool goBack = await _showBackConfirmation(context);
            if (goBack) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainApp()),
                (route) => false,
              );
            }
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool goBack = await _showBackConfirmation(context);
          if (goBack) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainApp()),
              (route) => false,
            );
            return false;
          }
          return false;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center( // This centers the container
              child: Container(
                width: double.infinity,
                height: isSmallScreen ? constraints.maxHeight : null,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                constraints: BoxConstraints(
                  maxWidth: isSmallScreen ? double.infinity : 700, // limit on web
                  maxHeight: isSmallScreen ? double.infinity : 600, // limit on web
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 32,
                  vertical: isSmallScreen ? 24 : 32,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 800),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "HANGMEOW",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 28 : 32,
                              color: Colors.white,
                              fontFamily: "LuckiestGuy",
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 20 : 16),
                          Text(
                            "Level: ${currentLevel + 1}",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 20 : 16),
                          Text(
                            "Hint: $hint",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.white60,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 24 : 20),
                          buildWord(word, guessedLetters, context),
                          SizedBox(height: isSmallScreen ? 24 : 20),
                          buildStatus(wrongGuesses, maxWrong),
                          SizedBox(height: isSmallScreen ? 24 : 20),
                          buildTimer(currentLevel, remainingSeconds),
                          SizedBox(height: isSmallScreen ? 24 : 20),
                          buildKeyboard(
                            guessedLetters,
                            wrongGuesses,
                            maxWrong,
                            isGameWon(),
                            guessLetter,
                            context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
