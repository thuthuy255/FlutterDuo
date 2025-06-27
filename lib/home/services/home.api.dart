import 'package:duolingo/services/api_service.dart';

class TopicService {
  static Future<dynamic> getAllTopic() {
    return ApiConfig.get('Topic');
  }
}
