import 'package:dio/dio.dart';

class ApiHelper {
  final Dio _dio = Dio();

  Future getApi({required String url, String? token}) async {
    try {
      Options options = Options();
      if (token != null) {
        options.headers = {'Authorization': 'Token $token'};
      }
      Response response = await _dio.get(url, options: options);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("There's an error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to make the request: $e');
    }
  }

}
