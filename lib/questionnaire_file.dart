
// https://www.tutorialspoint.com/dart_programming/dart_programming_enumeration.htm
enum ChronicConditions {
  // define a comma-seperated list of identifiers represented by an integar value, zero indexed.
  // as an initial demo it will expand to include 2 different chronic conditions
  htn,
}

class Questionnaires {

  // get the path of the json file for each chronic condition
  String _getCCQuestionnairePath(ChronicConditions conditions){
    switch(conditions) {
      case ChronicConditions.htn:
        return 'chronic_conditions/htn.json';
      default:
        return null;
    }
  }

  // Return a questionnaire object

}