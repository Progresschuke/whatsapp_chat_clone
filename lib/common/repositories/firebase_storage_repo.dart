import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepository = Provider((ref) =>
    CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class CommonFirebaseStorageRepository {
  CommonFirebaseStorageRepository({required this.firebaseStorage});

  final FirebaseStorage firebaseStorage;

  Future<String> storeFileToFirebase(String ref, File file) async {
    final storageRef = firebaseStorage.ref();
    UploadTask uploadTask = storageRef.child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
