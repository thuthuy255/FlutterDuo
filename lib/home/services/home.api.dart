import 'package:duolingo/services/api_service.dart';

class TopicService {
  /// Lấy danh sách tất cả các chủ đề
  static Future<dynamic> getAllTopic() {
    return ApiConfig.get('Topic');
  }

  /// Lấy chi tiết bài học bao gồm câu hỏi & câu trả lời từ API `/api/Lesson/detail/{id}`
  static Future<dynamic> getLessonDetail(dynamic lessonId) {
    return ApiConfig.get('Lesson/detail/$lessonId');
  }
}
