import 'package:animeshnik/data/models/title_updates.dart';
import 'package:dio/dio.dart';

class AnlibriaService {
  final Dio _dio;

  AnlibriaService(this._dio);

  Future<TitleUpdates> getTitleUpdates(int page, int itemsPerPage) async {
    final response = await _dio.get('https://api.anilibria.tv/v3/title/updates',
        queryParameters: {
          'limit': itemsPerPage,
          'page': page,
          'items_per_page': itemsPerPage
        });

    if (response.statusCode == null ||
        response.statusCode! >= 400 && response.statusCode! <= 599) {
      throw 'бля :( ${response.statusCode}';
    }

    TitleUpdates titleUpdates = TitleUpdates.fromJson(response.data);
    return titleUpdates;
  }
}
