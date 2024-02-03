import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';
import 'package:binalert/utils/user_control.dart';

void MyInitialization(FirebaseStoreageRepo _firebaseStoreageRepo,
    FirebaseRepository _authRepository) {
  final UserControl userControl =
      UserControl(_firebaseStoreageRepo, _authRepository);

  //Initialization functions
  userControl.checkIn();
}
