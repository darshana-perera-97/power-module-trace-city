class User {
  final String userName;
  final String accountNumber;
  final String device;
  final String address;
  final String tp;
  final String userId;

  User({
    required this.userName,
    required this.accountNumber,
    required this.device,
    required this.address,
    required this.tp,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'] as String,
      accountNumber: json['accountNumber'] as String,
      device: json['device'] as String,
      address: json['address'] as String,
      tp: json['tp'] as String,
      userId: json['userId'] as String,
    );
  }
}
