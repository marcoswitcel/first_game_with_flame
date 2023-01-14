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

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (!isKeyDown) return KeyEventResult.handled;

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      currentLogAnimation = walkDownAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      currentLogAnimation = walkUpAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      currentLogAnimation = walkRightAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      currentLogAnimation = walkLeftAnimation;
    }

    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
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
    currentLogAnimation.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);

    // @todo continuar daqui https://docs.flame-engine.org/1.5.0/flame/rendering/images.html
    //logSprite.render(c);
    currentLogAnimation.getSprite().render(c);
  }
}
