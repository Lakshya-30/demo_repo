import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String profilePic;
  final String about;
  final DateTime timeCreated;
  final DateTime lastSeen;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.about,
    required this.timeCreated,
    required this.lastSeen,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'about': about,
    'profilePic': profilePic,
    'email': email,
    'timeCreated': timeCreated,
    'lastSeen': lastSeen,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'],
    email: json['email'],
    profilePic: json['profilePic'],
    about: json['about'],
    timeCreated: (json['timeCreated'] as Timestamp).toDate(),
    lastSeen: (json['lastSeen'] as Timestamp).toDate(),
  );
}
