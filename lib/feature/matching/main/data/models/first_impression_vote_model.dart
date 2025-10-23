import '../../domain/entities/first_impression_vote.dart';

class FirstImpressionVoteModel extends FirstImpressionVote {
  const FirstImpressionVoteModel({
    required int id,
    required int creatorId,
    required String creatorUsername,
    required String title,
    String? creatorProfileImageUrl,
    bool isRead = false,
  }) : super(
          id: id,
          creatorId: creatorId,
          creatorUsername: creatorUsername,
          title: title,
          creatorProfileImageUrl: creatorProfileImageUrl,
          isRead: isRead,
        );

  FirstImpressionVoteModel copyWith({
    int? id,
    int? creatorId,
    String? creatorUsername,
    String? title,
    String? creatorProfileImageUrl,
    bool? isRead,
  }) {
    return FirstImpressionVoteModel(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      title: title ?? this.title,
      creatorProfileImageUrl: creatorProfileImageUrl ?? this.creatorProfileImageUrl,
      isRead: isRead ?? this.isRead,
    );
  }

  factory FirstImpressionVoteModel.fromJson(Map<String, dynamic> json) {
    return FirstImpressionVoteModel(
      id: json['id'],
      creatorId: json['creatorId'],
      creatorUsername: json['creatorUsername'],
      title: json['title'],
      creatorProfileImageUrl: json['creatorProfileImageUrl'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'creatorUsername': creatorUsername,
      'title': title,
      'creatorProfileImageUrl': creatorProfileImageUrl,
      'isRead': isRead,
    };
  }

  factory FirstImpressionVoteModel.fromEntity(FirstImpressionVote entity) {
    return FirstImpressionVoteModel(
      id: entity.id,
      creatorId: entity.creatorId,
      creatorUsername: entity.creatorUsername,
      title: entity.title,
      creatorProfileImageUrl: entity.creatorProfileImageUrl,
      isRead: entity.isRead,
    );
  }
}