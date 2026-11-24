import 'identifiable.dart';

final class Repository<T extends Identifiable> {
  final Map<String, T> _items = <String, T>{};

  void add(T item) => _items[item.id] = item;

  T? findById(String id) => _items[id];

  Iterable<T> where(bool Function(T) predicate) =>
      _items.values.where(predicate);

  List<T> get all => List<T>.unmodifiable(_items.values);

  int get length => _items.length;
}
