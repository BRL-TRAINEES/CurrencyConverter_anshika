import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exchangeRatesProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final apiService = ref.watch(
      apiServiceProvider); //ref.watch listen the apiServiceProvider and give current state of this apiServiceprovider
  return await apiService.getExchangeRates();
});

final targetCurrencyProvider = StateProvider<String>(
    (ref) => 'USD'); //update  the state dynamically during runtime

final amountProvider = StateProvider<double>((ref) => 1.0);

final convertedAmountProvider = Provider<double>((ref) {
  final exchangeRates = ref.watch(exchangeRatesProvider).maybeWhen(
        //maybeWhen() is a utility function that allows to handle diff states of a FutureProvider (such as exchangeRatesProvider) in a more accurate way.
        data: (rates) => rates['conversion_rates'],
        orElse: () => null,
      );

  final targetCurrency = ref.watch(targetCurrencyProvider); //
  final amount = ref.watch(amountProvider);

  if (exchangeRates != null && exchangeRates[targetCurrency] != null) {
    return amount * exchangeRates[targetCurrency];
  }
  return 0.0;
});
