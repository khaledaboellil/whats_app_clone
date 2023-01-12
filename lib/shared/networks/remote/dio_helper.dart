import 'package:dio/dio.dart';
class DioHelper{

  static Dio ?dio ;


  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: true,
      ) ,
    ) ;

  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic> ?query,
    String lang = 'en',
    String ?token,
  }) async
  {
    dio?.options.headers =
    {
      'Content-Type':'application/json',
      'Authorization': 'key= AAAA2XOZ44o:APA91bG35jGXRn51OKXflKDg-DahsQOXksEX8sF9QzCgj21ruufOcXT4zI2AUO9n4GmjVWMjgsOTXDfm8GtlY8f_qU9QeO3h-Ye5FxfSrbVmotvW6k700kxpsIwR7i1c_VeLwPzz45Mk ',
    };

    return await dio?.get(
      url,
      queryParameters: query??null,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic> ?query,
    required Map<String,dynamic> data ,
  })async
  {
    dio?.options.headers={
      'Content-Type':'application/json',
      'Authorization': 'key= AAAA2XOZ44o:APA91bG35jGXRn51OKXflKDg-DahsQOXksEX8sF9QzCgj21ruufOcXT4zI2AUO9n4GmjVWMjgsOTXDfm8GtlY8f_qU9QeO3h-Ye5FxfSrbVmotvW6k700kxpsIwR7i1c_VeLwPzz45Mk ',
    };
    return await dio?.post(url,data: data ,queryParameters: query) ;
  }

  static Future<Response?> putData({
    required String url,
    Map<String, dynamic> ?query,
    required Map<String,dynamic> data ,
    String lang='en' ,
    String ?token ,
  })async
  {
    dio?.options.headers={
      'Content-Type':'application/json',
      'Authorization': 'key= AAAA2XOZ44o:APA91bG35jGXRn51OKXflKDg-DahsQOXksEX8sF9QzCgj21ruufOcXT4zI2AUO9n4GmjVWMjgsOTXDfm8GtlY8f_qU9QeO3h-Ye5FxfSrbVmotvW6k700kxpsIwR7i1c_VeLwPzz45Mk ',
    };
    return await dio?.put(url,data: data ,queryParameters: query) ;
  }

}
