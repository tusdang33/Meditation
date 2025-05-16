import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/domain/models/topic/topic_model.dart';
import 'package:mediation_app/domain/repository/topic_repository.dart';
import 'package:mediation_app/domain/result_model.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final _topicRepository = getIt<TopicRepository>();

  TopicBloc() : super(TopicInitial()) {
    on<GetTopics>(_onGetTopics);
  }

  Future<void> _onGetTopics(GetTopics event, Emitter<TopicState> emit) async {
    try {
      emit(TopicLoading());

      (await _topicRepository.getTopics())
          .success((topics) {
            emit(TopicSuccess(topics!));
          })
          .fail((error) {
            emit(TopicError(error ?? 'Failed to get topics'));
          });
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }
}
