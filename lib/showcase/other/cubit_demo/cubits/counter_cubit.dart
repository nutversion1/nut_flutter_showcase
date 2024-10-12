import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 2);
  void decrement() => emit(state - 2);

  @override
  void onChange(Change<int> change) {
    print('onChange: $change');
    super.onChange(change);
  }
}
