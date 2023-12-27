import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageApi {
  static final storage = FirebaseStorage.instance;
  static final storageRef = storage.ref();
  static final expressionAudioRef = storageRef.child('expressions/audio');

  static Future<String> uploadExpressionAudio(
      String expressionId, String path) async {
    final ref = expressionAudioRef.child(expressionId);
    final uploadTask = ref.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }
}
