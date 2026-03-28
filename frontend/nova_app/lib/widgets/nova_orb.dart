import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';

class NovaOrb extends StatefulWidget {
  final bool isSpeaking;
  final bool isThinking;

  const NovaOrb({
    super.key,
    required this.isSpeaking,
    required this.isThinking,
  });

  @override
  State<NovaOrb> createState() => _NovaOrbState();
}

class _NovaOrbState extends State<NovaOrb> with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _rotate;
  late final AnimationController _wave;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse  = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);
    _rotate = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _wave   = AnimationController(vsync: this, duration: const Duration(milliseconds: 550))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.08)
        .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    _rotate.dispose();
    _wave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnim, _rotate, _wave]),
      builder: (context, _) {
        final scale = (widget.isSpeaking || widget.isThinking) ? _pulseAnim.value : 1.0;
        return Transform.scale(
          scale: scale,
          child: SizedBox(
            width: AppConstants.orbSize + 40,
            height: AppConstants.orbSize + 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ripple rings when active
                if (widget.isSpeaking || widget.isThinking)
                  ...List.generate(3, (i) {
                    final progress = (_pulse.value + i * 0.33) % 1.0;
                    return Opacity(
                      opacity: (1 - progress) * 0.3,
                      child: Container(
                        width: AppConstants.orbSize + (progress * 70),
                        height: AppConstants.orbSize + (progress * 70),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.violet,
                            width: 1.2,
                          ),
                        ),
                      ),
                    );
                  }),

                // Rotating gradient sweep
                Transform.rotate(
                  angle: _rotate.value * 2 * pi,
                  child: Container(
                    width: AppConstants.orbSize + 10,
                    height: AppConstants.orbSize + 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.violet.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Core
                Container(
                  width: AppConstants.orbSize - 4,
                  height: AppConstants.orbSize - 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(-0.3, -0.3),
                      colors: [
                        AppColors.violetLight,
                        AppColors.violetDark,
                        AppColors.violetDeep,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.violet.withOpacity(
                            widget.isSpeaking ? 0.7 : 0.28),
                        blurRadius: widget.isSpeaking ? 36 : 18,
                        spreadRadius: widget.isSpeaking ? 4 : 0,
                      ),
                    ],
                  ),
                  child: Center(child: _buildContent()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    if (widget.isThinking) {
      return const SizedBox(
        width: 28, height: 28,
        child: CircularProgressIndicator(
          color: Colors.white, strokeWidth: 2.5,
        ),
      );
    }
    if (widget.isSpeaking) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (i) {
          final h = 8.0 +
              (sin((_wave.value * pi * 2) + (i * 0.9)) + 1) * 10;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            width: 4,
            height: h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      );
    }
    return Text(
      'N',
      style: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: -1,
      ),
    );
  }
}
