import 'package:dio/dio.dart';
import '../../core/api_client.dart';
import '../../models.dart';

class   ChatRepository {
  final ApiClient apiClient;
  ChatRepository({ required this.apiClient});

  Future<String> ask(String message, List<Message> histoty) async {
    final body = {
      "message": message,
      "histoty": histoty.map((m) => m.toJson()).toList(),
    };

    try {
      final resp = await apiClient.post('/chat', body);

      if (resp.statusCode == 200) {
        final data = resp.data;
        if (data is Map<String, dynamic> && data.containsKey('answer')) {
          return data['answer'].toString();
        } else if (data is String) {
          return data;
        } else {
          throw Exception('Respuesta inesperada del servidor');
        }
      } else {
        throw Exception('Codigo HTTP: ${resp.statusCode}');
      }
    }on DioException catch (e) {
      throw Exception(e.stackTrace);
    }
  }

  Future<bool> health() async {
    try {
      final resp = await apiClient.get('/health');
      return resp.statusCode == 200;
    } catch(_) {
      return false;
    }
  }
}
