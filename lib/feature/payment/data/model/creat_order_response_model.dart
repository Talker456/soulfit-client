class CreateOrderResponseModel {
  final String orderId;

  CreateOrderResponseModel({required this.orderId});

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponseModel(
      orderId: json['orderId'] as String,
    );
  }
}
