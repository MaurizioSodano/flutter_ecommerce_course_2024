import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> openEmailPasswordSignInScreen() async {
    final finder = find.byKey(MoreMenuButton.signInKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> pumpEmailPasswordSignInContents(
      {required FakeAuthRepository authRepository,
      required EmailPasswordSignInFormType formType,
      VoidCallback? onSignedIn}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(initialLocation: '/', routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Scaffold(
                body: EmailPasswordSignInContents(
                  formType: formType,
                  onSignedIn: onSignedIn,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final primaryButton = find.byType(PrimaryButton);
    expect(primaryButton, findsOneWidget);
    await tester.tap(primaryButton);
    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final finder = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(finder, findsOneWidget);
    await tester.enterText(finder, email);
  }

  Future<void> enterPassword(String password) async {
    final finder = find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(finder, findsOneWidget);
    await tester.enterText(finder, password);
  }

  Future<void> signInWithEmailAndPassword() async {
    await enterEmail('test@test.com');
    await enterPassword('test1234');
    await tapEmailAndPasswordSubmitButton();
  }

  Future<void> openAccountScreen() async {
    final finder = find.byKey(MoreMenuButton.accountKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> pumpAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null)
            authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(initialLocation: '/', routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const AccountScreen(),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    // find logout button and tap it
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    // expect that the logout dialog is presented
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapCancelButton() async {
    // find cancel button and tap it
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    // expect that the logout dialog is no longer visible
    expect(dialogTitle, findsNothing);
  }

  Future<void> tapDialogLogoutButton() async {
    // find logout button and tap it
    final logoutButton = find.byKey(kDialogDefaultKey);
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOne);
  }

//Find Widget by descendant
  Future<void> tapDialogLogoutButton2() async {
    final logoutButton = find.descendant(
      of: find.byType(Dialog),
      matching: find.text('Logout'),
    );
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();
  }
}
