class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  /// FROM JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      version: json['__v'] as int?,
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }
}
