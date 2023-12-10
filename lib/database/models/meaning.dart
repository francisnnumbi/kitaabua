import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/configs/utils.dart';

class Meaning {
  final String id;
  final String meaning;
  final String example;
  final String exampleTranslation;
  final String grammar;
  final String addedBy;
  final DateTime addedOn;
  late DateTime? updatedOn;
  late String? updatedBy;
  late bool? state = true;

  Meaning({
    required this.id,
    required this.meaning,
    required this.example,
    required this.exampleTranslation,
    required this.grammar,
    required this.addedBy,
    required this.addedOn,
    this.updatedOn,
    this.updatedBy,
    this.state,
  });

  Meaning.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        meaning = json['meaning'],
        example = json['example'],
        exampleTranslation = json['exampleTranslation'],
        grammar = json['grammar'],
        addedBy = json['addedBy'],
        addedOn = Utils.toDateTime(json['addedOn'])!,
        updatedOn = Utils.toDateTime(json['updatedOn'])!,
        updatedBy = json['updatedBy'],
        state = json['state'];

  Meaning.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        meaning = snapshot['meaning'],
        example = snapshot['example'],
        exampleTranslation = snapshot['exampleTranslation'],
        grammar = snapshot['grammar'],
        addedBy = snapshot['addedBy'],
        addedOn = Utils.toDateTime(snapshot['addedOn'])!,
        updatedOn = Utils.toDateTime(snapshot['updatedOn'])!,
        updatedBy = snapshot['updatedBy'],
        state = snapshot['state'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'meaning': meaning,
        'example': example,
        'exampleTranslation': exampleTranslation,
        'grammar': grammar,
        'addedBy': addedBy,
        'addedOn': Utils.fromDateTimeToJson(addedOn),
        'updatedOn': Utils.fromDateTimeToJson(updatedOn!),
        'updatedBy': updatedBy,
        'state': state,
      };

  @override
  String toString() {
    return 'Meaning{id: $id, meaning: $meaning, example: $example, exampleTranslation: $exampleTranslation, grammar: $grammar, addedBy: $addedBy, addedOn: $addedOn, updatedOn: $updatedOn, updatedBy: $updatedBy, state: $state}';
  }
}
