abstract class SharedPreferencesRepository {
  Future<void> init();

  Future<void> putValue(String key, Object value);

  Future<void> deleteValue(String key);

  Future<String> getString(String key, {String? defaultValue});

  Future<bool> getBool(String key, {bool? defaultValue});

  Future<int> getInt(String key, {int? defaultValue});

  Future<dynamic> getNullable(String key);

  Future<Type> get<Type>(String key, {Type? defaultValue});
}
// Future<Either<Failure, Object>> getNullable(String key);
