import 'package:flutter/material.dart';
import 'package:hangmeow/aboutUs.dart';
import 'package:hangmeow/levelSelect.dart';
import 'package:hangmeow/main.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 16, // Adjusted spacing between rows
            crossAxisSpacing: 16, // Adjusted spacing between columns
            children: [
              _buildMenuButton(
                context,
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
              ),
              _buildMenuButton(
                context,
                // make the icon more appropriate
                icon: Icons.play_circle_fill,
                label: 'Levels',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LevelSelect()),
                  );
                },
              ),
              _buildMenuButton(
                context,
                icon: Icons.bookmark,
                label: 'About Us',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingMenuButton(onPressed: () => _openMenu(context));
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(12), // Slightly smaller border radius
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Reduced padding inside buttons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white), // Reduced icon size
              const SizedBox(height: 6), // Reduced spacing between icon and text
              Text(
                label,
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
    );
  }
}

class FloatingMenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingMenuButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue.shade700,
      child: const Icon(Icons.menu, color: Colors.white),
    );
  }
}