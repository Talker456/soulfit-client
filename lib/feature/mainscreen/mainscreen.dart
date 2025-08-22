import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // For screen navigation
import 'package:url_launcher/url_launcher.dart';
import 'package:soulfit_client/feature/dating/main/dating_main.dart';
import 'package:soulfit_client/feature/community/community_main.dart';
import 'package:soulfit_client/feature/mainscreen/group.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of a visual interface.
    return Scaffold(
      // Use a white background color for the entire screen.
      backgroundColor: Colors.white,
      // Use a custom AppBar for the top section.
      appBar: _buildAppBar(context),
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // A private method to build the AppBar.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      // Remove the shadow under the app bar.
      elevation: 0,
      backgroundColor: Colors.white,
      // The title of the app bar, which is the logo.
      title: const Text(
        'soulfit',
        style: TextStyle(
          color: Color(0xBC37A23C),
          fontSize: 28,
          fontFamily: 'Arima Madurai',
          fontWeight: FontWeight.w700,
        ),
      ),
      // Icons on the right side of the app bar.
      actions: [
        IconButton(
          icon: const Icon(Icons.send_outlined, color: Colors.black54),
          onPressed: () {
            print('Send button tapped!');
          },
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black54),
          onPressed: () {
            print('Search button tapped!');
          },
        ),
      ],
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
                MaterialPageRoute(builder: (context) => const DatingScreen()),
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
            // This makes the "More" text tappable.
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityScreen()),
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
        // The line under the community title.
        const Divider(color: Color(0xBC37A23C), thickness: 1.5),
        const SizedBox(height: 12),
        // Placeholder for community posts.
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

  // A private method to build the bottom navigation bar.
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      // Set type to fixed to see all labels.
      type: BottomNavigationBarType.fixed,
      // The index of the currently selected item.
      currentIndex: 0,
      // The color of the selected icon and label.
      selectedItemColor: const Color(0xBC37A23C),
      // The color of unselected icons and labels.
      unselectedItemColor: Colors.grey,
      // Remove the text labels for a cleaner look.
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Alerts'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      onTap: (index) {
        // Handles tap events on the navigation bar items.
        print('Tapped item $index');
      },
    );
  }
}

// A reusable custom widget for the category buttons.
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 120, // Set a fixed height for the button.
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: const Color(0xBC37A23C),
            width: 1.5,
          ),
          // Add a subtle shadow.
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          // Center the content vertically and horizontally.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 40),
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
    );
  }
}
