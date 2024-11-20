class WalletModel {
  final int balance;
  WalletModel({
    required this.balance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: json['balance'],
    );
  }
}
