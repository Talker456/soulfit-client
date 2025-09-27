import '../../domain/entities/recommended_user.dart';

class RecommendedUserModel extends RecommendedUser {
  const RecommendedUserModel({
    required String id,
    required String name,
    required int age,
    required double distance,
    required String profileImageUrl,
    String? bio,
    List<String> interests = const [],
    bool isOnline = false,
  }) : super(
          id: id,
          name: name,
          age: age,
          distance: distance,
          profileImageUrl: profileImageUrl,
          bio: bio,
          interests: interests,
          isOnline: isOnline,
        );

  RecommendedUserModel copyWith({
    String? id,
    String? name,
    int? age,
    double? distance,
    String? profileImageUrl,
    String? bio,
    List<String>? interests,
    bool? isOnline,
  }) {
    return RecommendedUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      distance: distance ?? this.distance,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  factory RecommendedUserModel.fromJson(Map<String, dynamic> json) {
    return RecommendedUserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      distance: (json['distance']).toDouble(),
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : [],
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'distance': distance,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'interests': interests,
      'isOnline': isOnline,
    };
  }

  factory RecommendedUserModel.fromEntity(RecommendedUser entity) {
    return RecommendedUserModel(
      id: entity.id,
      name: entity.name,
      age: entity.age,
      distance: entity.distance,
      profileImageUrl: entity.profileImageUrl,
      bio: entity.bio,
      interests: entity.interests,
      isOnline: entity.isOnline,
    );
  }
}