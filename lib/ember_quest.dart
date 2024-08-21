import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'actors/actors.dart';
import 'managers/segment_manager.dart';
import 'objects/objects.dart';
import 'overlays/overlays.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  double objectSpeed = 0.0;
  late EmberPlayer _ember;
  int starsCollected = 0;
  int health = 3;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.add(Hud());
    initializeGame(true);
  }

  void initializeGame(bool loadHud) {
    // Ekran segmentlarini yuklash
    final segmentsToLoad = (size.x / 320).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (320 * i).toDouble());
    }

    // O'yinchini boshlang'ich pozitsiyaga qo'shish
    _ember = EmberPlayer(
      position: Vector2(64, canvasSize.y - 128),
    );
    add(_ember);
    if (loadHud) {
      add(Hud());
    }
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    int lastGroundBlockX = -4; // Initialize with an out-of-bounds value

    for (final block in segments[segmentIndex]) {
      if (block.blockType is GroundBlock) {
        final gridX = block.gridPosition.x.toInt();
        if (gridX - lastGroundBlockX > 3) {
          // Fill the gap if it's greater than 3 units
          for (int i = lastGroundBlockX + 1; i < gridX; i++) {
            world.add(
              GroundBlock(
                gridPosition: Vector2(i.toDouble(), block.gridPosition.y),
                xOffset: xPositionOffset,
              ),
            );
          }
        }
        lastGroundBlockX = gridX;
      }

      // Now, proceed with adding the block as usual
      switch (block.blockType) {
        case const (GroundBlock):
          world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case const (PlatformBlock):
          add(
            PlatformBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case const (Star):
          world.add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case const (WaterEnemy):
          world.add(
            WaterEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
      }
    }
  }

  void reset() {
    // O'yinni qayta boshlash uchun reset funksiyasi
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

  void movePlayer(Direction direction) {
    // O'yinchini harakatlantirish uchun funksiyalar
    switch (direction) {
      case Direction.left:
        _ember.horizontalDirection = -1;
        break;
      case Direction.right:
        _ember.horizontalDirection = 1;
        break;
      case Direction.none:
        break;
    }
  }

  void jumpPlayer() {
    // O'yinchini sakratish funksiyasi
    _ember.hasJumped = true;
  }

  void stopPlayer() {
    // O'yinchini to'xtatish funksiyasi
    _ember.horizontalDirection = 0;
  }

  @override
  Color backgroundColor() {
    // O'yin fon rangi
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void update(double dt) {
    // Har bir yangilanishda o'yinni yangilash
    if (health <= 0) {
      overlays.add('GameOver');
    }
    super.update(dt);
  }
}
