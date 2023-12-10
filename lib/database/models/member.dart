import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/configs/utils.dart';

class Member {
  final String id;
  final String name;
  final String email;
  final String? userId;
  final String role;
  final DateTime addedOn;
  late bool? state = true;

  Member({
    required this.id,
    required this.name,
    required this.email,
    this.userId,
    required this.role,
    required this.addedOn,
    this.state,
  });

  Member.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        userId = json['userId'],
        role = json['role'],
        addedOn = Utils.toDateTime(json['addedOn'])!,
        state = json['state'];

  Member.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        name = snapshot['name'],
        email = snapshot['email'],
        userId = snapshot['userId'],
        role = snapshot['role'],
        addedOn = Utils.toDateTime(snapshot['addedOn'])!,
        state = snapshot['state'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'userId': userId,
        'role': role,
        'addedOn': Utils.fromDateTimeToJson(addedOn),
        'state': state,
      };

  @override
  String toString() {
    return 'Member{id: $id, name: $name, email: $email, userId: $userId, role: $role, addedOn: $addedOn, state: $state}';
  }
}
