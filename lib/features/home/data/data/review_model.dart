class ReviewModel {
  final int id;
  final int productId;
  final String userId;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      userId: json['user_id'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      firstName: json['users']['first_name'] as String,
      lastName: json['users']['last_name'] as String,
      profileImageUrl: json['users']['profile_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'users': {
        'first_name': firstName,
        'last_name': lastName,
        'profile_image_url': profileImageUrl,
      },
    };
  }
}
