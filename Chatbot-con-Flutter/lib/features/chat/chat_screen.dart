// lib/features/chat/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chat/chat_controller.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/input_bar.dart';
import '../../widgets/typing_indicator.dart';
import '../../models.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  void _send() {
    final controller = context.read<ChatController>();
    final text = _ctrl.text;
    if (text.trim().isEmpty) return;
    controller.send(text);
    _ctrl.clear();
    // Esperar un milisegundo y scrollear
    Future.delayed(const Duration(milliseconds: 200), () {
      _scroll.animateTo(_scroll.position.maxScrollExtent + 120, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(builder: (context, ctrl, _) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chatbot RAG')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                itemCount: ctrl.messages.length + (ctrl.loading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < ctrl.messages.length) {
                    final msg = ctrl.messages[index];
                    return MessageBubble(message: msg);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TypingIndicator(),
                    );
                  }
                },
              ),
            ),
            if (ctrl.error != null)
              Container(
                color: Colors.red.shade100,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(child: Text(ctrl.error ?? 'Error', style: const TextStyle(color: Colors.red))),
                    IconButton(
                        onPressed: () => ctrl.setError(null), icon: const Icon(Icons.close, color: Colors.red))
                  ],
                ),
              ),
            InputBar(controller: _ctrl, onSend: _send, loading: ctrl.loading),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }
}
