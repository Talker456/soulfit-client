import 'package:flutter/material.dart';

// 커뮤니티 게시글 데이터를 담을 간단한 모델 클래스
class Post {
  final String title;
  final String content;
  final String author;
  final int likeCount;
  final int commentCount;

  Post({
    required this.title,
    required this.content,
    required this.author,
    required this.likeCount,
    required this.commentCount,
  });
}

class CommunityMain extends StatelessWidget {
  // 예시용 더미 데이터 목록
  final List<Post> posts = [
    Post(
        title: '오늘부터 헬스 시작합니다!',
        content: '다들 같이 운동해요~ 득근득근!',
        author: '헬린이',
        likeCount: 15,
        commentCount: 8),
    Post(
        title: '주말에 등산 가실 분?',
        content: '관악산 코스 생각하고 있습니다. 초보자도 환영합니다.',
        author: '산악인',
        likeCount: 22,
        commentCount: 12),
    Post(
        title: '다이어트 식단 공유해요',
        content: '요즘 닭가슴살이랑 현미밥만 먹는데 너무 힘드네요 ㅠㅠ 다른 분들은 어떻게 드시나요?',
        author: '다이어터',
        likeCount: 48,
        commentCount: 25),
    Post(
        title: '소울핏에서 만난 인연!',
        content: '여기서 만난 분이랑 잘 돼서 연애 시작했습니다. 다들 좋은 인연 만나시길!',
        author: '성공한사람',
        likeCount: 102,
        commentCount: 34),
  ];

  CommunityMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 상단 바
      appBar: AppBar(
        title: const Text('커뮤니티'),
        backgroundColor: const Color(0xFF79C72B), // 메인 테마 색상
      ),
      // 화면 본문
      body: ListView.builder(
        itemCount: posts.length, // 목록에 표시할 아이템 개수
        itemBuilder: (context, index) {
          final post = posts[index];
          // 각 게시글을 카드 형태로 보여주는 위젯
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2, // 카드에 약간의 그림자 효과
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 제목
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 게시글 내용
                  Text(
                    post.content,
                    maxLines: 2, // 내용은 최대 2줄까지만 보여줌
                    overflow: TextOverflow.ellipsis, // 내용이 길면 ... 처리
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const Divider(height: 24), // 구분선
                  // 작성자, 좋아요, 댓글 정보
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '작성자: ${post.author}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.favorite_border,
                              size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Text('${post.likeCount}'),
                          const SizedBox(width: 16),
                          const Icon(Icons.chat_bubble_outline,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text('${post.commentCount}'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // 화면 오른쪽 아래에 떠 있는 글쓰기 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글쓰기 버튼을 눌렀을 때의 동작
          print('글쓰기 버튼 클릭!');
        },
        backgroundColor: const Color(0xFF79C72B),
        child: const Icon(Icons.edit),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CommunityMain(),
    ),
  );
}