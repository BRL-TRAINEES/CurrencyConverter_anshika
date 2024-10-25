import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/service.dart';
import 'package:currency_converter/currency_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assests/.env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends ConsumerWidget {
  // now this consumerWidget allows this widget to react to change in riverpod providers
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exchangeRates = ref.watch(exchangeRatesProvider);

    // This calculates the converted amount
    final convertedAmount = ref.watch(convertedAmountProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 66, 69),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 88, 77),
        title: Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ), // Title on the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.money_off_outlined),
                  prefixIconColor: const Color.fromARGB(255, 52, 233, 206),
                  labelText: 'Amount (INR)',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  ref.read(amountProvider.notifier).state =
                      double.tryParse(value) ?? 1.0;
                },
              ),
              SizedBox(height: 20.0),
              exchangeRates.when(
                data: (rates) {
                  final availableCurrencies =
                      (rates['conversion_rates'] as Map<String, dynamic>)
                          .keys
                          .toList();
                  return DropdownButton<String>(
                    value: ref.watch(targetCurrencyProvider),
                    onChanged: (value) {
                      ref.read(targetCurrencyProvider.notifier).state = value!;
                    },
                    items: availableCurrencies.map((currency) {
                      return DropdownMenuItem(
                        child: Text(
                          currency,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 52, 233, 206)),
                        ),
                        value: currency,
                      );
                    }).toList(),
                  );
                },
                loading: () {
                  return CircularProgressIndicator();
                },
                error: (err, stack) => Text('Error: $err'),
              ),
              SizedBox(height: 16.0),
              exchangeRates.when(
                data: (rates) => Text(
                  'Converted Amount: $convertedAmount ${ref.watch(targetCurrencyProvider)}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 52, 233, 206),
                      fontStyle: FontStyle.italic),
                ),
                loading: () => CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
