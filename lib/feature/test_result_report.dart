import 'package:flutter/material.dart';
import 'dart:math' as math;

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
// 프론트엔드와 백엔드는 이 구조대로 데이터를 주고받기로 약속합니다.
class AnalysisReport {
  final String aiSummary;
  final Tendency tendency1;
  final Tendency tendency2;
  final Map<String, double> preferredKeywords; // Key: 키워드, Value: 비율(0.0 ~ 1.0)
  final Map<String, double> preferredDurations; // Key: 기간, Value: 비율(0.0 ~ 1.0)
  final String keywordSummary;
  final String durationSummary;
  final String overallSummary;

  AnalysisReport({
    required this.aiSummary,
    required this.tendency1,
    required this.tendency2,
    required this.preferredKeywords,
    required this.preferredDurations,
    required this.keywordSummary,
    required this.durationSummary,
    required this.overallSummary,
  });
}

class Tendency {
  final String title;
  final String subtitle;
  final double value; // 0.0 ~ 1.0
  final String description;

  Tendency({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.description,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
// 백엔드 API가 완성되기 전까지 이 가짜 데이터를 사용해서 UI를 만듭니다.
final dummyReport = AnalysisReport(
  aiSummary:
      'OO님은 개인적 성장과 성취, 그리고 물질적 안정을 중요하게 여기며, 동시에 변화와 도전을 두려워하지 않는 실용적인 가치관을 가지고 있습니다. 이는 현재의 삶에 만족하며 현실을 중요하게 생각해...',
  tendency1: Tendency(
    title: '성향 분석 1',
    subtitle: '개인적 성장',
    value: 0.8, // 80%
    description:
        'OO님은 성공을 ‘개인적인 목표 달성, 여가 시간을 새로운 지식 습득이나 기술 개발에 투자하는 것’으로 여기며, 이를 통해...',
  ),
  tendency2: Tendency(
    title: '성향 분석 2',
    subtitle: '물질적 안정',
    value: 0.65, // 65%
    description:
        'OO님은 직접 선택 시 ‘안정적인 수입과 복지 혜택을 최우선으로 고려하는 점’에서 물질적 안정을 중요하게 생각합니다...',
  ),
  preferredKeywords: {
    '키워드 1': 0.9, // 90%
    '키워드 2': 0.75, // 75%
    '키워드 3': 0.5, // 50%
    '키워드 4': 0.3, // 30%
  },
  preferredDurations: {
    '1달': 0.1, // 10%
    '1-3달': 0.4, // 40%
    '3-6달': 0.3, // 30%
    '6-1년': 0.15, // 15%
    '1년 이상': 0.05, // 5%
  },
  keywordSummary: 'OO님은 [키워드 1]이 포함된 모임을 제일 깊이 참여했어요.',
  durationSummary: 'OO님은 1-3달 기간의 여행 모임을 가장 많이 참여했어요.',
  overallSummary: 'OO님의 활동에 따르면, OO님의 모임 참여 스타일은...',
);

// --- 3. 화면을 그리는 메인 위젯 ---
class AnalysisReportScreen extends StatelessWidget {
  // 실제 앱에서는 이 데이터를 외부에서 받아오게 됩니다.
  final AnalysisReport report;

  const AnalysisReportScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                // soulfit 로고 (밑줄 제거)
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'soulfit',
                    style: TextStyle(
                      color: Color(0xBC37A13C),
                      fontSize: 32,
                      fontFamily: 'Arima Madurai',
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // 뒤로가기 + 가치관 분석 리포트 (중앙 정렬)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      ),
                      const SizedBox(width: 2),
                      const Expanded(
                        child: Text(
                          '가치관 분석 리포트',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: 48), // 아이콘 버튼과 균형 맞추기 위한 여백
                    ],
                  ),
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryCard(report.aiSummary),
            const SizedBox(height: 20),
            _buildDetailAnalysisCard(report.tendency1, report.tendency2),
            const SizedBox(height: 20),
            _buildParticipationCard(report),
          ],
        ),
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // AI 분석 요약 카드
  Widget _buildSummaryCard(String summary) {
    return _buildBaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI 분석 요약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(summary, style: TextStyle(color: Colors.grey[700], height: 1.5)),
        ],
      ),
    );
  }

  // 가치관 상세 분석 카드
  Widget _buildDetailAnalysisCard(Tendency t1, Tendency t2) {
    return _buildBaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('가치관 상세 분석',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              OutlinedButton(
                onPressed: () {},
                child: const Text('가치관 검사 확인'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTendencySection(t1),
          const SizedBox(height: 20),
          _buildTendencySection(t2),
        ],
      ),
    );
  }
  
  // 성향 분석 섹션 (재사용)
  Widget _buildTendencySection(Tendency tendency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tendency.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(tendency.subtitle, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: tendency.value,
                backgroundColor: Colors.grey[200],
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(tendency.description, style: TextStyle(color: Colors.grey[700], height: 1.5)),
      ],
    );
  }

  // 모임 참여 분석 카드
  Widget _buildParticipationCard(AnalysisReport report) {
    return _buildBaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OO님의 모임 참여 분석',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('선호 키워드', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          // 가로 막대 그래프
          ...report.preferredKeywords.entries.map((entry) {
            return _buildHorizontalBar(entry.key, entry.value);
          }).toList(),
          const SizedBox(height: 8),
          Text(report.keywordSummary, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 24),
          const Text('선호하는 기간', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // 세로 막대 그래프
          _buildVerticalBarChart(report.preferredDurations),
          const SizedBox(height: 8),
          Text(report.durationSummary, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 24),
          const Text('다른 통계들...', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('종합 분석', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(report.overallSummary, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  // 가로 막대 그래프 한 줄을 만드는 위젯
  Widget _buildHorizontalBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF79C72B),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  // 세로 막대 그래프 전체를 만드는 위젯
  Widget _buildVerticalBarChart(Map<String, double> data) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.entries.map((entry) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${(entry.value * 100).toInt()}%'),
              const SizedBox(height: 4),
              Container(
                width: 30,
                height: 80 * entry.value, // 높이를 비율에 따라 조절
                decoration: BoxDecoration(
                  color: const Color(0xFF79C72B),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(entry.key),
            ],
          );
        }).toList(),
      ),
    );
  }

  // 모든 카드의 기본 스타일을 만드는 위젯 (재사용)
  Widget _buildBaseCard({required Widget child}) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.green.shade100, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
