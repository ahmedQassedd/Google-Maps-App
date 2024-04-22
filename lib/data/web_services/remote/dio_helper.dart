import 'package:dio/dio.dart';
import 'package:google_maps/data/web_services/remote/end_points.dart';


abstract class DioHelper {

   Future<dynamic> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? token,
  });


   Future<dynamic> postData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  });

   Future<dynamic> putData({
     required String endPoint,
     Map<String, dynamic>? query,
     required Map<String, dynamic> data,
     String? token,
   });

}


class DioHelperImpl extends DioHelper {

  static Dio? dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
  ),
  );


  @override
  Future getData({required String endPoint, Map<String, dynamic>? query,
    String? token
  }) async {

    dio!.options.headers = {};

    return await dio!.get(endPoint , queryParameters: query );

  }

  @override
  Future postData({required String endPoint, Map<String, dynamic>? query, required Map<String, dynamic> data,
    String? token})
  async {

    dio!.options.headers = {};

    return await dio!.post(endPoint , queryParameters: query , data: data );

  }

  @override
  Future putData({required String endPoint, Map<String, dynamic>? query, required Map<String, dynamic> data, String? token
  }) async {

    dio!.options.headers = {};

    return await dio!.put(endPoint , queryParameters: query , data: data );

  }


}




