import '../../domain/entities/first_impression_vote.dart';

class FirstImpressionVoteModel extends FirstImpressionVote {
  const FirstImpressionVoteModel({
    required String id,
    required String userId,
    required String userName,
    required String message,
    required String userProfileImageUrl,
    required DateTime createdAt,
    bool isRead = false,
  }) : super(
          id: id,
          userId: userId,
          userName: userName,
          message: message,
          userProfileImageUrl: userProfileImageUrl,
          createdAt: createdAt,
          isRead: isRead,
        );

  FirstImpressionVoteModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? message,
    String? userProfileImageUrl,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return FirstImpressionVoteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  factory FirstImpressionVoteModel.fromJson(Map<String, dynamic> json) {
    return FirstImpressionVoteModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      message: json['message'],
      userProfileImageUrl: json['userProfileImageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'message': message,
      'userProfileImageUrl': userProfileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory FirstImpressionVoteModel.fromEntity(FirstImpressionVote entity) {
    return FirstImpressionVoteModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      message: entity.message,
      userProfileImageUrl: entity.userProfileImageUrl,
      createdAt: entity.createdAt,
      isRead: entity.isRead,
    );
  }
}