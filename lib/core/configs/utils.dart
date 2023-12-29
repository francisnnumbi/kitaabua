import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kitaabua/database/models/bookmark.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../database/api/firebase_api.dart';

class Utils {
  static void consoleLog(Object? object) {
    if (kDebugMode) print(object);
  }

  /// Hide the soft keyboard.
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static DateTime? stringToDateTime(String? value) {
    if (value == null) return null;

    return DateTime.tryParse(value);
  }

  static dynamic fromDateTimeToStringJson(DateTime? date) {
    if (date == null) return null;

    return date.toIso8601String();
  }

  static DateTime? toDateTime(Timestamp? value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot data, EventSink<List<T>> sink) async {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final objects = snaps
                  .map((jsn) => fromJson(jsn as Map<String, dynamic>))
                  .toList();
              for (T obj in objects) {
                if (obj is Expression) {

                  obj.meanings = await FirebaseApi.futureReadMeanings(obj.id);
                  obj.isBookmarked = await FirebaseApi.isBookmarked(obj);
                }
                if (obj is Bookmark) {
                  obj.expression =
                      await FirebaseApi.getExpression(obj.expressionId);
                }
              }

              sink.add(objects);
            },
          );
}
