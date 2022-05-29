import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharactersServices{
  Dio? dio;

  CharactersServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 20 * 1000, // 20 seconds
      connectTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters()async{
    try{
     Response response = await dio!.get('characters');
     return response.data;
    }catch(e){
      print('error get all characters : $e');
     return [];
    }
  }
}