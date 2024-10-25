import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future<Map<String, dynamic>> getExchangeRates() async {
    final response = await http.get(Uri.parse(
        "https://v6.exchangerate-api.com/v6/${dotenv.env['apikey']}/latest/INR"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}

//instance of ApiService
final apiServiceProvider = Provider((ref) => ApiService());
