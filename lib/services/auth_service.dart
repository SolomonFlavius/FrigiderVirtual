import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static String? getLoggedInUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }
}
