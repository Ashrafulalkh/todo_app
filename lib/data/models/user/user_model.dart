class UserModel {
  String id;
  DateTime createdAt;
  String firstName;
  String lastName;
  String email;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // Factory constructor for creating a User instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  // Convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}
