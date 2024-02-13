import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountScreen() async{
        await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async{
        // find logout button and tap it
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  void expectLogoutDialogFound(){
        // expect that the logout dialog is presented
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

    Future<void> tapCancelButton() async{
    // find cancel button and tap it
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

    void expectLogoutDialoNotFound(){
        // expect that the logout dialog is presented
    final dialogTitle = find.text('Are you sure?');
    // expect that the logout dialog is no longer visible
    expect(dialogTitle, findsNothing);
  }

}
