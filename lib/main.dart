import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vazifa40/ember_quest.dart';
import 'package:vazifa40/overlays/next_level.dart';

import 'overlays/overlays.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientations to landscape only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(
    GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
      overlayBuilderMap: {
        'MainMenu': (context, game) => MainMenu(game: game),
        'GameOver': (context, game) => GameOver(game: game),
        'GameControls': (context, game) => GameControls(game: game),
        'NextLevel': (context, game) => NextLevelOverlay(game: game),
      },
      initialActiveOverlays: const ['MainMenu', 'GameControls'],
    ),
  );
}
