import 'package:bank_pro/models/payment_method_model.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transactionType;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethod,
    this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        amount: json['amount'],
        createdAt: DateTime.tryParse(json['created_at']),
        paymentMethod: json['payment_method'] == null
            ? null
            : PaymentMethodModel.fromJson(
                json['payment_method'],
              ),
        transactionType: json['transaction_type'] == null
            ? null
            : TransactionTypeModel.fromJson(
                json['transaction_type'],
              ),
      );
}

class TransactionTypeModel {
  final int? id;
  final String? name;
  final String? code;
  final String? action;
  final String? thumbnail;

  TransactionTypeModel({
    this.id,
    this.name,
    this.code,
    this.action,
    this.thumbnail,
  });

  factory TransactionTypeModel.fromJson(Map<String, dynamic> json) =>
      TransactionTypeModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        action: json['action'],
        thumbnail: json['thumbnail'],
      );
}
