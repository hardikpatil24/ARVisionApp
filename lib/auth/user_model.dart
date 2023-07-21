class UserModel {
  String? name;
  String? email, userId, userPhone;
  UserModel({this.name, this.email, this.userId, this.userPhone});
  Map<String, dynamic> asMap() {
    return {
      'name': name ?? '',
      'email': email ?? '',
      'userId': userId ?? '',
      'userPhone': userPhone ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      userId: map['userId'],
      email: map['email'],
      userPhone: map['userPhone'],
    );
  }
}
