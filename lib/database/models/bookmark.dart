import 'package:cloud_firestore/cloud_firestore.dart';

import 'expression.dart';

class Bookmark {
  final String id;
  final String memberId;
  final String expressionId;
  late Expression? expression;

  Bookmark({
    required this.id,
    required this.memberId,
    required this.expressionId,
  });

  Bookmark.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        memberId = json['memberId'],
        expressionId = json['expressionId'];

  Bookmark.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        memberId = snapshot['memberId'],
        expressionId = snapshot['expressionId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'memberId': memberId,
        'expressionId': expressionId,
      };

  @override
  String toString() {
    return 'Bookmark{id: $id, memberId: $memberId, expressionId: $expressionId, expression: $expression}';
  }
}
