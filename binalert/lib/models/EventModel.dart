class EventModel {
  final String name;
  final DateTime date;
  final String imgUrl;

  EventModel({
    required this.name,
    required this.date,
    required this.imgUrl,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      name: map['name'],
      date: map['date'].toDate(),
      imgUrl: map['imgUrl'],
    );
  }

  // Map<String, dynamic> toJSON() {
  //   return {
  //     'name': name,
  //     'date': date,
  //     'imgUrl': imgUrl,
  //   };
  //}
}
