import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';

class UserControl {
  final FirebaseStoreageRepo _firebaseStoreageRepo;
  final FirebaseRepository _authRepository;

  UserControl(
    this._firebaseStoreageRepo,
    this._authRepository,
  );

  void checkIn() {
    var timenow = DateTime.now();
    var timestamp =
        DateTime.parse(_authRepository.userModel.userStat.timestamp);

    bool isSameDate() {
      return timestamp.year == timenow.year &&
          timestamp.month == timenow.month &&
          timestamp.day == timenow.day;
    }

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    if (!isSameDate()) {
      _authRepository.userModel.userStat.daysActive =
          _authRepository.userModel.userStat.daysActive + 1;
      _authRepository.userModel.userStat.isStreak = false;
    }
    print(daysBetween(timestamp, timenow));

    if (daysBetween(timestamp, timenow) > 1) {
      _authRepository.userModel.userStat.dailyStreak = 0;
    }
    _authRepository.userModel.userStat.timestamp = timenow.toString();
    _authRepository.updateUserModel();
  }

  void editUserInfo(String username, String bio) {
    if(username !=""){_authRepository.userModel.username = username;}
    if(bio != ""){_authRepository.userModel.bio = bio;}
    _authRepository.updateUserModel();
  }
}
