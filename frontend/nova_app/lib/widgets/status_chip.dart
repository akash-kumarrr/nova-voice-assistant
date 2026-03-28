import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../providers/chat_provider.dart';

class StatusChip extends StatelessWidget {
  final AssistantState state;

  const StatusChip({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (state) {
      AssistantState.thinking => ('Thinking...', AppColors.amber),
      AssistantState.speaking => ('Speaking',    AppColors.violetLight),
      AssistantState.error    => ('Error',        AppColors.pink),
      _                       => ('Ready',        AppColors.green),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Dot(color: color),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.caption.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl),
      child: Container(
        width: 6, height: 6,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      ),
    );
  }
}
