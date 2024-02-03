import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:binalert/bloc/firebase_storage/firebase_storage_event.dart';
import 'package:binalert/bloc/firebase_storage/firebase_storage_state.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageBloc
    extends Bloc<FirebaseStorageEvent, FirebaseStorageState> {
  FirebaseStorageBloc() : super(FirebaseStorageInitialState()) {
    //Events handlers here

    on<FirebaseStorageGetFilesListEvent>((event, emit) async {
      emit(FirebaseStorageLoadingState());
      ListResult futureFilesNameList =
          await firebaseGetFiles(event.firebaseStorageRepo);
      ListResult futurePreviewList =
          await firebaseGetPreviews(event.firebaseStorageRepo);
      List<String> previewsUrlList =
          await event.firebaseStorageRepo.getPreviewsurl(futurePreviewList);
      emit(FirebaseStorageDataLoadedState(
          filesNameList: futureFilesNameList, previewsUrlList: previewsUrlList));
    });

    on<FirebaseStorageDownloadFilesEvent>((event, emit) async {
      emit(FirebaseStorageLoadingState());
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/${event.ref.name}';

      if (await io.File(filePath).exists()) {
        print("~~~~~~~~~File already there~~~~~~~~~~~~~");
        emit(FirebaseStorageGoToDocViewState(filePath: filePath));
      } else {
        try {
          await event.firebaseStorageRepo.downloadPdfFile(event.ref);
          emit(FirebaseStorageGoToDocViewState(filePath: filePath));
        } catch (e) {
          emit(FirebaseStoreageErrorState());
        }
      }
    });

    //
  }
}

Future<ListResult> firebaseGetFiles(
    FirebaseStoreageRepo firebaseStoreageRepo) async {
  Future<ListResult> futureFiles = firebaseStoreageRepo.getPdfList();
  return futureFiles;
}

Future<ListResult> firebaseGetPreviews(
    FirebaseStoreageRepo firebaseStoreageRepo) async {
  Future<ListResult> futureFiles = firebaseStoreageRepo.getPreviewsList();
  return futureFiles;
}
