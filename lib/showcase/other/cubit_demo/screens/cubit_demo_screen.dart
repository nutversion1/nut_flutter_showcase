import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/showcase/other/cubit_demo/cubits/counter_cubit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit Demo')),
      body: BlocProvider(
        create: (_) => CounterCubit(),
        child: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, count) => _buildBody(context, count),
    );
  }

  Widget _buildBody(BuildContext context, int count) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Count: $count',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.read<CounterCubit>().increment(),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () => context.read<CounterCubit>().decrement(),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
