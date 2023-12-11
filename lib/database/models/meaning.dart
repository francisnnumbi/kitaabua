import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/configs/utils.dart';

class Meaning {
  final String id;
  final String meaning;
  late String? example;
  late String? exampleTranslation;
  late String? grammar;
  late String? expressionId;
  final String addedBy;
  final DateTime addedOn;
  late DateTime? updatedOn;
  late String? updatedBy;
  late bool? state = true;

  Meaning({
    required this.id,
    required this.meaning,
    this.example,
    this.exampleTranslation,
    this.grammar,
    this.expressionId,
    required this.addedBy,
    required this.addedOn,
    this.updatedOn,
    this.updatedBy,
    this.state,
  });

  Meaning.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        meaning = json['meaning'],
        example = json['example']!,
        exampleTranslation = json['exampleTranslation']!,
        grammar = json['grammar']!,
        expressionId =
            json.containsKey('expressionId') ? json['expressionId']! : '',
        addedBy = json['addedBy'],
        addedOn = Utils.toDateTime(json['addedOn'])!,
        updatedOn = Utils.toDateTime(json['updatedOn'])!,
        updatedBy = json['updatedBy'],
        state = json['state'];

  Meaning.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        meaning =
            snapshot.data().containsKey('meaning') ? snapshot['meaning'] : '',
        example =
            snapshot.data().containsKey('example') ? snapshot['example']! : '',
        exampleTranslation = snapshot.data().containsKey('exampleTranslation')
            ? snapshot['exampleTranslation']!
            : '',
        grammar =
            snapshot.data().containsKey('grammar') ? snapshot['grammar']! : '',
        expressionId = snapshot.data().containsKey('expressionId')
            ? snapshot['expressionId']!
            : '',
        addedBy =
            snapshot.data().containsKey('addedBy') ? snapshot['addedBy'] : '',
        addedOn = Utils.toDateTime(snapshot['addedOn'])!,
        updatedOn = Utils.toDateTime(snapshot['updatedOn'])!,
        updatedBy = snapshot.data().containsKey('updatedBy')
            ? snapshot['updatedBy']
            : '',
        state = snapshot['state'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'meaning': meaning,
        'example': example,
        'exampleTranslation': exampleTranslation,
        'grammar': grammar,
        'expressionId': expressionId,
        'addedBy': addedBy,
        'addedOn': Utils.fromDateTimeToJson(addedOn),
        'updatedOn': Utils.fromDateTimeToJson(updatedOn!),
        'updatedBy': updatedBy,
        'state': state,
      };

  @override
  String toString() {
    return 'Meaning{id: $id, meaning: $meaning, example: $example, exampleTranslation: $exampleTranslation, grammar: $grammar, expressionId: $expressionId, addedBy: $addedBy, addedOn: $addedOn, updatedOn: $updatedOn, updatedBy: $updatedBy, state: $state}';
  }
}
