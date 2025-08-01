import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/coupon/presentation/screens/coupon_screen.dart';
import 'package:soulfit_client/feature/coupon/presentation/riverpod/coupon_list_provider.dart';
import 'package:soulfit_client/feature/coupon/presentation/riverpod/selected_coupon_provider.dart';

class CouponSelectorSection extends ConsumerWidget {
  const CouponSelectorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final couponListAsync = ref.watch(couponListProvider);

    return Column(
      children: [
        // 상단 텍스트와 개수
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '쿠폰',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              couponListAsync.when(
                data:
                    (coupons) => Text(
                      '${coupons.length}장 보유',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                loading: () => const SizedBox.shrink(),
                error:
                    (_, __) => const Text(
                      '0장 보유',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // 쿠폰 선택 버튼
        couponListAsync.when(
          data:
              (coupons) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final selected = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CouponScreen()),
                    );

                    if (selected != null) {
                      ref.read(selectedCouponProvider.notifier).state =
                          selected;
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          coupons.isEmpty
                              ? '사용 가능한 쿠폰이 없어요'
                              : '사용 가능한 쿠폰이 ${coupons.length}장 있어요',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}
