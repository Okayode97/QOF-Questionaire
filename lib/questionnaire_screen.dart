import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:qof_sample_framework/Models/questionnaire.dart';
import 'package:qof_sample_framework/Models/questions.dart';
import 'package:qof_sample_framework/Models/answers.dart';

class QuestionnaireScreen extends StatefulWidget {

  // define an instance of the questionnaire class
  // recap that the questionnaire class encapsulates the chronic condition, about, list of questions
  final Questionnaire questionnaire;
  
  // set an instance of the questionnaire class as a required argument for the QuestionnaireScreen
  QuestionnaireScreen({
    @required this.questionnaire
  });

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {

  // Create a list of questions from the list of questions within the questionnaire class
  // recap that each questionnaire as it's own list of questions
  List<Questions> get questions => widget.questionnaire.questions;

  // index for each chronic condition
  int questionIndex;

  // get the number of questions in the questionnaire
  int get numberOfQuestions => questions.length;

  // Get the current question from the list of questions defined above
  Questions get currentQuestion => questions[questionIndex];

  // not entirely sure what is being done here
  List<int> chosenAnswers;
  bool get userhasAnsweredCurrentQuestion => chosenAnswers[questionIndex] != null;

  @override
  void initState() {
    super.initState();

    questionIndex = 0;
    chosenAnswers = List<int>(numberOfQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          // title is the chronic condition
          widget.questionnaire.chronicconditon
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Display information about the chronic condition.
            // This would have been the first question
            Text(widget.questionnaire.about),
            
            Column(
              children: <Widget>[

              ],
            )
          ]
        ),
      )
    );
  }
}