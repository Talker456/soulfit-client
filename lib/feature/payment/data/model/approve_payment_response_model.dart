import '../../domain/entity/payment_result.dart';

class ApprovePaymentResponseModel {
  final String status;
  final String? message;

  ApprovePaymentResponseModel({
    required this.status,
    this.message,
  });

  factory ApprovePaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return ApprovePaymentResponseModel(
      status: json['status'] as String,
      message: json['message'] as String?,
    );
  }

  PaymentResult toDomain() {
    return PaymentResult(
      status: status == 'SUCCESS'
          ? PaymentStatus.success
          : PaymentStatus.failed,
      message: message ?? '결제 처리 결과',
    );
  }
}
