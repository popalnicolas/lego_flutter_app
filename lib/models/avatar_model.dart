class AvatarModel
{
  final int avatarId;
  final String avatarName;
  final String avatarImage;

  AvatarModel({required this.avatarId, required this.avatarName, required this.avatarImage});

  static AvatarModel fromJson(json) {
    return AvatarModel(avatarId: json['avatarId'], avatarName: json['avatarName'], avatarImage: json['avatarImage']);
  }
}