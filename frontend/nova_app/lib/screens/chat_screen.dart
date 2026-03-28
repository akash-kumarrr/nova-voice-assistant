import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/chat_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/nova_orb.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/status_chip.dart';
import '../widgets/nova_background.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const NovaBackground(),
          SafeArea(
            child: Column(
              children: [
                _Header(),
                _OrbSection(),
                Expanded(child: _MessageList(scrollCtrl: _scrollCtrl)),
                Consumer<ChatProvider>(
                  builder: (_, prov, __) {
                    // Auto-scroll when messages change
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _scrollToBottom());
                    return ChatInputBar(
                      isBusy: prov.isBusy,
                      onSend: prov.sendMessage,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NOVA', style: AppTextStyles.displayLarge),
              Text(
                'Voice Assistant',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.violetLight, fontSize: 11, letterSpacing: 0.5),
              ),
            ],
          ),
          const Spacer(),
          Consumer<ChatProvider>(
            builder: (_, prov, __) => StatusChip(state: prov.state),
          ),
          const SizedBox(width: 8),
          _StopButton(),
          const SizedBox(width: 8),
          _ClearButton(),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.2, curve: Curves.easeOut);
  }
}

class _StopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<ChatProvider>().stopSpeaking,
      child: Tooltip(
        message: 'Stop speaking',
        child: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.stop_rounded,
              color: AppColors.textMuted, size: 18),
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<ChatProvider>().clearMessages,
      child: Tooltip(
        message: 'Clear chat',
        child: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.delete_outline_rounded,
              color: AppColors.textMuted, size: 18),
        ),
      ),
    );
  }
}

class _OrbSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Consumer<ChatProvider>(
        builder: (_, prov, __) => NovaOrb(
          isSpeaking: prov.isSpeaking,
          isThinking: prov.isThinking,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack);
  }
}

class _MessageList extends StatelessWidget {
  final ScrollController scrollCtrl;

  const _MessageList({required this.scrollCtrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (_, prov, __) {
        final msgs = prov.messages;
        if (msgs.isEmpty) {
          return Center(
            child: Text(
              'Start a conversation...',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textDim),
            ),
          );
        }
        return ListView.builder(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          itemCount: msgs.length,
          itemBuilder: (_, i) => ChatBubble(message: msgs[i])
              .animate()
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.12, curve: Curves.easeOut),
        );
      },
    );
  }
}
