import 'package:flutter/material.dart';
import 'package:hangmeow/main_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hangmeow.dart'; 
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LevelSelect(),
  ));
}

class LevelSelect extends StatefulWidget {
  @override
  _LevelSelectState createState() => _LevelSelectState();
}

class _LevelSelectState extends State<LevelSelect> {
  int unlockedLevel = 0;

  @override
  void initState() {
    super.initState();
    loadUnlockedLevel();
  }

  Future<void> loadUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      unlockedLevel = prefs.getInt('unlockedLevel') ?? 0;
    });
    print("Loaded unlocked level: $unlockedLevel");
  }

  @override
  Widget build(BuildContext context) {
    final gameData = GameDatabase().gameData;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive crossAxisCount based on screen width
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 6;
    } else if (screenWidth > 900) {
      crossAxisCount = 5;
    } else if (screenWidth > 600) {
      crossAxisCount = 4;
    } else if (screenWidth > 400) {
      crossAxisCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Level'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: gameData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, index) {
            bool isUnlocked = index <= unlockedLevel;

            return ElevatedButton(
              onPressed: isUnlocked
                  ? () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HangMeow(startLevel: index),
                        ),
                      );
                      await loadUnlockedLevel(); // Refresh unlocked levels
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isUnlocked ? Colors.blue.shade700 : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'Level ${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: MainMenu(),
    );
  }
}
