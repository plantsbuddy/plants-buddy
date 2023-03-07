import 'package:hive/hive.dart';

extension HiveOpenOrReturnLazyBox on HiveInterface {
  Future<LazyBox<Type>> openOrReturnBox<Type>(String name) async {
    return Hive.isBoxOpen(name) ? Hive.lazyBox<Type>(name) : await Hive.openLazyBox<Type>(name);
  }
}
