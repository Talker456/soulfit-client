class CouponModel {
  final int id;
  final String code;
  final int discountAmount;
  final bool isUsed;

  CouponModel({
    required this.id,
    required this.code,
    required this.discountAmount,
    required this.isUsed,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      code: json['code'],
      discountAmount: json['discountAmount'],
      isUsed: json['isUsed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountAmount': discountAmount,
      'isUsed': isUsed,
    };
  }
}
