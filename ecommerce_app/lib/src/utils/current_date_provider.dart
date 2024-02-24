import 'package:riverpod_annotation/riverpod_annotation.dart';

/// A provider that returns a function that returns the current date.
/// This makes it easy to mock the current date in tests.
///
///

part 'current_date_provider.g.dart';

@riverpod
DateTime Function() currentDateBuilder(CurrentDateBuilderRef ref) {
  return () => DateTime.now();
}
