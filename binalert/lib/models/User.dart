// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String username;
  final String email;
  String profileUrl;
  String bio;
  UserStat userStat = UserStat();

  UserModel({
    required this.username,
    required this.email,
    required this.profileUrl,
    required this.bio,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final user = UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      bio: map['bio'] as String,
    );

    // Automatically map userStat
    user.userStat = UserStat.fromMap(map['userStat'] as Map<String, dynamic>);

    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profileUrl': profileUrl,
      'bio': bio,
      'userStat': userStat.toJson(),
    };
  }
}

class UserStat {
  int totalScore = 0;
  String timestamp = "";
  int daysActive = 0;
  List<UserScores> userScores = [];
  int totalQuizTaken = 0;
  int dailyStreak = 0;
  bool isStreak = false;

  UserStat();

  factory UserStat.fromMap(Map<String, dynamic> map) {
    return UserStat()
      ..totalScore = map['totalScore'] as int
      ..timestamp = map['timestamp'] as String
      ..daysActive = map['daysActive'] as int
      ..totalQuizTaken = map['totalQuizTaken'] as int
      ..dailyStreak = map['dailyStreak'] as int
      ..isStreak = map['isStreak'] as bool
      ..userScores = (map['userScores'] as List<dynamic>)
          .map((scoreData) =>
              UserScores.fromMap(scoreData as Map<String, dynamic>))
          .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'totalScore': totalScore,
      'timestamp': timestamp,
      'daysActive': daysActive,
      'totalQuizTaken': totalQuizTaken,
      'dailyStreak': dailyStreak,
      'isStreak': isStreak,
      'userScores': userScores.map((score) => score.toJson()).toList(),
    };
  }
}

class UserScores {
  final String quizTime;
  final int score;

  UserScores({required this.quizTime, required this.score});

  factory UserScores.fromMap(Map<String, dynamic> map) {
    return UserScores(
      quizTime: map['quizTime'] as String,
      score: map['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizTime': quizTime,
      'score': score,
    };
  }
}
