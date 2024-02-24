// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {
    //nothing to do
  }
  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}



// class AccountScreenController extends StateNotifier<AsyncValue<void>> {
//   AccountScreenController({required this.authRepository})
//       : super(const AsyncData(null));

//   final AuthRepository authRepository;
//   Future<void> signOut() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => authRepository.signOut());
//   }
// }

// final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
//     AccountScreenController, AsyncValue<void>>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AccountScreenController(
//     authRepository: authRepository,
//   );
// });
