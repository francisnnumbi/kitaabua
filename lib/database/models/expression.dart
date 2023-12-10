import '../../core/configs/utils.dart';

class Expression {
  final String id;
  final String word;
  final String addedBy;
  final DateTime addedOn;
  late DateTime? updatedOn;
  late String? updatedBy;
  late bool? state;
  late Map<String, dynamic>? meanings;

  Expression({
    required this.id,
    required this.word,
    required this.addedBy,
    required this.addedOn,
    this.updatedOn,
    this.updatedBy,
    this.state,
    this.meanings,
  });

  Expression.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        word = json['word'],
        addedBy = json['addedBy'],
        addedOn = Utils.toDateTime(json['addedOn'])!,
        updatedOn = Utils.toDateTime(json['updatedOn'])!,
        updatedBy = json['updatedBy'],
        state = json['state'],
        meanings = json['meanings'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'addedBy': addedBy,
        'addedOn': Utils.fromDateTimeToJson(addedOn),
        'updatedOn': Utils.fromDateTimeToJson(updatedOn!),
        'updatedBy': updatedBy,
        'state': state,
        'meanings': meanings,
      };
}