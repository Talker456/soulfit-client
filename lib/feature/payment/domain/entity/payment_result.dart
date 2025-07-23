enum PaymentStatus {
  success,
  failed,
}

class PaymentResult {
  final PaymentStatus status;
  final String message;

  const PaymentResult({
    required this.status,
    required this.message,
  });
}
