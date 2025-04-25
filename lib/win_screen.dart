import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hangmeow/levelSelect.dart';
import 'package:hangmeow/main.dart';

class WinScreen extends StatefulWidget {
  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  int _currentImageIndex = 0;

  final List<String> _imagePaths = [
    'assets/neutral.png',
    'assets/happy.png',
    'assets/joy.png',
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startImageAnimation();
  }

  void _startImageAnimation() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = MediaQuery.of(context).size;
    final isWeb =
        size.width > 600; // Adjust based on the breakpoint you want for web


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/joyous.png'),
            fit: BoxFit.cover,
            alignment: Alignment(0, -0.7),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    "You've completed all the levels! 🎉",
                    style: TextStyle(
                      fontSize: isPortrait ? screenWidth * 0.07 : screenHeight * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "LuckiestGuy",
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Image.asset(
                      _imagePaths[_currentImageIndex],
                      key: ValueKey<int>(_currentImageIndex),
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandingPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: isWeb ? size.width * 0.3 : size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 30,
                                color: Colors.white,
                              ), // Reduced icon size
                              const SizedBox(
                                width: 6,
                              ), // Reduced spacing between icon and text
                              Text(
                                "Home",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
