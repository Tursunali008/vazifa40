import 'package:flutter/material.dart';

import '../ember_quest.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          width: 280,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ember Quest',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  game.overlays.remove('MainMenu');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(323, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '''WASD or Arrow Keys: Move
Space: Jump
Collect stars, avoid enemies!''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
