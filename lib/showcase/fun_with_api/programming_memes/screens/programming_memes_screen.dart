import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter_showcase/screen_states/screen_states.dart';
import 'package:nut_flutter_showcase/showcase/fun_with_api/programming_memes/cubits/memes_cubit.dart';

import '../models/meme.dart';

class ProgrammingMemesScreen extends StatefulWidget {
  const ProgrammingMemesScreen({super.key});

  @override
  State<ProgrammingMemesScreen> createState() => _ProgrammingMemesScreenState();
}

class _ProgrammingMemesScreenState extends State<ProgrammingMemesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programming Memes')),
      body: BlocProvider(
        create: (context) => MemeCubit()..fetchMemes(),
        child: BlocConsumer<MemeCubit, BaseState>(
          builder: (context, state) {
            return switch (state) {
              BaseInitialState() => Container(),
              BaseLoadingState() => const Center(child: CircularProgressIndicator()),
              BaseCompletedState() => _buildBody(context, state.data),
              BaseErrorState() => Center(child: Text(state.errorMessage.toString())),
            };
          },
          listener: (context, state) => {},
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Meme> memes) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: _buildMemeCards(memes),
    );
  }

  Widget _buildMemeCards(List<Meme> memes) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        itemCount: memes.length,
        itemBuilder: (context, index) {
          return _buildMemeCard(memes[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _buildMemeCard(Meme meme) {
    return Container(
      width: 250,
      height: 300,
      color: Colors.white54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMemeImage(meme),
          Text(meme.modified.substring(0, 10).toString()),
        ],
      ),
    );
  }

  Widget _buildMemeImage(Meme meme) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
        meme.image,
      ),
    );
  }
}
