import 'package:flutter/material.dart';

/// 반쪽 별을 그리기 위한 커스텀 클리퍼
class HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

/// 별점 표시 위젯 (소수점 지원)
class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // 완전한 별
          return Icon(
            Icons.star,
            color: Colors.amber,
            size: size,
          );
        } else if (index == rating.floor() && rating % 1 != 0) {
          // 반쪽 별
          return Stack(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.amber,
                size: size,
              ),
              ClipRect(
                clipper: HalfStarClipper(),
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: size,
                ),
              ),
            ],
          );
        } else {
          // 빈 별
          return Icon(
            Icons.star_border,
            color: Colors.amber,
            size: size,
          );
        }
      }),
    );
  }
}
