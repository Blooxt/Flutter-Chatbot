import 'package:flutter/material.dart';
import '../models.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({ super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == Role.user;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bg = isUser ? Colors.blueAccent : Colors.grey.shade200;
    final textColor = isUser ? Colors.white : Colors.black87;
    final radius = isUser
    ? const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12))
    : const BorderRadius.only( topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12));

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
          decoration: BoxDecoration(color: bg, borderRadius: radius),
          child: SelectableText(message.content, style: TextStyle(color: textColor),
          ),
        )
      ],
    );
  }
}