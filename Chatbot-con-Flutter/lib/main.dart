// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api_client.dart';
import 'features/chat/chat_repository.dart';
import 'features/chat/chat_controller.dart';
import 'features/chat/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient();
    final chatRepo = ChatRepository(apiClient: apiClient);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatController(repository: chatRepo),
        ),
      ],
      child: MaterialApp(
        title: 'Chatbot RAG',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ChatScreen(),
      ),
    );
  }
}
