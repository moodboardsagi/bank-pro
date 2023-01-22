import 'dart:convert';

import 'package:bank_pro/models/data_plan_form_model.dart';
import 'package:bank_pro/models/topup_form_model.dart';
import 'package:bank_pro/models/transaction_model.dart';
import 'package:bank_pro/models/transfer_form_model.dart';
import 'package:bank_pro/services/auth_service.dart';
import 'package:bank_pro/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
          Uri.parse(
            '$baseUrl/top_ups',
          ),
          body: data.toJson(),
          headers: {
            'Authorization': token,
          });
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_url'];
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
          Uri.parse(
            '$baseUrl/transfers',
          ),
          body: data.toJson(),
          headers: {
            'Authorization': token,
          });
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
          Uri.parse(
            '$baseUrl/data_plans',
          ),
          body: data.toJson(),
          headers: {
            'Authorization': token,
          });
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse('$baseUrl/transactions'),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        return List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (transaction) => TransactionModel.fromJson(transaction),
          ),
        ).toList();
      }
      return throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
