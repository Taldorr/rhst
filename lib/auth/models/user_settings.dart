class UserSettings {
  const UserSettings({
    required this.firstName,
    required this.lastName,
    this.profilePicPath,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profilePicPath: json['profile_pic_path'] as String?,
      );

  final String firstName;

  final String lastName;

  final String? profilePicPath;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'profile_pic_path': profilePicPath,
      };

  UserSettings copyWith({String? firstName, String? lastName, String? profilePicPath}) =>
      UserSettings(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profilePicPath: profilePicPath ?? this.profilePicPath,
      );
}
