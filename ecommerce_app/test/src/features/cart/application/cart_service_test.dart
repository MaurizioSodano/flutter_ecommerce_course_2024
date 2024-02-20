import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockLocalCartRepository localCartRepository;
  late RemoteCartRepository remoteCartRepository;
  setUpAll(() {
    registerFallbackValue(const Cart());
  });
  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
  });
  CartService makeCartService() {
    // create a container
    final container = ProviderContainer(
      // override the providers with our mocks
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
        remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
      ],
    );
    // don't forget this
    addTearDown(container.dispose);
    // return the CartService by reading with the container
    return container.read(cartServiceProvider);
  }

  group('setItem', () {
    test('null user, writes item to local cart', () async {
      //Setup
      const expectedCart = Cart({'123': 1});
      // Stub the mocks
      when(() => authRepository.currentUser).thenReturn(null);
      when(() => localCartRepository.fetchCart())
          .thenAnswer((_) => Future.value(const Cart()));
      when(() => localCartRepository.setCart(expectedCart))
          .thenAnswer((invocation) => Future.value());
      // declare the service class like this
      final cartService = makeCartService();
      // now we can use it as normal

      //run
      await cartService.setItem(const Item(productId: '123', quantity: 1));

      //verify
      verify(
        () => localCartRepository.setCart(expectedCart),
      ).called(1);
      verifyNever(() => remoteCartRepository.setCart(any(), any()));
    });

    test('non-null user, writes item to remote cart', () async {
      // declare the service class like this
      const testUser = AppUser(uid: '123', email: 'test@test.com');
      const expectedCart = Cart({'123': 1});
      // Stub the mocks
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => remoteCartRepository.fetchCart(testUser.uid))
          .thenAnswer((_) => Future.value(const Cart()));
      when(() => remoteCartRepository.setCart(testUser.uid, expectedCart))
          .thenAnswer((invocation) => Future.value());
      // declare the service class like this
      final cartService = makeCartService();
      // now we can use it as normal

      //run
      await cartService.setItem(const Item(productId: '123', quantity: 1));

      //verify
      verify(
        () => remoteCartRepository.setCart(testUser.uid, expectedCart),
      ).called(1);
      verifyNever(() => localCartRepository.setCart(any()));
      // now we can use it as normal
    });
  });
}
