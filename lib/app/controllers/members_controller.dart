import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/models/member.dart';
import 'package:kitaabua/main.dart';

import '../../database/api/auth.dart';
import '../../database/api/firebase_api.dart';

class MembersController extends GetxController {
  // ------- static methods ------- //
  static MembersController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<MembersController>(() async => MembersController());
  }

// ------- ./static methods ------- //

  final RxList<Member> members = <Member>[].obs;
  final Rxn<Member> currentMember = Rxn<Member>();

/*
  openExpression({Expression? expression}) async {
    this.expression.value = expression;
    Get.toNamed(AddEditPage.route);
  }
*/

  void addMember({
    required String name,
    required String email,
    String? userId,
  }) {
    FirebaseApi.createMember(
      name: name,
      email: email,
    ).then((value) async {
      Get.back();
      Get.snackbar('Success', 'Member added successfully with id: $value');
      currentMember.value = await FirebaseApi.getMember(value);
      InnerStorage.write(
        'currentMember',
        currentMember.toJson(),
      );
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
      currentMember.value = null;
    });
  }

  void addMemberDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    if (Auth().currentUser != null) {
      emailController.text = Auth().currentUser!.email!;
    }
    Get.defaultDialog(
      title: 'Add Member',
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter name',
            ),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter email',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            addMember(
              name: nameController.text,
              email: emailController.text,
            );
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void logoutMemberDialog() {
    Get.defaultDialog(
      title: 'Logout',
      content: const Text('Are you sure you want to logout as member?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            currentMember.value!.state = false;
            FirebaseApi.updateMember(
              currentMember.value!,
            ).then((value) async {
              Get.back();
              Get.snackbar('Success', 'Member logged out successfully');
              currentMember.value = null;
              InnerStorage.remove('currentMember');
            }).catchError((onError) {
              Get.snackbar('Error', onError.toString());
            });
            /*currentMember.value = null;
            InnerStorage.remove('currentMember');
            Get.back();*/
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  Future<void> initializeBindings() async {
    members.bindStream(FirebaseApi.readMembers());
  }

  @override
  void onReady() {
    if (InnerStorage.hasData('currentMember')) {
      currentMember.value = Member.fromJson(InnerStorage.read('currentMember'));
    }
    super.onReady();
    initializeBindings();
    members.listen((p0) {
      if (currentMember.value == null) {
        for (final member in p0) {
          if (member.email == Auth().currentUser?.email && member.state == 1) {
            currentMember.value = member;
            InnerStorage.write(
              'currentMember',
              currentMember.toJson(),
            );
            break;
          }
        }
      }
    });
  }
}
