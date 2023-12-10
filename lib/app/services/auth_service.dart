import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/api/auth.dart';

class AuthService extends GetxService {
  // ------- static methods ------- //
  static AuthService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthService>(() async => AuthService());
  }

// ------- ./static methods ------- //

  final RxBool isLoggedIn = false.obs;
  final RxString uid = ''.obs;

  User? get currentUser => Auth().currentUser;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Auth().authStateChanges.listen((User? user) {
      if (user == null) {
        logout();
        uid.value = '';
      } else {
        login();
        uid.value = user.uid;
      }
    });
  }
}
