import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/api/firebase_storage_api.dart';
import 'package:kitaabua/database/models/expression.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../database/api/firebase_api.dart';
import '../ui/widgets/snack.dart';

class AudioController extends GetxController {
  // ------- static methods ------- //
  static AudioController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AudioController>(() async => AudioController());
  }

// ------- ./static methods ------- //
  late AudioRecorder audioRecorder;
  late AudioPlayer audioPlayer;
  final RxBool isRecording = false.obs;
  final RxBool isPlaying = false.obs;
  final RxString recordPath = ''.obs;
  final RxnString audioPath = RxnString();

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        final Directory tempDir = await getTemporaryDirectory();
        await Directory('${tempDir.path}/audio/').create(recursive: true);

        final path = '${tempDir.path}/audio/audio.m4a';
        await audioRecorder.start(const RecordConfig(), path: path);
        isRecording.value = true;
      }
    } catch (e) {
      isRecording.value = false;
      if (kDebugMode) print('Error Start Recording $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      recordPath.value = (await audioRecorder.stop())!;
      isRecording.value = false;
    } catch (e) {
      isRecording.value = false;
      if (kDebugMode) print('Error Stop Recording $e');
    }
  }

  Future<void> playRecording() async {
    try {
      if (recordPath.value.isNotEmpty) {
        Source? source = UrlSource(recordPath.value);
        await audioPlayer.play(source);
        isPlaying.value = true;
      }
    } catch (e) {
      isPlaying.value = false;
      if (kDebugMode) print('Error Play Recording $e');
    }
  }

  Future<void> stopPlaying() async {
    try {
      await audioPlayer.stop();
      isPlaying.value = false;
    } catch (e) {
      isPlaying.value = false;
      if (kDebugMode) print('Error Stop Playing $e');
    }
  }

  Future<void> clearRecord() async {
    try {
      await File(recordPath.value).delete();
      recordPath.value = '';
    } catch (e) {
      if (kDebugMode) print('Error Clear Record $e');
    }
  }

  Future<void> saveRecordToExpression(Expression expression) async {
    try {
      if (recordPath.value.isNotEmpty) {
        String downloadPath = await FirebaseStorageApi.uploadExpressionAudio(
            expression.id, recordPath.value);
        expression.audioPath = downloadPath;
        await FirebaseApi.updateExpression(expression);
        recordPath.value = '';
        await File(recordPath.value).delete();
        Get.back();
        Snack.success('Audio saved successfully'.tr);
      } else {
        Snack.error('No audio to save'.tr);
      }
    } catch (e) {
      Snack.error('Audio save failed'.tr);
      if (kDebugMode) print('Error Clear Record $e');
    }
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    audioRecorder = AudioRecorder();
    super.onInit();

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        isPlaying.value = false;
      }
      if (event == PlayerState.stopped) {
        isPlaying.value = false;
      }
      if (event == PlayerState.disposed) {
        isPlaying.value = false;
      }
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    audioRecorder.dispose();
    super.onClose();
  }
}
