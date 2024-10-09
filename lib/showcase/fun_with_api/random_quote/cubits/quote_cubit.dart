import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/quote.dart';
import 'quote_states.dart';

class QuoteCubit extends Cubit<BaseState> {
  QuoteCubit() : super(const BaseInitialState());

  Future<void> fetchRandomQuote() async {
    try {
      emit(const BaseLoadingState());

      var url = 'https://quotes15.p.rapidapi.com/quotes/random/';
      var headers = {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
      };

      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('res: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map valueMap = json.decode(response.body);
        var quote = valueMap['content'];
        var author = valueMap['originator']['name'];

        emit(BaseCompletedState(data: Quote(quote, author)));
      } else {
        emit(BaseErrorState(errorMessage: 'API Error: ${response.body}'));
      }
    } catch (e) {
      emit(BaseErrorState(errorMessage: 'Fetching Error: $e'));
    }
  }
}
