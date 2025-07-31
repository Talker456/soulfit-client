import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/coupon_model.dart';
import '../riverpod/coupon_list_provider.dart';
import '../widget/coupon_app_bar.dart';
import '/config/di/provider.dart';

final couponRegisterProvider = FutureProvider.family<CouponModel, String>((
  ref,
  code,
) async {
  final usecase = ref.watch(registerCouponUseCaseProvider);
  return await usecase(code);
});

class CouponScreen extends ConsumerStatefulWidget {
  const CouponScreen({super.key});

  @override
  ConsumerState<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends ConsumerState<CouponScreen> {
  final TextEditingController _controller = TextEditingController();

  void _registerCoupon() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    try {
      await ref.read(couponRegisterProvider(code).future);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('쿠폰이 등록되었어요!')));
      _controller.clear();

      // 쿠폰 목록 갱신
      ref.invalidate(couponListProvider);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('등록 실패: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final couponListAsync = ref.watch(couponListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 쿠폰 등록 입력창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '쿠폰 코드를 입력하세요',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _registerCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    '등록',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 보유 쿠폰 리스트
            Expanded(
              child: couponListAsync.when(
                data: (coupons) {
                  if (coupons.isEmpty) {
                    return const Center(child: Text('사용 가능한 쿠폰이 없어요'));
                  }
                  return ListView.builder(
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = coupons[index];
                      return Card(
                        color: const Color(0xFFF5F5F5),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text('${coupon.code}'),
                          subtitle: Text('할인 금액: ${coupon.discountAmount}원'),
                          trailing:
                              coupon.isUsed
                                  ? const Text(
                                    '사용됨',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                  : const Text(
                                    '사용 가능',
                                    style: TextStyle(color: Colors.green),
                                  ),
                          onTap:
                              coupon.isUsed
                                  ? null
                                  : () {
                                    Navigator.pop(context, coupon);
                                  },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('에러 발생: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
