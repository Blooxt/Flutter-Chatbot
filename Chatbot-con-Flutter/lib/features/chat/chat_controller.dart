import 'package:flutter/material.dart';
import '../../models.dart';
import 'chat_repository.dart';

class ChatController extends ChangeNotifier {
  final ChatRepository repository;

  List<Message> messages = [];
  bool loading = false;
  String? error;


  ChatController({ required this.repository});

  void setError (String? e) {
    error = e;
    notifyListeners();
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty || loading) return;
    final userMsg = Message(role: Role.user, content: text.trim());
    messages.add(userMsg);
    loading = true;
    error = null;
    notifyListeners();

    try {
      final answer = await repository.ask(text.trim(), messages);
      final botMsg = Message(role: Role.assistant, content: answer);
      messages.add(botMsg);
    } catch (e) {
      setError(e.toString());
      messages.add(Message(role: Role.assistant, content: "Error: no se pudo obtener respuesta."));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}