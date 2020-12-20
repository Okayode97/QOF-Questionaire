//https://flutter.dev/docs/development/ui/assets-and-images
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:qof_sample_framework/Models/questionnaire.dart';

// https://www.tutorialspoint.com/dart_programming/dart_programming_enumeration.htm
enum ChronicConditions {
  // define a comma-seperated list of identifiers represented by an integar value, zero indexed.
  htn,
}

class QuestionnaireServices {

  String getchronicconditionpath(ChronicConditions conditions){
  /*
    function returns the path of the json file given the enumeration contained in enums/questionnaire_type.dart
     
    Args:
      questionnaireType (QuestionnaireType): An instance of the enum class
    
    Returns:
      (String): PATH to the json file containing the string
  */
    switch(conditions) {
      case ChronicConditions.htn:
        return 'chronic_conditions/htn.json';
      default:
        return null;
    }
  }


  Future<Questionnaire> createQuestionnaireObject(ChronicConditions conditions) async{
  /*
    function returns a future of the Questionnaire class defined in models/questionnaire.dart.

    Args:
      conditions (ChronicConditions): An instance of the enum class
    
    Returns:
      a questionnaire object
  */
    final jsonPath = getchronicconditionpath(conditions);
    final jsonData = await rootBundle.loadString(jsonPath);
    final jsonDataDecoded = jsonDecode(jsonData);
    return Questionnaire.fromJson(jsonDataDecoded);
  }

}