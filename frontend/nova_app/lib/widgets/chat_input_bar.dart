import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ChatInputBar extends StatefulWidget {
  final bool isBusy;
  final ValueChanged<String> onSend;

  const ChatInputBar({
    super.key,
    required this.isBusy,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _ctrl = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      final has = _ctrl.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _ctrl.text.trim();
    if (text.isEmpty || widget.isBusy) return;
    widget.onSend(text);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bg.withOpacity(0),
            AppColors.bg,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.violet.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.keyboard_alt_outlined,
                      color: AppColors.textDim, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      onSubmitted: (_) => _submit(),
                      textInputAction: TextInputAction.send,
                      style: AppTextStyles.body
                          .copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Ask Nova anything...',
                        hintStyle: AppTextStyles.hint,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          _SendButton(
            active: _hasText && !widget.isBusy,
            isBusy: widget.isBusy,
            onTap: _submit,
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool active;
  final bool isBusy;
  final VoidCallback onTap;

  const _SendButton({
    required this.active,
    required this.isBusy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: active
              ? const LinearGradient(
                  colors: [AppColors.violetLight, AppColors.violetDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    AppColors.border2,
                    AppColors.border,
                  ],
                ),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColors.violet.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: isBusy
              ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

