import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediation_app/pages/topic/topic_bloc/topic_bloc.dart';
import 'package:mediation_app/utils/theme.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TopicBloc(),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: SvgPicture.asset('mock/topics/topic_background.svg'),
                ),
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'What Brings you\n',
                      style: PrimaryFont.bold(28.0).copyWith(height: 1.35),
                      children: [
                        TextSpan(
                          text: 'to Silent Moon?',
                          style: PrimaryFont.light(28),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'choose a topic to focuse on:',
                    style: PrimaryFont.light(20),
                  ),
                  BlocConsumer<TopicBloc, TopicState>(
                    listener: (context, state) {
                      if (state is TopicError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is TopicSuccess) {
                        return MasonryGridView.count(
                          itemCount: state.topics.length,
                          itemBuilder:
                              (context, index) => Container(color: Colors.red),
                          crossAxisCount: 2,
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
