import 'package:flutter/material.dart';
import 'package:hangmeow/main_menu.dart';
import 'hangmeow.dart';
import 'levelSelect.dart';
import 'aboutUs.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(200, 50),
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    elevation: 5,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/game': (context) => HangMeow(startLevel: 0),
        '/levels': (context) => LevelSelect(),
        '/about': (context) => AboutUs(),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb =
        size.width > 600; // Adjust based on the breakpoint you want for web

    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(
        isWeb ? size.width * 0.3 : size.width * 0.5,
        50,
      ), // Adjust width for web
      backgroundColor: Colors.blue.shade700,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      elevation: 5,
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset('assets/plant3.png', fit: BoxFit.cover),
            ),
            // Foreground content
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'HANGMEOW',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontFamily: "LuckiestGuy",
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(3, 3),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LevelSelect(),
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
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.white,
                              ), // Reduced icon size
                              const SizedBox(
                                width: 6,
                              ), // Reduced spacing between icon and text
                              Text(
                                "Play Game",
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
          ],
        ),
      ),
      floatingActionButton: MainMenu(),
    );
  }
}
