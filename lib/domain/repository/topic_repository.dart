import 'package:mediation_app/domain/models/topic/topic_model.dart';
import 'package:mediation_app/domain/result_model.dart';

abstract class TopicRepository {
  Future<Resource<List<Topic>>> getTopics();
}
