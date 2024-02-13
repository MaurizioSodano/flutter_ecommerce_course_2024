@Timeout(Duration(milliseconds: 500))
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      verifyNever(authRepository.signOut);
      expect(controller.state, const AsyncData<void>(null));
    });
    test('signOut success', () async {
      //method stub
      when(authRepository.signOut).thenAnswer(
        (_) => Future.value(),
      );

      expectLater(
          controller.stream,
          emitsInOrder(
            const [
              AsyncLoading<void>(),
              AsyncData<void>(null),
            ],
          ));
      // run
      await controller.signOut();
      // verify
      verify(authRepository.signOut).called(1);
    });

    test('signOut failure', () async {
      //method stub
      final exception = Exception("Connection failed");
      when(authRepository.signOut).thenThrow(exception);

      expectLater(
          controller.stream,
          emitsInOrder(
            [
              const AsyncLoading<void>(),
              predicate<AsyncValue<void>>((value) {
                expect(value.hasError, true);
                return true;
              })
            ],
          ));
      // run
      await controller.signOut();
      // verify
      verify(authRepository.signOut).called(1);
    });
  });
}