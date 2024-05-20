class TeacherUserModel {
  String teacherId;
  String image;
  String fullName;
  String email;
  String number;

  TeacherUserModel({
    required this.teacherId,
    required this.image,
    required this.fullName,
    required this.email,
    required this.number,
  });

  factory TeacherUserModel.fromJson(Map<String, dynamic> json) {
    return TeacherUserModel(
      teacherId: json['teacherId'] as String,
      image: json['image'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      number: json['number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId':teacherId,
      'image': image,
      'fullName': fullName,
      'email': email,
      'number': number,
    };
  }
}
