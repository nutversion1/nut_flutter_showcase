import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

final class CounterDecrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }

  @override
  void onChange(Change<int> change) {
    print('onChange: $change');
    super.onChange(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print('onTransition: $transition');
    super.onTransition(transition);
  }
}
