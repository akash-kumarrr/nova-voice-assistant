import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NovaBackground extends StatelessWidget {
  const NovaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: _BgPainter()),
    );
  }
}

class _BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawGlow(canvas, Offset.zero, 300,
        AppColors.violetDark.withOpacity(0.18));
    _drawGlow(canvas, Offset(size.width, size.height), 260,
        const Color(0xFF1E3A5F).withOpacity(0.14));
    _drawGlow(canvas, Offset(size.width * 0.5, size.height * 0.4), 200,
        AppColors.violet.withOpacity(0.05));
  }

  void _drawGlow(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
