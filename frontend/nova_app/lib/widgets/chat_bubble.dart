import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.only(
        top: 5, bottom: 5,
        left: isUser ? 56 : 0,
        right: isUser ? 0 : 56,
      ),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[_NovaAvatar(), const SizedBox(width: 8)],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [AppColors.violetLight, AppColors.violetDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isUser ? null : AppColors.surface2,
                borderRadius: BorderRadius.only(
                  topLeft:     const Radius.circular(18),
                  topRight:    const Radius.circular(18),
                  bottomLeft:  Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: isUser
                    ? null
                    : Border.all(color: AppColors.border2, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: isUser
                        ? AppColors.violet.withOpacity(0.25)
                        : Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _buildContent(isUser),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isUser) {
    if (message.isLoading) return const _LoadingDots();

    if (message.isError) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.pink, size: 15),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              message.text,
              style: AppTextStyles.body.copyWith(color: AppColors.pink),
            ),
          ),
        ],
      );
    }

    return Text(
      message.text,
      style: AppTextStyles.body.copyWith(
        color: isUser ? Colors.white : AppColors.textSecondary,
      ),
    );
  }
}

class _NovaAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.violetLight, AppColors.violetDark],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.violet.withOpacity(0.4),
              blurRadius: 8,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'N',
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white,
            ),
          ),
        ),
      );
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final offset = ((_ctrl.value * 3) - i).clamp(0.0, 1.0);
          final opacity = offset < 0.5 ? offset * 2 : (1 - offset) * 2;
          return Opacity(
            opacity: 0.3 + opacity * 0.7,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 7, height: 7,
              decoration: const BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
