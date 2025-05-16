import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mediation_app/domain/models/topic/topic_model.dart';
import 'package:mediation_app/domain/repository/topic_repository.dart';
import 'package:mediation_app/domain/result_model.dart';

class TopicRepositoryImpl extends TopicRepository {
  @override
  Future<Resource<List<Topic>>> getTopics() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final jsonContent = await rootBundle.loadString(
        "mock/topics/topics.json",
      );
      final List<dynamic> jsonData = jsonDecode(jsonContent);
      return Success(jsonData.map((e) => Topic.fromJson(e)).toList());
    } catch (e) {
      return Fail(e.toString());
    }
  }
}
