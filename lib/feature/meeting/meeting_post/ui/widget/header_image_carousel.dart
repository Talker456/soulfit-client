import 'package:flutter/material.dart';

class HeaderImageCarousel extends StatefulWidget {
  final List<String> images;
  const HeaderImageCarousel({super.key, required this.images});

  @override
  State<HeaderImageCarousel> createState() => _HeaderImageCarouselState();
}

class _HeaderImageCarouselState extends State<HeaderImageCarousel> {
  final _page = PageController();
  int _idx = 0;

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _page,
          itemCount: widget.images.length,
          onPageChanged: (i) => setState(() => _idx = i),
          itemBuilder:
              (_, i) => Image.network(widget.images[i], fit: BoxFit.cover),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_idx + 1}/${widget.images.length}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
