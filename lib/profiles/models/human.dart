class Human {
  Human({required this.name, this.id, this.profilePicPath});

  final String name;
  final String? id;
  final String? profilePicPath;

  factory Human.fromJson(Map<String, dynamic> json, {String? id}) => Human(
        id: id,
        name: json['name'] as String,
        profilePicPath: json['profile_pic_path'] as String,
      );
}
