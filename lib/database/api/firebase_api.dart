import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/core/configs/dictionaries.dart';
import 'package:kitaabua/database/api/auth.dart';
import 'package:kitaabua/database/models/expression.dart';
import 'package:kitaabua/main.dart';

import '../../core/configs/utils.dart';
import '../models/meaning.dart';
import '../models/member.dart';

class FirebaseApi {
  static CollectionReference<Map<String, dynamic>> get dbCollection {
    final dict = InnerStorage.read('dictionary') ?? Dictionaries.KITAABUA;
    return FirebaseFirestore.instance.collection(dict);
  }

  static CollectionReference<Map<String, dynamic>> get memberCollection =>
      FirebaseFirestore.instance.collection("members");

  static CollectionReference<Map<String, dynamic>> bookmarkCollection(
          String documentId) =>
      dbCollection.doc(documentId).collection("bookmarks");

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
      addedBy: Auth().currentUser!.email!,
      updatedBy: Auth().currentUser!.email!,
      state: true,
    );

    await docExpression.set(expression.toJson());

    return docExpression.id;
  }

  static Future<Expression?> getExpression(String expressionId) async {
    final dd = await dbCollection.doc(expressionId).get();
    return dd.data() == null ? null : Expression.fromJson(dd.data()!);
  }

  static Future updateExpression(Expression expression) async {
    expression.updatedOn = DateTime.now();
    expression.updatedBy = Auth().currentUser!.email!;
    final docExpression = dbCollection.doc(expression.id);
    await docExpression.update(expression.toJson());
  }

  static Future deleteExpression(Expression expression) async {
    final docExpression = dbCollection.doc(expression.id);

    await docExpression.delete();
  }

// Reading meaning as per expression id
  static Future<List<Meaning>> futureReadMeanings(String documentId) async {
    QuerySnapshot<Map<String, dynamic>> qs =
        await dbCollection.doc(documentId).collection('meanings').get();

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
      expressionId: expressionId,
      addedBy: Auth().currentUser!.email!,
      updatedBy: Auth().currentUser!.email!,
      state: true,
    );

    await docMeaning.set(meaningData.toJson());

    return docMeaning.id;
  }

  static Future updateMeaning(
      {required Meaning meaning, required String expressionId}) async {
    meaning.updatedOn = DateTime.now();
    meaning.updatedBy = Auth().currentUser!.email!;
    final docMeaning =
        dbCollection.doc(expressionId).collection('meanings').doc(meaning.id);

    await docMeaning.update(meaning.toJson());
  }

  static Future deleteMeaning(Meaning meaning, String expressionId) async {
    final docMeaning =
        dbCollection.doc(expressionId).collection('meanings').doc(meaning.id);

    await docMeaning.delete();
  }

// Handling members
  static Stream<List<Member>> readMembers() => memberCollection
      .orderBy('name', descending: false)
      .snapshots()
      .transform(Utils.transformer(Member.fromJson));

  static Future<String> createMember({
    required String name,
    required String email,
    required String password,
    String? userId,
  }) async {
    final docMember = memberCollection.doc();

    final member = Member(
      id: docMember.id,
      addedOn: DateTime.now(),
      name: name,
      email: email,
      password: password,
      role: 'guest',
      userId: Auth().uid,
      state: true,
    );

    await docMember.set(member.toJson());

    return docMember.id;
  }

  static Future<Member> getMember(String id) async {
    final docMember = memberCollection.doc(id);
    final member = await docMember.get();
    return Member.fromJson(member.data()!);
  }

  static Future updateMember(Member member) async {
    final docMember = memberCollection.doc(member.id);
    await docMember.update(member.toJson());
  }

  static Future deleteMember(Member member) async {
    final docMember = memberCollection.doc(member.id);

    await docMember.delete();
  }

// Handle bookmarks
/*  static Stream<List<Bookmark>> readBookmarks() {
    if (kDebugMode) {
      print('READ BOOKMARK :: ${dbCollection.doc().path}');
    }
    var db = dbCollection
        .doc()
        .collection('bookmarks')
        //   .where('memberId',
        //      isEqualTo: MembersController.to.currentMember.value?.id)
        .snapshots()
        .transform(
          Utils.transformer(Bookmark.fromJson),
        );

    return db;
  }*/

  static Future<String> _createBookmark({
    required String expressionId,
  }) async {
    final docBookmark = bookmarkCollection(expressionId).doc();

    final bookmark = {
      'id': docBookmark.id,
      'expressionId': expressionId,
      'memberId': MembersController.to.currentMember.value!.id,
    };

    await docBookmark.set(bookmark);

    return docBookmark.id;
  }

  static Future toggleBookmark(Expression expression) async {
    final docBookmark = (await bookmarkCollection(expression.id)
            .where('expressionId', isEqualTo: expression.id)
            .where('memberId',
                isEqualTo: MembersController.to.currentMember.value!.id)
            .get())
        .docs
        .firstOrNull;

    if (docBookmark != null && docBookmark.exists) {
      await docBookmark.reference.delete();
    } else {
      await _createBookmark(expressionId: expression.id);
    }
  }

  static Future isBookmarked(Expression expression) async {
    final docBookmark = (await bookmarkCollection(expression.id)
            .where('expressionId', isEqualTo: expression.id)
            .where('memberId',
                isEqualTo: MembersController.to.currentMember.value?.id)
            .get())
        .docs
        .firstOrNull;

    return docBookmark != null && docBookmark.exists;
  }
}
