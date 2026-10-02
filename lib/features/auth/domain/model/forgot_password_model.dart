class ForgotPasswordModel {
  bool status;
  int code;
  String message;
  String email;

  ForgotPasswordModel({
    required this.status,
    required this.code,
    required this.message,
    required this.email,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      email: json['data']?['email'] ?? '', 
    );
  }
}
