
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/main_profile/domain/entity/user_album_photo.dart';

class AlbumSection extends StatelessWidget {
  final List<UserAlbumPhoto> photos;

  const AlbumSection({
    super.key,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("앨범",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                photos[i].imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
