import 'package:flutter/material.dart';

class PaymentConfirmButton extends StatelessWidget {
  final int originalAmount;
  final int discount;
  final int finalAmount;
  final VoidCallback onPressed;

  const PaymentConfirmButton({
    super.key,
    required this.originalAmount,
    required this.discount,
    required this.finalAmount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 44,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE4FFDF),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                '$finalAmount원 결제하기',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
