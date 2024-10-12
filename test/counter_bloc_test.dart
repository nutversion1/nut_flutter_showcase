import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nut_flutter_showcase/showcase/other/bloc_demo/blocs/counter_bloc.dart';
import 'package:nut_flutter_showcase/showcase/other/cubit_demo/cubits/counter_cubit.dart';

void main() {
  _testCounterCubit();
  _testCounterBloc();
}

void _testCounterCubit() {
  return group(CounterCubit, () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    test('initial state is 0', () {
      expect(counterCubit.state, equals(0));
    });

    blocTest(
      'emits [1] when increment',
      build: () => counterCubit,
      act: (cubit) => counterCubit.increment(),
      expect: () => [2],
    );

    blocTest(
      'emits [1] when decrement',
      build: () => counterCubit,
      act: (cubit) => counterCubit.decrement(),
      expect: () => [-2],
    );
  });
}

void _testCounterBloc() {
  return group(CounterBloc, () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    test('initial state is 0', () {
      expect(counterBloc.state, equals(0));
    });

    blocTest(
      'emits [1] when CounterIncrementPressed is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterIncrementPressed()),
      expect: () => [1],
    );

    blocTest(
      'emits [-1] when CounterDecrementPressed is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterDecrementPressed()),
      expect: () => [-1],
    );
  });
}
