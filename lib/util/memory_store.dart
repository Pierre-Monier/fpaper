import 'package:rxdart/subjects.dart';

class InMemoryStore<T> {
  InMemoryStore(T inital) : _subject = BehaviorSubject<T>.seeded(inital);

  final BehaviorSubject<T> _subject;

  set value(T value) {
    _subject.add(value);
  }

  Stream<T> get watch => _subject.stream;
  T get value => _subject.value;
}
