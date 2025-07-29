import 'package:flutter/material.dart';

class KBlurryTabIndicatorDecoration extends Decoration {
  final Color color;
  final double height;

  const KBlurryTabIndicatorDecoration({required this.color, this.height = 3.0});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BlurryPainter(this, color, height);
  }
}

class _BlurryPainter extends BoxPainter {
  final KBlurryTabIndicatorDecoration decoration;
  final Color color;
  final double height;

  _BlurryPainter(this.decoration, this.color, this.height);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              color.withOpacity(0.0),
              color.withOpacity(0.8),
              color,
              color.withOpacity(0.8),
              color.withOpacity(0.0),
            ],
            stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
          ).createShader(
            Rect.fromLTWH(
              offset.dx,
              offset.dy + configuration.size!.height - height,
              configuration.size!.width,
              height,
            ),
          );

    final indicatorRect = Rect.fromLTWH(
      offset.dx,
      offset.dy + configuration.size!.height - height,
      configuration.size!.width,
      height,
    );

    canvas.drawRect(indicatorRect, paint);
  }
}
