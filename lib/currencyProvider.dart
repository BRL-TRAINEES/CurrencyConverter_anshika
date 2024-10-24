import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service.dart';

final currencyProvider = Provider((ref) => CurrencyService());

final rateProvider = FutureProvider((ref) {
  final service = ref.read(currencyProvider);
  return service.getData();
});
