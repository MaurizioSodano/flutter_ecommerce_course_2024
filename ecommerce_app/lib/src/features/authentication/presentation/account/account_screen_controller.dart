// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  final AuthRepository authRepository;
  Future<bool> signOut() async {
    // try {
    //   // set state to loading
    //   state = const AsyncValue<void>.loading();

    //   //sign out, using AuthRepository
    //   await authRepository.signOut();

    //   //if success, set state to data
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (e, st) {
    //   //if error, set state to error
    //   state = AsyncValue<void>.error(e, st);
    //   return false;
    // }
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
    return state.hasError == false;
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});
