import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/showcase/fun_with_api/random_quote/cubits/quote_cubit.dart';

import '../../../../screen_states/screen_states.dart';
import '../models/quote.dart';

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Quote')),
      body: BlocProvider(
        create: (context) => QuoteCubit()..fetchRandomQuote(),
        child: BlocBuilder<QuoteCubit, BaseState>(
          builder: (context, state) {
            if (state is BaseInitialState) {
              return Container();
            } else if (state is BaseLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BaseCompletedState) {
              return _buildBody(context, state.data);
            } else if (state is BaseErrorState) {
              return Center(child: Text(state.errorMessage.toString()));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(context, Quote quote) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildQuoteCard(quote),
              const SizedBox(height: 100),
              _buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<QuoteCubit>().fetchRandomQuote();
      },
      child: const Text('Next', style: TextStyle(fontSize: 18.0)),
    );
  }

  Widget _buildQuoteCard(Quote quote) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              quote.quote,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              '-${quote.author}',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
