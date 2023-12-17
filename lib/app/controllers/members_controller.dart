import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/models/member.dart';
import 'package:kitaabua/main.dart';

import '../../core/configs/colors.dart';
import '../../core/configs/sizes.dart';
import '../../database/api/auth.dart';
import '../../database/api/firebase_api.dart';
import '../ui/widgets/snack.dart';

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
      Snack.success(
          'Guest added successfully with name'.trParams({'name': name}));
      currentMember.value = await FirebaseApi.getMember(value);
      InnerStorage.write(
        'currentMember',
        currentMember.value!.toStringJson(),
      );
    }).catchError((onError) {
      Snack.error(onError.toString());
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
      title: 'Register Guest'.tr,
      content: Column(
        children: [
          TextField(
            controller: nameController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: 'Name'.tr,
              hintText: 'Enter name'.tr,
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              hintStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSizeBoxM),
          TextField(
            controller: emailController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: 'Email'.tr,
              hintText: 'Enter email'.tr,
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              hintStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSizeBoxM),
          TextField(
            controller: passwordController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: 'Password'.tr,
              hintText: 'Enter password'.tr,
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              hintStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel'.tr,
            style: const TextStyle(color: kGreyColor),
          ),
        ),
        TextButton(
          onPressed: () {
            addMember(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            );
          },
          child: Text(
            'Add'.tr,
            style: TextStyle(color: kBackgroundColor),
          ),
        ),
      ],
    );
  }

  void loginMemberDialog() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    Get.defaultDialog(
      title: 'Login as guest'.tr,
      content: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: 'Email'.tr,
              hintText: 'Enter email'.tr,
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              hintStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSizeBoxM),
          TextField(
            controller: passwordController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: 'Password'.tr,
              hintText: 'Enter password'.tr,
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              hintStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'.tr, style: const TextStyle(color: kGreyColor)),
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
                Snack.success('Guest logged in successfully'.tr);
                return;
              }
            }
            if (currentMember.value == null) {
              Snack.error('Guest not found'.tr);
            }
          },
          child: Text('Login'.tr, style: TextStyle(color: kBackgroundColor)),
        ),
      ],
    );
  }

  void logoutMemberDialog() {
    Get.defaultDialog(
      title: 'Logout Guest'.tr,
      content: Text('Are you sure you want to logout as guest ?'.tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            if (InnerStorage.hasData('currentMember')) {
              InnerStorage.remove('currentMember');
              Get.back();
              Snack.success('Guest logged out successfully'.tr);
              currentMember.value = null;
            } else {
              Get.back();
              Snack.error('No guest logged in'.tr);
            }
          },
          child: Text('Logout'.tr),
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
    /* members.listen((p0) {
      if (currentMember.value == null) {
        for (final member in p0) {
          if (member.email == Auth().currentUser?.email &&
              member.state == true) {
            currentMember.value = member;
            InnerStorage.write(
              'currentMember',
              currentMember.value!.toStringJson(),
            );
            break;
          }
        }
      }
    });*/
  }
}
