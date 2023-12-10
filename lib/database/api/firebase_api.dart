import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../core/configs/utils.dart';

class FirebaseApi {
  static CollectionReference<Map<String, dynamic>> get dbCollection =>
      FirebaseFirestore.instance.collection("kitaabua");

  static Stream<List<Expression>> readExpressions() => dbCollection
      .orderBy('word', descending: false)
      .snapshots()
      .transform(Utils.transformer(Expression.fromJson));

  static Future<String> createTodo({
    required String word,
  }) async {
    final docExpression = dbCollection.doc();

    final expression = Expression(
      id: docExpression.id,
      addedOn: DateTime.now(),
      updatedOn: DateTime.now(),
      word: word,
      addedBy: "Kipindo",
      updatedBy: "Suruali",
      state: true,
    );

    await docExpression.set(expression.toJson());

    return docExpression.id;
  }

  static Future updateTodo(Expression expression) async {
    final docExpression = dbCollection.doc(expression.id);
    await docExpression.update(expression.toJson());
  }

  static Future deleteTodo(Expression expression) async {
    final docExpression = dbCollection.doc(expression.id);

    await docExpression.delete();
  }
}
