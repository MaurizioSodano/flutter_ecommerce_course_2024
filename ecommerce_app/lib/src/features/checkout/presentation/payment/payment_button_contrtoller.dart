import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/fake_checkout_service.dart';

class PaymentButtonController extends StateNotifier<AsyncValue<void>> {
  PaymentButtonController({required this.checkoutService})
      : super(const AsyncData(null));
  final FakeCheckoutService checkoutService;

  Future<void> pay() async {
    state = const AsyncLoading();
    // state = await AsyncValue.guard(checkoutService.placeOrder);
    final newState = await AsyncValue.guard(checkoutService.placeOrder);
    // * Check if the controller is mounted before setting the state to prevent:
    // * Bad state: Tried to use PaymentButtonController after `dispose` was called.
    if (mounted) {
      state = newState;
    }
  }
}

final paymentButtonControllerProvider = StateNotifierProvider.autoDispose<
    PaymentButtonController, AsyncValue<void>>((ref) {
  return PaymentButtonController(
    checkoutService: ref.watch(checkoutServiceProvider),
  );
});
