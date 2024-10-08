abstract class IAuthLocalDataSource {
  Future<void> cacheUserEmail(String email);

  String? getCachedUserEmail();

  Future<void> clearCachedUser();
}
