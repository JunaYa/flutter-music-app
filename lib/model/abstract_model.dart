import 'package:flutter/cupertino.dart';

abstract class AbstractModel extends ChangeNotifier {
  void reset([bool notify = true]) {
    copyFromJson({});
    if (notify) notifyListeners();
  }

  void notify() => notifyListeners();


  Map<String, dynamic> toJson() {
    // This should be over-ridden in concrete class to enable serialization
    throw UnimplementedError();
  }

  dynamic copyFromJson(Map<String, dynamic> json) {
    // This should be over-ridden in concrete class to enable serialization
    throw UnimplementedError();
  }

  List<T> toList<T>(dynamic json, dynamic Function(dynamic) fromJson) {
    final List<T> list = (json as Iterable?)?.map((e) {
      return e == null ? e : fromJson(e) as T?;
    }).where((e) => e != null).whereType<T>().toList() ?? [];

    return list;
  }
}

