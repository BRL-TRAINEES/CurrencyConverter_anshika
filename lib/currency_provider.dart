import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exchangeRatesProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getExchangeRates();
});

final targetCurrencyProvider = StateProvider<String>((ref) => 'USD');

final amountProvider = StateProvider<double>((ref) => 1.0);

final convertedAmountProvider = Provider<double>((ref) {
  final exchangeRates = ref.watch(exchangeRatesProvider).maybeWhen(
        data: (rates) => rates['conversion_rates'],
        orElse: () => null,
      );

  final targetCurrency = ref.watch(targetCurrencyProvider);
  final amount = ref.watch(amountProvider);

  if (exchangeRates != null && exchangeRates[targetCurrency] != null) {
    return amount * exchangeRates[targetCurrency];
  }
  return 0.0;
});
