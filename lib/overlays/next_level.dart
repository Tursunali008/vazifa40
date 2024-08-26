import 'package:flutter/material.dart';
import '../ember_quest.dart';

class NextLevelOverlay extends StatelessWidget {
  final EmberQuestGame game;

  const NextLevelOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations!'.toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You cleared the level!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('NextLevel');
                game.overlays.add('LevelDetails');
              },
              child: const Text('Start Next Level'),
            ),
          ],
        ),
      ),
    );
  }
}
