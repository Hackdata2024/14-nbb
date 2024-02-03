// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuizQuestionsModel {
  final String question;
  final List<String> options;
  final int correctOption; // 0, 1, 2, 3

  QuizQuestionsModel(
    this.question,
    this.options,
    this.correctOption,
  );

  factory QuizQuestionsModel.fromMap(Map<String, dynamic> map) {
    List<String> mymap(options) {
    return 
      [options['0'].toString(),options['1'].toString(),options['2'].toString(),options['3'].toString()
      ];
  }

    return QuizQuestionsModel(
      map['question'] as String,
      List<String>.from(map['options'] as List<dynamic>),   //when getting questions
      //mymap(map['options']),                              //when sending from json format to map to json again
      map['correctOption'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctOption': correctOption,
    };
  }

  
}
