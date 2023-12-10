import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../core/configs/utils.dart';
import '../models/meaning.dart';

class FirebaseApi {
  static CollectionReference<Map<String, dynamic>> get dbCollection =>
      FirebaseFirestore.instance.collection("kitaabua");

  static Stream<List<Expression>> readExpressions() => dbCollection
      .orderBy('word', descending: false)
      .snapshots()
      .transform(Utils.transformer(Expression.fromJson));

  static Future<String> createExpression({
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

  static Future updateExpression(Expression expression) async {
    final docExpression = dbCollection.doc(expression.id);
    await docExpression.update(expression.toJson());
  }

  static Future deleteExpression(Expression expression) async {
    final docExpression = dbCollection.doc(expression.id);

    await docExpression.delete();
  }

// Reading meaning as per expression id
  static Future<List<Meaning>> futureReadMeanings(String document_id) async {
    QuerySnapshot<Map<String, dynamic>> qs =
        await dbCollection.doc(document_id).collection('meanings').get();

    return qs.docs.map((e) => Meaning.fromSnapshot(e)).toList();
  }

  static Stream<List<Meaning>> readMeanings(String expressionId) => dbCollection
      .doc(expressionId)
      .collection('meanings')
      .orderBy('meaning', descending: false)
      .snapshots()
      .transform(Utils.transformer(Meaning.fromJson));

  static Future<String> createMeaning({
    required String expressionId,
    required String meaning,
    required String example,
    required String exampleTranslation,
    required String grammar,
  }) async {
    final docMeaning =
        dbCollection.doc(expressionId).collection('meanings').doc();

    final meaningData = Meaning(
      id: docMeaning.id,
      addedOn: DateTime.now(),
      updatedOn: DateTime.now(),
      meaning: meaning,
      example: example,
      exampleTranslation: exampleTranslation,
      grammar: grammar,
      addedBy: "Kipindo",
      updatedBy: "Suruali",
      state: true,
    );

    await docMeaning.set(meaningData.toJson());

    return docMeaning.id;
  }

  static Future updateMeaning(Meaning meaning, String expressionId) async {
    final docMeaning =
        dbCollection.doc(expressionId).collection('meanings').doc(meaning.id);
    await docMeaning.update(meaning.toJson());
  }

  static Future deleteMeaning(Meaning meaning, String expressionId) async {
    final docMeaning =
        dbCollection.doc(expressionId).collection('meanings').doc(meaning.id);

    await docMeaning.delete();
  }
}
