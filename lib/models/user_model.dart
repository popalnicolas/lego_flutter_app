class UserModel
{
  final int userId;
  final String userEmail;
  final String access_token;
  final String avatar;

  UserModel({required this.userId, required this.userEmail, required this.access_token, required this.avatar});

  static UserModel fromJson(json)
  {
    return UserModel(userId: json['userId'], userEmail: json['userEmail'], access_token: json['access_token'], avatar: json['avatar']);
  }

  static Map<String, dynamic> toJson(UserModel user) {
    Map<String, dynamic> jsonMap = {
      "userId": user.userId,
      "userEmail": user.userEmail,
      "access_token": user.access_token,
      "avatar": user.avatar
    };

    return jsonMap;
  }
}