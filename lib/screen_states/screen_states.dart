abstract class BaseState {
  const BaseState();
}

class BaseInitialState extends BaseState {
  const BaseInitialState();
}

class BaseLoadingState extends BaseState {
  const BaseLoadingState();
}

class BaseCompletedState extends BaseState {
  dynamic data;
  BaseCompletedState({this.data});
}

class BaseErrorState extends BaseState {
  final String? errorMessage;
  const BaseErrorState({this.errorMessage});
}
