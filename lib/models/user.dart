import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? fcmToken;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber, {
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      map!['id'] as String?,
      map['first_name'] as String,
      map['last_name'] as String,
      map['email'] as String,
      map['phone_number'] as String,
      createdAt: map['created_at'] as Timestamp?,
      updatedAt: map['updated_at'] as Timestamp?,
      fcmToken: map['fcm_token'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'fcm_token': fcmToken,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'fcm_token': fcmToken,
    };
  }
}
