import 'package:kitaabua/database/api/firebase_api.dart';
import 'package:kitaabua/database/models/meaning.dart';

import '../../core/configs/utils.dart';

class Expression {
  final String id;
  final String word;
  final String addedBy;
  final DateTime? addedOn;
  late DateTime? updatedOn;
  late String? updatedBy;
  late String? audioPath;
  late bool? state = true;
  late List<Meaning>? meanings;
  late bool? isBookmarked = false;

  Expression({
    required this.id,
    required this.word,
    required this.addedBy,
     this.addedOn,
    this.updatedOn,
    this.updatedBy,
    this.state,
    this.audioPath,
    this.meanings,
  });

  Expression.fromJson(Map<String, dynamic> json)
      : id = json['id']??'',
        word = json['word']??'',
        addedBy = json['addedBy']??'',
        addedOn = Utils.toDateTime(json['addedOn']),
        updatedOn = Utils.toDateTime(json['updatedOn']),
        updatedBy = json['updatedBy']??'',
        audioPath = json['audioPath']??'',
        state = json['state'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'addedBy': addedBy,
        'addedOn': Utils.fromDateTimeToJson(addedOn),
        'updatedOn': Utils.fromDateTimeToJson(updatedOn!),
        'updatedBy': updatedBy,
        'audioPath': audioPath,
        'state': state,
      };

  Future<void> reloadMeanings() async {
    meanings = await FirebaseApi.futureReadMeanings(id);
  }

  bool hasAudio() {
    return audioPath != null && audioPath!.isNotEmpty;
  }

  @override
  String toString() {
    return 'Expression{id: $id, word: $word, addedBy: $addedBy, addedOn: $addedOn, updatedOn: $updatedOn, updatedBy: $updatedBy, state: $state, audioPath:$audioPath, meanings: $meanings}';
  }
}
