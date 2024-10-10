import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../models/quote.dart';
import 'quote_states.dart';

class QuoteCubit extends Cubit<BaseState> {
  QuoteCubit() : super(const BaseInitialState());

  final dio = Dio(
    BaseOptions(
      headers: {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856'
      },
    ),
  );

  Future<void> fetchRandomQuote() async {
    try {
      emit(const BaseLoadingState());

      var url = 'https://quotes15.p.rapidapi.com/quotes/random/';
      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map valueMap = response.data;
        var quote = valueMap['content'];
        var author = valueMap['originator']['name'];

        emit(BaseCompletedState(data: Quote(quote, author)));
      } else {
        emit(BaseErrorState(errorMessage: 'API Error: ${response.data}'));
      }
    } catch (e) {
      emit(BaseErrorState(errorMessage: 'Fetching Error: $e'));
    }
  }
}
