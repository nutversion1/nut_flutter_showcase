import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/main.dart';
import 'package:nut_flutter_showcase/services/api_service.dart';

import 'package:nut_flutter_showcase/showcase/fun_with_api/random_quote/models/quote.dart';
import 'package:nut_flutter_showcase/screen_states/screen_states.dart';

class QuoteCubit extends Cubit<BaseState> {
  final apiService = locator<ApiService>();

  QuoteCubit() : super(const BaseInitialState());

  Future<void> fetchRandomQuote() async {
    try {
      emit(const BaseLoadingState());

      var url = 'https://quotes15.p.rapidapi.com/quotes/random/';
      var response = await apiService.dio.get(url);

      if (response.statusCode == 200) {
        var quote = Quote.fromJson(response.data);

        emit(BaseCompletedState(data: quote));
      } else {
        emit(BaseErrorState(errorMessage: 'API Error: ${response.data}'));
      }
    } catch (e) {
      emit(BaseErrorState(errorMessage: 'Fetching Error: $e'));
    }
  }
}
