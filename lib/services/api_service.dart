import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      headers: {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856'
      },
    ),
  );
}
