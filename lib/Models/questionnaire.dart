import 'package:meta/meta.dart';

// defined a class to encapsulate the data stored in the json file.

class Questionnaire {

  // note that the member variables in the class are representative of the individual sections "keys" in the questionnaire
  final String chronicconditon;
  final String about;
  final List<String> questions;

  //define the class constructor for the questionnaire class
  Questionnaire({
    @required this.chronicconditon,
    @required this.about,
    @required this.questions,
  });

  // deserialize the json data. i.e from raw data to an object model
  // Map<String, dynamic> as our json file contains a key-value pair
  // our key is typically a string while our value varies
  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
    chronicconditon: json['ChronicConditions'],
    about: json['About'],
  );

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
  Map<String, dynamic> toJson() => {
    'chronic_condition': chronicconditon,
    'about': about
  };

  @override
  String toString() => toJson().toString();
}