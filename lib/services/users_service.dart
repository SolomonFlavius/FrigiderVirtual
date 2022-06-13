import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:frigider_virtual/models/user.dart';

class UsersService {
  static final _users = FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(User user) async {
    await _users.add(user.toMapWithoutId()).then((value) {
      if (kDebugMode) {
        print('User added');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error adding user: $error');
      }
    });
  }

  static Future<void> updateUserFcmToken(String email, String? token) async {
    final userId = await getUserId(email);
    return _users.doc(userId).update({'fcm_token': token}).then((value) {
      if (kDebugMode) {
        print('Token updated!');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error while updating fcm token: $error');
      }
    });
  }

  static Future<String> getUserId(String email) async {
    return _users.where('email', isEqualTo: email).get().then((value) {
      return value.docs[0].id;
    });
  }

  static Future<User?> getUserByEmail(String email) async {
    return _users.where('email', isEqualTo: email).get().then((value) {
      var userMap = value.docs[0].data();
      userMap['id'] = value.docs[0].id;
      return Future<User?>.value(User.fromMap(userMap));
    }).catchError((error) {
      if (kDebugMode) {
        print('Error while getting user by email: $error');
      }
      return Future<User?>.value(null);
    });
  }
}
