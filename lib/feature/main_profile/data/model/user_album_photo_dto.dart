
class UserAlbumPhotoDto {
  final int id;
  final String imageUrl;

  UserAlbumPhotoDto({
    required this.id,
    required this.imageUrl,
  });

  factory UserAlbumPhotoDto.fromJson(Map<String, dynamic> json) {
    return UserAlbumPhotoDto(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }
}
