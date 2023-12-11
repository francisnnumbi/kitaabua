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
  bool get isLoggedIn => currentMember.value != null;

  void addMember({
    required String name,
    required String email,
    required String password,
    String? userId,
  }) {
    FirebaseApi.createMember(
      name: name,
      email: email,
      password: password,
    ).then((value) async {
      Get.back();
      Get.snackbar('Success', 'Guest added successfully with id: $name');
      currentMember.value = await FirebaseApi.getMember(value);
      InnerStorage.write(
        'currentMember',
        currentMember.value!.toStringJson(),
      );
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
      currentMember.value = null;
    });
  }

  void addMemberDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    if (Auth().currentUser != null) {
      emailController.text = Auth().currentUser!.email!;
    }
    Get.defaultDialog(
      title: 'Register Guest',
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
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
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
              password: passwordController.text,
            );
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void loginMemberDialog() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    Get.defaultDialog(
      title: 'Login as guest',
      content: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter email',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
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
            for (final member in members) {
              if (member.email == emailController.text &&
                  member.password == passwordController.text &&
                  member.state == true) {
                currentMember.value = member;
                InnerStorage.write(
                  'currentMember',
                  currentMember.value!.toStringJson(),
                );
                Get.back();
                Get.snackbar('Success', 'Guest logged in successfully');
                return;
              }
            }
            if (currentMember.value == null) {
              Get.snackbar('Error', 'Guest not found');
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  void logoutMemberDialog() {
    Get.defaultDialog(
      title: 'Logout Guest',
      content: const Text('Are you sure you want to logout as guest ?'),
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
              Get.snackbar('Success', 'Guest logged out successfully');
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
      try {
        currentMember.value =
            Member.fromStringJson(InnerStorage.read('currentMember'));
      } catch (e) {
        InnerStorage.remove('currentMember');
      }
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
              currentMember.value!.toStringJson(),
            );
            break;
          }
        }
      }
    });
  }
}
