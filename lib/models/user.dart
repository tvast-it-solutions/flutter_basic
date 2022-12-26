class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json["_id"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      createdAt:
          json['createdAt'] == null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] == null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
