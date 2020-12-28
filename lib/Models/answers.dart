import 'package:meta/meta.dart';

class Answer{

  String response;
  final int score;
  bool red_flag;

  Answer({
    @required this.response,
    @required this.score,
    @required this.red_flag,
  });

  factory Answer.fromJson(Map<String, dynamic> json){
    return Answer(
      response: json['response'],
      score: json['score'],
      red_flag: json['red_flag']
    );
  } 
}