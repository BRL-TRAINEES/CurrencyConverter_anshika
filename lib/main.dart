import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ProviderScope(child: currencyApp()));
}

class currencyApp extends StatelessWidget {
  const currencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: Converter(),
    );
  }
}

Future<void>getData() async {
  final response = await http.get(Uri.parse(
      'https://v6.exchangerate-api.com/v6/71478dfdd9bb2533b494ba46/latest/USD'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final finalData = data['conversion_rates'];
    print(finalData);
  } else {
    throw Exception('Error occured!');
  }
}

class Converter extends ConsumerWidget{  // with consumerWidget we dont need to use setState since its give us ref that watch the current changes 
  const Converter({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: ,
    );
  }
}
