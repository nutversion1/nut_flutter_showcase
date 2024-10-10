import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/main.dart';
import 'package:nut_flutter_showcase/services/api_service.dart';

import '../models/quote.dart';
import 'quote_states.dart';

class QuoteCubit extends Cubit<BaseState> {
  final apiService = locator<ApiService>();

  QuoteCubit() : super(const BaseInitialState());

  Future<void> fetchRandomQuote() async {
    try {
      emit(const BaseLoadingState());

      var url = 'https://quotes15.p.rapidapi.com/quotes/random/';
      var response = await apiService.dio.get(url);

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
