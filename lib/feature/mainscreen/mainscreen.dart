import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:soulfit_client/feature/dating/main/dating_main.dart';
import 'package:soulfit_client/feature/community/community_main.dart';
import 'package:soulfit_client/feature/mainscreen/group.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';

class _CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xBC37A23C),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of a visual interface.
    return Scaffold(
      // Use a white background color for the entire screen.
      backgroundColor: Colors.white,
      // Use a custom AppBar for the top section.
      appBar: const SharedAppBar(),
      // The main content of the screen.
      body: SingleChildScrollView(
        // Use Padding to create some space around the content.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // Align children to the start (left) of the column.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // 1. Advertisement Banner Button
              _buildAdBanner(context),
              const SizedBox(height: 40),
              // "Category" Title
              const Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // 2 & 3. Category Buttons (Dating & Group)
              _buildCategorySection(context),
              const SizedBox(height: 40),
              // Community Section with a "More" button
              _buildCommunitySection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Standard bottom navigation bar for app navigation.
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: Implement navigation
        },
      ),
    );
  }

  // A private method to build the advertisement banner.
  Widget _buildAdBanner(BuildContext context) {
    // InkWell makes its child tappable and shows a ripple effect.
    return InkWell(
      onTap: () async {
        const url = 'https://www.naver.com/';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          // 실패 시 간단한 에러 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('네이버로 이동할 수 없습니다.')),
          );
        }
      },
      // Use BorderRadius to match the child's rounded corners.
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 184,
        width: double.infinity, // Take up all available width.
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0), // A light grey color.
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: const Color(0xBC37A23C),
            width: 1.5,
          ),
        ),
        child: const Center(
          child: Text(
            '광고',
            style: TextStyle(
              fontSize: 48,
              color: Colors.black26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // A private method to build the category section.
  Widget _buildCategorySection(BuildContext context) {
    // Row lays out its children horizontally.
    return Row(
      children: [
        // Use Expanded so each button takes up equal space.
        Expanded(
          // This is the "Dating" button.
          child: _CategoryButton(
            label: '소개팅',
            icon: Icons.favorite,
            iconColor: Colors.redAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DatingMain()),
              );
            },
          ),
        ),
        const SizedBox(width: 20), // Space between the buttons.
        Expanded(
          // This is the "Group" button.
          child: _CategoryButton(
            label: '모임',
            icon: Icons.groups,
            iconColor: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  // A private method to build the community section.
  Widget _buildCommunitySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '커뮤니티',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityMain()),
                );
              },
              child: const Text(
                '더보기',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Divider(color: Color(0xBC37A23C), thickness: 1.5),
        const SizedBox(height: 12),
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[100],
          child: const Center(
            child: Text('커뮤니티 게시글 내용'),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),
  );
}