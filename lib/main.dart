import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

void main() {
  runApp(GameWidget(game: Game()));
}

class Game extends FlameGame {
  late Sprite logSprite;
  late SpriteAnimation currentLogAnimation;

  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkRightAnimation;
  late SpriteAnimation walkLeftAnimation;

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
