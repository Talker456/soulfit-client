import '../../domain/entity/user_album_photo.dart';

class UserAlbumPhotoDto {
  final int id;
  final String imageUrl;

  UserAlbumPhotoDto({required this.id, required this.imageUrl});

  factory UserAlbumPhotoDto.fromJson(Map<String, dynamic> json) {
    return UserAlbumPhotoDto(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  UserAlbumPhoto toEntity() {
    return UserAlbumPhoto(
      id: id,
      imageUrl: imageUrl,
    );
  }
}