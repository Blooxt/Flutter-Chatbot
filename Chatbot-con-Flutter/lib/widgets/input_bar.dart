import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool loading;
  const InputBar({super.key, required this.controller, required this.onSend, required this.loading});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => !loading ? onSend() : null,
                decoration: InputDecoration(
                  hintText: 'Escribe tu pregunta...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                enabled: !loading,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: loading ? null : onSend,
              icon: loading ? const CircularProgressIndicator() : const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}