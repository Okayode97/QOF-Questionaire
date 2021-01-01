import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle; //https://flutter.dev/docs/development/ui/assets-and-images
import 'package:qof_sample_framework/Models/questionnaire.dart';

// https://www.tutorialspoint.com/dart_programming/dart_programming_enumeration.htm
enum ChronicConditions {
  // define a comma-seperated list of identifiers represented by an integar value, zero indexed.
  htn,
  af,
  cancer,
  cardiovascular,
  chronic_kidney_disease,
  contraception,
  copd,
  depression,
  diabetes_meltitus,
  epilepsy,
  hypothydroism,
  immunisation,
  mental_health_disorder,
  osteoporosis,
  ra,
  tia
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
      case ChronicConditions.af:
        return 'chronic_conditions/Af.json';
      case ChronicConditions.cancer:
        return 'chronic_conditions/Cancer.json';
      case ChronicConditions.cardiovascular:
        return 'chronic_conditions/Cardiovascular.json';
      case ChronicConditions.chronic_kidney_disease:
        return 'chronic_conditions/Chronic_kidney_disease.json';
      case ChronicConditions.contraception:
        return 'chronic_conditions/Contraception.json';
      case ChronicConditions.copd:
        return 'chronic_conditions/COPD.json';
      case ChronicConditions.depression:
        return 'chronic_conditions/Depression.json';
      case ChronicConditions.diabetes_meltitus:
        return 'chronic_conditions/Diabetes_Mellitus.json';
      case ChronicConditions.epilepsy:
        return 'chronic_conditions/Epilepsy.json';
      case ChronicConditions.hypothydroism:
        return 'chronic_conditions/Hypothydroism.json';
      case ChronicConditions.immunisation:
        return 'chronic_conditions/Immunisation.json';
      case ChronicConditions.mental_health_disorder:
        return 'chronic_conditions/Mental_health_disorder.json';
      case ChronicConditions.osteoporosis:
        return 'chronic_conditions/Osteoporosis.json';
      case ChronicConditions.ra:
        return 'chronic_conditions/RA.json';
      case ChronicConditions.tia:
        return 'chronic_conditions/TIA.json';
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