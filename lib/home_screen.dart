import 'package:flutter/material.dart';
import 'package:qof_sample_framework/Services/chroniccondition_services.dart';
import 'package:qof_sample_framework/Models/questionnaire.dart';
import 'package:qof_sample_framework/questionnaire_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // list of questionnaire objects
  List<Questionnaire> questionnairesList;

  // a future object which would populate the above list with questionnaire object for each chronic condition
  Future<bool> allQuestionnaireFutures;

  @override
  void initState() {
    super.initState();

    allQuestionnaireFutures = loadQOF();
  }

  Future<bool> loadQOF() async {

    // create an instance of the questionnaireServices class
    final questionnairesservices = QuestionnaireServices();
    questionnairesList = [];

    // recap that ChronicConditions is an enum class containing a list of all the chronic conditions
    for (ChronicConditions conditions in ChronicConditions.values){

      // create a questionnaire object from each json file
      final questionnaire = await questionnairesservices.createQuestionnaireObject(conditions);

      if (questionnaire == null){
        return false;
      }

      // add the questionnaire object to a list
      questionnairesList.add(questionnaire);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: FutureBuilder(
        // read this medium post https://medium.com/swlh/flutter-futurebuilder-383b6ed63f18
        future: allQuestionnaireFutures,
        builder: (context, snapshot) {

          // if the future as finished!, return this widget
          if (snapshot.hasData){
            return Center(
              child: Column(
                children: <Widget>[

                  // for each questionnaire object in the questionnaireList create a raisedbutton which links to the questionnaire screen for that
                  // particular questionnaire
                  for (Questionnaire questionnaire in  questionnairesList)
                    RaisedButton(
                      child: Text(
                        '${questionnaire.chronicconditon}'
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            // the QuestionnaireScreen requires a questionnaire object as an input argument
                            builder: (context) => QuestionnaireScreen(
                              questionnaire: questionnaire
                            )
                          )
                        );
                      },
                  )
                ],
              ),
            );
          }
          
          // if there was an error in interacting with the snapshot
          else if (snapshot.hasError) {
            return Text(
              'Something went wrong'
            );
          }
          
          // if there is no error and the snapshot as not been loaded, return a circular progressbar
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}