import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:qof_sample_framework/Models/questionnaire.dart';
import 'package:qof_sample_framework/Models/questions.dart';
import 'package:qof_sample_framework/Models/answers.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:group_radio_button/group_radio_button.dart';

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

  // index for each question in that chronic condition questionnaire
  int questionIndex;

  // get the number of questions in the questionnaire
  int get numberOfQuestions => questions.length;

  // Get the current question from the list of questions defined above
  Questions get currentQuestion => questions[questionIndex];

  // A list of chosen answers
  // recap that the score for each response is an integar
  List<int> chosenAnswers;

  // check that the user has answered the question by checking that it is not null
  bool get userhasAnsweredCurrentQuestion => chosenAnswers[questionIndex] != null;

  // Get the list of answers, done as a means of bypassing the group_radio_button by using a for loop
  List<Answer> get answerList => questions[questionIndex].answers;

  // Store a list of redflagged questions and the response
  List<String>redFlaggedQuestions = [];
  List<String>redFlaggedQuestionsResponse = [];

  int mapResponsetoIndex(String value) {
    var responseMap = new Map();
    int responseIndex = 0;
    for(Answer answer in answerList){
      responseMap[answer.response] = responseIndex;
      responseIndex++;
    }
    return responseMap[value];
  }

  // Store the selected response from the radio buttons
  String _response = "";

  int getTotalScore() {
    // calculate user's total score
    int result = 0;
    for (int index = 0; index < numberOfQuestions; index++){
      Questions question = questions[index];
      int answerIndex = chosenAnswers[index];
      Answer answer = question.answers[answerIndex];
      int score = answer.score;

      result += score;
    }
    return result;
  }

  // Any response that as been marked as a red flag should be highlighted to the GP
  void checkForRedFlags() {
    for(int index=0; index < numberOfQuestions; index++){
      Questions question = questions[index];
      int answerIndex = chosenAnswers[index];

      // get the answer that the user selected based on the answerIndex
      Answer answer = question.answers[answerIndex];
      bool redflag = answer.red_flag;

      // if the selected answer has red_flag = true then mark the question and the user's response
      if(redflag)
      {
        redFlaggedQuestions.add(question.question);
        redFlaggedQuestionsResponse.add(answer.response);
      }
    }
  } 

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
          '${widget.questionnaire.chronicconditon}'
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Display information about the chronic condition.
            // This would have been the first question
            Text('${widget.questionnaire.about}'),

            Column(
              children: <Widget>[

                // indicate number of questions in the questionnaire and which is being answered
                Center(
                  child: DotsIndicator(
                    dotsCount: numberOfQuestions,
                    position: questionIndex.toDouble(),
                  ),
                ),

                // Display the current question from the list of questions
                Center(
                  child: Text(
                    '${currentQuestion.question}'
                  ),
                ),

                // Display the list of possible answers for that particular questions
                RadioGroup<String>.builder(
                  direction: Axis.vertical,
                  groupValue: _response,
                  onChanged: (value) => setState((){
                      _response = value;
                      
                      // convert the string to an integar which would be it's index
                      int answerIndex = mapResponsetoIndex(value);
                      chosenAnswers[questionIndex] = answerIndex;
                  }),
                  items: currentQuestion.answers.map((answer) => answer.response).toList(),
                   itemBuilder: (item) => RadioButtonBuilder(
                   item,
                    textPosition: RadioButtonTextPosition.right,
                  )
                ),

                // Display the Back and Next Buttton
                Center(
                  child: Row(
                    children: <Widget>[

                      // Back button is only visible when not on the first question
                      Visibility(
                        visible: questionIndex != 0,
                        child: RaisedButton(
                          child: Text('Back'),
                          onPressed: () {
                            setState(() {
                              questionIndex--;
                            });
                          },
                        ),
                      ),

                      // Next button checks that the user as selectec an option from the list of possible answers, it does not respond untill the user as selected an option.
                      // On the final page it will return to the main meny
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: userhasAnsweredCurrentQuestion ? onNextButtonPressed : null,
                      ),
                    ],
                  ),
                )
              ],
            )
          ]
        ),
      )
    );
  }

  void onNextButtonPressed() {
    // check that current question is not the last queston
    if (questionIndex < numberOfQuestions -1 ){
      // change the question index
      setState((){
        questionIndex++;
      });
    }
    else{
      checkForRedFlags();
      int score = getTotalScore();
      debugPrint('The total score from the questionnaire is $score');
      for(String question in redFlaggedQuestions)
        debugPrint('$question');
      
      for(String answer in redFlaggedQuestionsResponse)
        debugPrint('$answer');
    }
  }

}

