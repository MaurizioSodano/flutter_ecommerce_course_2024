import 'package:rxdart/rxdart.dart';

/// An in-memory store backed by BehaviorSubject that can be used to
/// store the data for all the fake repositories in the app.
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject.seeded(initial);

  /// The BehaviorSubject that holds the data
  final BehaviorSubject<T> _subject;

  /// The output stream that can be used to listen to the data
  Stream<T> get stream => _subject.stream;

  /// A synchronous getter for the current value
  T get value => _subject.value;

  ///setting the value will cause the stream to emit a new event
  set value(T value) => _subject;

  /// Don't forget to call this when done
  void close() => _subject.close();
}
