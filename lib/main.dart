import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

void main() {
  runApp(GameWidget(game: Game()));
}

class Game extends FlameGame {
  late Sprite logSprite;
  late SpriteAnimation logAnimation;

  @override
  Future<void> onLoad() async {
    final logImage = await images.load('log.png');
    logSprite = Sprite(
      logImage,
      srcPosition: Vector2(0.0, 0),
      srcSize: Vector2(32.0, 32.0),
    );
  }

  @override
  void render(Canvas c) {
    super.render(c);

    // @todo continuar daqui https://docs.flame-engine.org/1.5.0/flame/rendering/images.html
    logSprite.render(c);
  }
}
