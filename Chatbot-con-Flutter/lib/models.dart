enum Role { user, assistant }

class Message {
  final Role role;
  final String content;
  Message({ required this.role, required this.content});

  Map<String, dynamic> toJson() => {
    "role": role == Role.user ? "user" : "assistant",
    "content" : content,
  };


  factory Message.fromJson(Map<String, dynamic> json) {
    final r = (json['role'] as String?) == 'user' ? Role.user : Role.assistant;
    return Message(role: r, content: json['content'] ?? '');
  }
}