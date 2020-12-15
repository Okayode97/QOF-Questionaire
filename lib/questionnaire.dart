
// defined a class to encapsulate the data stored in the json file.
class Questionnaire {
  // note that the member variables in the class are representative of the individual sections "keys" in the questionnaire
  final String chronic_conditon;
  final String about;
  final List<Question> questions;

  //define the class constructor for the questionnaire class
  Questionnaire({
    @required this.chronic_conditon,
    @required this.about,
    @required this.questions,
  });


}