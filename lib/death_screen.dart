import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart'; // Make sure MainApp is defined in main.dart

class DeathScreen extends StatefulWidget {
  @override
  _DeathScreenState createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> {
  int currentImageIndex = 0;
  late Timer _timer;

  final List<String> imageList = [
    'assets/neutral.png', // Make sure your assets path is correct in pubspec.yaml
    'assets/sad.png',
    'assets/teardrop.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % imageList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Game Over'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Image.asset(
                    imageList[currentImageIndex],
                    key: ValueKey<int>(currentImageIndex),
                    height: isPortrait ? screenHeight * 0.35 : screenHeight * 0.6,
                    width: screenWidth * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'You Lose!\nTry Again!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainApp()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.15,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
