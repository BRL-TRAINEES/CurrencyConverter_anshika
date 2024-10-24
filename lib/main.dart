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



class Converter extends ConsumerWidget{  // with consumerWidget we dont need to use setState since its give us ref that watch the current changes 
  const Converter({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final TextEditingController amount = TextEditingController();
    String fromCurrency = 'INR';
    String toCurrency = 'USD';
    String conversionResult =''

    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: ,
    );
  }
}
