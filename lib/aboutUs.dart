import 'package:flutter/material.dart';
import 'package:hangmeow/main_menu.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<bool> _isVisible = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() async {
    for (int i = 0; i < _isVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        _isVisible[i] = true;
      });
    }
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
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.deepPurple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 32,
                vertical: isSmallScreen ? 24 : 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _isVisible[0] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'HANGMEOW',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 32 : 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "LuckiestGuy",
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _isVisible[1] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Created by: \n MELBERT MARAFO \n HERBERT ALEM ACOKING \n JERICK AMIAO \n JERIC COLSIDO',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _isVisible[2] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'HangMeow is a fun and educational Hangman game inspired by the Sustainable Development Goals (SDGs). '
                      'Our mission is to raise awareness about environmental and social issues while providing an engaging gaming experience.',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  AnimatedOpacity(
                    opacity: _isVisible[3] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Thank you for playing!',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: MainMenu(),
    );
  }
}
