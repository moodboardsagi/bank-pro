import 'dart:convert';

import 'package:bank_pro/models/tips_model.dart';
import 'package:bank_pro/services/auth_service.dart';
import 'package:bank_pro/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class TipsService {
  Future<List<TipsModel>> getTips() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/tips'),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TipsModel>.from(
          jsonDecode(res.body)['data'].map(
            (tip) => TipsModel.fromJson(tip),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
