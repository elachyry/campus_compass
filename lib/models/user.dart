import 'models.dart';

class User {
  String id;
  final String name;
  final String email;
  final bool isCompleted;
  final List<Interest> interests;
  String phoneNumber;
  String imageUrl;
  String gender;
  String birthDate;
  String role;
  String department;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.interests,
    this.isCompleted = false,
    this.phoneNumber = "",
    this.imageUrl = "",
    this.gender = "",
    this.birthDate = "",
    this.role = "",
    this.department = "",
  });

  copyWith({
    String? id,
    String? name,
    String? email,
    bool? isCompleted,
    String? phoneNumber,
    String? imageUrl,
    String? gender,
    String? birthDate,
     String? role,
    String? department,
    List<Interest>? interests,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      interests: interests ?? this.interests,
      isCompleted: isCompleted ?? this.isCompleted,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      role: role ?? this.role,
      department: department ?? this.department,
    );
  }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'interests': interests.map((e) => e.toJson()).toList(),
      'isComplited': isCompleted,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'gender': gender,
      'birthDate': birthDate,
      'role': role,
      'department': department,
    };
  }
factory User.fromJson(Map<String, dynamic> json) {
  // print("json user: $json");
    var interestsList = json['interests'] as List<dynamic>;
    List<Interest> parsedInterests = interestsList.map((e) => Interest.fromJson(e)).toList();

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      interests: parsedInterests,
      isCompleted: json['isComplited'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      role: json['role'],
      department: json['department'],
    );
  }
}
