import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: Game()));
}

class Game extends FlameGame with KeyboardEvents {
  late Sprite logSprite;
  late SpriteAnimation currentLogAnimation;

  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkRightAnimation;
  late SpriteAnimation walkLeftAnimation;

  late Vector2 position;

  final Map<LogicalKeyboardKey, bool> keysState = HashMap();

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    assert(event is RawKeyDownEvent || event is RawKeyUpEvent,
        'Evento é sempre de um desses dois tipos');

    keysState[LogicalKeyboardKey.arrowDown] =
        keysPressed.contains(LogicalKeyboardKey.arrowDown);
    keysState[LogicalKeyboardKey.arrowUp] =
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    keysState[LogicalKeyboardKey.arrowRight] =
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    keysState[LogicalKeyboardKey.arrowLeft] =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
    position = Vector2.all(0.0);

    final logImage = await images.load('log.png');
    logSprite = Sprite(
      logImage,
      srcPosition: Vector2(0.0, 0),
      srcSize: Vector2(32.0, 32.0),
    );

    final spriteSheet =
        SpriteSheet(image: logImage, srcSize: Vector2.all(32.0));

    walkDownAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: 0.1, loop: true, from: 0, to: 4);
    walkUpAnimation = spriteSheet.createAnimation(
        row: 1, stepTime: 0.1, loop: true, from: 0, to: 4);
    walkRightAnimation = spriteSheet.createAnimation(
        row: 2, stepTime: 0.1, loop: true, from: 0, to: 4);
    walkLeftAnimation = spriteSheet.createAnimation(
        row: 3, stepTime: 0.1, loop: true, from: 0, to: 4);

    currentLogAnimation = walkDownAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    inputProcessing();
    currentLogAnimation.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);

    // @todo continuar daqui https://docs.flame-engine.org/1.5.0/flame/rendering/images.html
    //logSprite.render(c);
    currentLogAnimation
        .getSprite()
        .render(c, position: position, size: Vector2.all(128.0));
  }

  void inputProcessing() {
    if (keysState[LogicalKeyboardKey.arrowDown] == true) {
      currentLogAnimation = walkDownAnimation;
      position.add(Vector2(0, 1));
    }
    if (keysState[LogicalKeyboardKey.arrowUp] == true) {
      currentLogAnimation = walkUpAnimation;
      position.add(Vector2(0, -1));
    }
    if (keysState[LogicalKeyboardKey.arrowRight] == true) {
      currentLogAnimation = walkRightAnimation;
      position.add(Vector2(1, 0));
    }
    if (keysState[LogicalKeyboardKey.arrowLeft] == true) {
      currentLogAnimation = walkLeftAnimation;
      position.add(Vector2(-1, 0));
    }
  }
}
