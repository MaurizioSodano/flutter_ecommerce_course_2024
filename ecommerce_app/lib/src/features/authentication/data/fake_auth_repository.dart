import 'package:ecommerce_app/src/utils/in_memory_store.dart';

import '../domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
  @override
  AppUser? get currentUser => _authState.value; // TODO: Update

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  void dispose() => _authState.close();
  void _createNewUser(String email) {
    // note: the uid could be any unique string. Here we simply reverse the email.
    _authState.value =
        AppUser(uid: email.split('').reversed.join(), email: email);
  }
}
