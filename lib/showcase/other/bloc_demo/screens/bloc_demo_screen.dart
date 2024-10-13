import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/showcase/other/bloc_demo/blocs/counter_bloc.dart';

class BlocDemoScreen extends StatelessWidget {
  const BlocDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Demo')),
      body: BlocProvider(
        create: (_) => CounterBloc(),
        child: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, count) => _buildBody(context, count),
    );
  }

  Widget _buildBody(BuildContext context, int count) {
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
                onPressed: () => context.read<CounterBloc>().add(CounterIncrementPressed()),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () => context.read<CounterBloc>().add(CounterDecrementPressed()),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
