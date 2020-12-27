import 'package:meta/meta.dart';

class Answer{

  String response;
  final int score;

  Answer({
    @required this.response,
    @required this.score,
  });

  factory Answer.fromJson(Map<String, dynamic> json){
    return Answer(
      response: json['response'],
      score: json['score']
    );
  } 
}