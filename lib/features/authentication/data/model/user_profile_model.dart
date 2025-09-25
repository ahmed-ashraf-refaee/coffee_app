class UserProfileModel {
  final String id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String? customerId;
  final String? profileImageUrl;

  UserProfileModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.customerId,
    this.profileImageUrl,
  });
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      customerId: json['customer_id'],
      profileImageUrl: json['profile_image_url'],
    );
  }
}
