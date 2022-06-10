import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UsersService {
  static final _users = FirebaseFirestore.instance.collection('users');

  static Future<void> updateUserFcmToken(String email, String? token) async {
    if (token == null) {
      if (kDebugMode) {
        print('No token provided, skipping update');
      }
      return;
    }
    final userId = await getUserId(email);
    return _users
        .doc(userId)
        .update({'fcm_token': token})
        .then((value) => print('Token updated!'))
        .catchError((error) => print('Error while updating fcm token: $error'));
  }

  static Future<String> getUserId(String email) async {
    return _users.where('email', isEqualTo: email).get().then((value) {
      return value.docs[0].id;
    });
  }
}
