import 'package:dio/dio.dart';

import '../models/index.dart';
import '../util/index.dart';
import 'index.dart';

/// Services that sends news to [ApiService].
class NewsCreateService extends BaseService {
  const NewsCreateService(Dio client) : super(client);

  /// Post news.
  Future<Response> postNews(News news, String token) async {
    return client.post(Url.news,
        data: FormData.fromMap({
          'title': news.title,
          'introText': news.introText,
          'date': news.createdAt.millisecondsSinceEpoch,
          'fullText': news.fullText,
          'image': [
            for (final imagePath in news.images)
              MultipartFile.fromFileSync(
                imagePath,
                filename: imagePath.split('/').last,
              ),
          ]
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));
  }

  /// Delete news by id.
  Future<Response> deleteNews(String token, String id) async {
    return client.delete('${Url.news}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));
  }
}
