import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null); // TODO: Update
  @override
  AppUser? get currentUser => null; // TODO: Update

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // TODO: Implement
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    // TODO: Implement
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // const isFake = String.fromEnvironment('useFakeRepos') == 'true';
  // return isFake ? FakeAuthRepository() : FirebaseAuthRepository();

  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
