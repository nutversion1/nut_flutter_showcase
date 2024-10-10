import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/main.dart';
import 'package:nut_flutter_showcase/services/api_service.dart';
import 'package:nut_flutter_showcase/showcase/fun_with_api/programming_memes/models/meme.dart';
import 'package:nut_flutter_showcase/screen_states/screen_states.dart';

class MemeCubit extends Cubit<BaseState> {
  final apiService = locator<ApiService>();

  MemeCubit() : super(const BaseInitialState());

  Future<void> fetchMemes() async {
    try {
      emit(const BaseLoadingState());

      var url = 'https://programming-memes-images.p.rapidapi.com/v1/memes';
      var response = await apiService.dio.get(url);

      if (response.statusCode == 200) {
        final memes = response.data.map<Meme>((valueMap) {
          return Meme.fromJson(valueMap);
        }).toList();

        emit(BaseCompletedState(data: memes));
      } else {
        emit(BaseErrorState(errorMessage: 'API Error: ${response.data}'));
      }
    } catch (e) {
      emit(BaseErrorState(errorMessage: 'Fetching Error: $e'));
    }
  }
}
