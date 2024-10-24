import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(
        'https://v6.exchangerate-api.com/v6/71478dfdd9bb2533b494ba46/latest/INR'));

    if (response.statusCode == 200) {
      final finalData = json.decode(response.body);
      print(finalData);
      return finalData;
    } else {
      throw Exception('Error occured!');
    }
  }
}
