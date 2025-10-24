import 'package:flutter/material.dart';
import 'dart:math';

class SwipeLikeScreen extends StatefulWidget {
  const SwipeLikeScreen({super.key});

  @override
  State<SwipeLikeScreen> createState() => _SwipeLikeScreenState();
}

class _SwipeLikeScreenState extends State<SwipeLikeScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> users = [
    {
      'name': '파랑님',
      'img': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      // 'tags': ['다정한', '활발한', '신중한'], // Removed tags
    },
    {
      'name': '하늘님',
      'img': 'https://cdn-icons-png.flaticon.com/512/4140/4140048.png',
      // 'tags': ['귀여운', '쿨한', '재치있는'], // Removed tags
    },
    {
      'name': '보라님',
      'img': 'https://cdn-icons-png.flaticon.com/512/921/921071.png',
      // 'tags': ['적극적', '긍정적', '무뚝뚝'], // Removed tags
    },
  ];

  int currentIndex = 0;
  Offset cardOffset = Offset.zero;
  double rotation = 0.0;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      cardOffset += details.delta;
      rotation = cardOffset.dx / 300;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (cardOffset.dx > screenWidth * 0.25) {
      _accept();
    } else if (cardOffset.dx < -screenWidth * 0.25) {
      _reject();
    } else {
      setState(() {
        cardOffset = Offset.zero;
        rotation = 0;
      });
    }
  }

  void _accept() {
    _nextCard();
  }

  void _reject() {
    _nextCard();
  }

  void _nextCard() {
    setState(() {
      if (currentIndex < users.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      cardOffset = Offset.zero;
      rotation = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = users[currentIndex];
    // final tags = user['tags'] as List<String>; // Removed tags

    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text('스와이프 하러가기'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: cardOffset,
              child: Transform.rotate(
                angle: rotation * pi / 8,
                child: GestureDetector(
                  onPanUpdate: _onDragUpdate,
                  onPanEnd: _onDragEnd,
                  child: _ProfileCard(
                    name: user['name'],
                    img: user['img'],
                    // tags: tags, // Removed tags
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 60,
              child: FloatingActionButton(
                heroTag: 'reject',
                onPressed: _reject,
                backgroundColor: Colors.white,
                child: const Icon(Icons.close, color: Colors.black, size: 32),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 60,
              child: FloatingActionButton(
                heroTag: 'like',
                onPressed: _accept,
                backgroundColor: const Color(0xFFFF4DA6),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name;
  final String img;
  // final List<String> tags; // Removed tags

  const _ProfileCard({
    required this.name,
    required this.img,
    // required this.tags, // Removed tags
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 480,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(child: Image.network(img, fit: BoxFit.contain)),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                // Text( // Removed tags display
                //   '#${tags.join(' #')}',
                //   style: const TextStyle(color: Colors.white70),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
