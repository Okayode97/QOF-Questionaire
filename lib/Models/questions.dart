import 'package:meta/meta.dart';
import 'package:qof_sample_framework/Models/answers.dart';

class Questions{
  String question;
  List<Answer> answers;

  Questions({
    @required this.question,
    @required this.answers
  });

  factory Questions.fromJson(Map<String, dynamic> json){
    var list = json['answers'] as List;
    List<Answer> answerList = list.map((i) =>
    Answer.fromJson(i)).toList();

    return Questions(
      question: json['question'],
      answers: answerList
    );
  }
}