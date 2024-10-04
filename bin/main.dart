import 'package:animeshnik/data/models/title_updates.dart';
import 'package:animeshnik/data/network/anlibria_service.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  Dio dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: false));

  AnlibriaService anilibriaService = AnlibriaService(dio);

  TitleUpdates titleUpdates = await anilibriaService.getTitleUpdates(1, 10);
}
