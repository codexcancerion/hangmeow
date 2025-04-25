import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameScreen(),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final guessedLetters = ['A', 'E', 'O']; // Example
    final word = "HELLO WORLD"; // Example word

    return isMobile
        ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue.shade700,
            child: buildContent(context, word, guessedLetters),
          )
        : buildContent(context, word, guessedLetters);
  }

  Widget buildContent(BuildContext context, String word, List<String> guessedLetters) {
    return SingleChildScrollView(  // Make the entire content scrollable vertically
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildWord(word, guessedLetters, context),  // Word section
          const SizedBox(height: 20),
          buildStatus(2, 6), // Example: 2 wrong out of 6 max
          const SizedBox(height: 20),
          buildTimer(5, 90), // Example: Level 5, 90 seconds left
          const SizedBox(height: 20),
          buildKeyboard(guessedLetters, 2, 6, false, (letter) {
            // Example letter guess handler
            print('Guessed: $letter');
          }, context),  // Keyboard section
        ],
      ),
    );
  }
}

// Your provided UI components:

Widget buildWord(String word, List<String> guessedLetters, BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 600;
  final boxWidth = isMobile ? 14.0 : 20.0;
  final fontSize = isMobile ? 20.0 : 28.0;
  final spaceWidth = isMobile ? 12.0 : 20.0;

  final maxRowWidth = screenWidth * 0.9;
  double currentRowWidth = 0;
  List<Widget> wordWidgets = [];

  word.toUpperCase().split(' ').forEach((wordSegment) {
    double wordWidth = wordSegment.length * boxWidth + (wordSegment.length - 1) * spaceWidth;

    if (currentRowWidth + wordWidth > maxRowWidth) {
      wordWidgets.add(SizedBox(width: double.infinity));
      currentRowWidth = 0;
    }

    wordSegment.split('').forEach((char) {
      final showChar = guessedLetters.contains(char);

      wordWidgets.add(Container(
        width: boxWidth,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: Colors.white)),
        ),
        alignment: Alignment.center,
        child: Text(
          showChar ? char : '',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ));

      currentRowWidth += boxWidth + spaceWidth;
    });

    currentRowWidth += spaceWidth;
    wordWidgets.add(SizedBox(width: spaceWidth));
  });

  return SingleChildScrollView(  // Allow vertical scrolling
    scrollDirection: Axis.vertical,  // Enable vertical scroll
    child: Container(
      constraints: BoxConstraints(
        maxHeight: 300,  // You can adjust this to control the max height
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isMobile ? 4 : 6,
        runSpacing: isMobile ? 6 : 8,
        children: wordWidgets,
      ),
    ),
  );
}

Widget buildKeyboard(
  List<String> guessedLetters,
  int wrongGuesses,
  int maxWrong,
  bool isGameWon,
  Function(String) guessLetter,
  BuildContext context,
) {
  const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 600;

  final rows = isMobile
      ? [
          letters.substring(0, 4),
          letters.substring(4, 8),
          letters.substring(8, 12),
          letters.substring(12, 16),
          letters.substring(16, 20),
          letters.substring(20, 24),
          letters.substring(24, 26),
        ]
      : [
          letters.substring(0, 9),
          letters.substring(9, 18),
          letters.substring(18, 26),
        ];

  final buttonSize = isMobile ? 60.0 : 50.0;

  return SizedBox(
    height: isMobile ? 280 : null,
    child: SingleChildScrollView(
      child: Column(
        children: rows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.split('').map((letter) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed: guessedLetters.contains(letter) ||
                            wrongGuesses >= maxWrong ||
                            isGameWon
                        ? null
                        : () => guessLetter(letter),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 20 : 18,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    ),
  );
}

Widget buildStatus(int wrongGuesses, int maxWrong) {
  if (wrongGuesses >= maxWrong) {
    return const Text(
      "Game Over 😢",
      style: TextStyle(
        fontSize: 24,
        color: Colors.redAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  return Text(
    "Wrong guesses: $wrongGuesses / $maxWrong",
    style: const TextStyle(fontSize: 18, color: Colors.white),
  );
}

Widget buildTimer(int currentLevel, int remainingSeconds) {
  if (currentLevel >= 5) {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return Text(
      "⏳ Time left: $minutes:$seconds",
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
  return const SizedBox.shrink();
}
