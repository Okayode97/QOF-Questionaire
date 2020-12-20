import 'package:meta/meta.dart';

class Answer{

  String response;
  String score;

  Answer({
    @required this.response,
    @required this.score,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    response: json['response'],
    score: json['score']
    );
}