part of 'topic_bloc.dart';

sealed class TopicState {}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicSuccess extends TopicState {
  final List<Topic> topics;

  TopicSuccess(this.topics);
}

class TopicError extends TopicState {
  final String message;

  TopicError(this.message);
}
