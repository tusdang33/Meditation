import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediation_app/domain/models/topic/topic_model.dart';
import 'package:mediation_app/pages/topic/topic_bloc/topic_bloc.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final bloc = TopicBloc();
          bloc.add(GetTopics());
          return bloc;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset('mock/topics/topic_background.svg'),
                  ),
                ),
              ),
              SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ResponsiveBuilder(
                    landscape: Row(
                      children: [
                        FittedBox(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _TopicHeader(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(child: _TopicList()),
                      ],
                    ),
                    portrait: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TopicHeader(),
                        const SizedBox(height: 16),
                        _TopicList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicList extends StatelessWidget {
  const _TopicList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
      listener: (context, state) {
        if (state is TopicError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TopicSuccess) {
          return Expanded(
            child: MasonryGridView.count(
              itemCount: state.topics.length,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemBuilder: (context, index) {
                final topic = state.topics[index];
                return InkWell(
                  onTap: () {},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: topic.bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SvgPicture.asset(
                              topic.thumbnail,
                              width: constraints.maxWidth,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            topic.title,
                            style: PrimaryFont.bold(
                              16,
                            ).copyWith(color: topic.textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              crossAxisCount: 2,
            ),
          );
        }
        return const Expanded(
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: kColorPrimary),
          ),
        );
      },
    );
  }
}

class _TopicHeader extends StatelessWidget {
  const _TopicHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: TopicPageStrings.title.split('\n').first,
            style: PrimaryFont.bold(28.0).copyWith(height: 1.35),
            children: [
              TextSpan(
                text: TopicPageStrings.title.split('\n').last,
                style: PrimaryFont.light(28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(TopicPageStrings.subtitle, style: PrimaryFont.light(20)),
      ],
    );
  }
}
