import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  class Storage {
    static const _storage = FlutterSecureStorage();
    static const _key = 'jwt_token';

    /// Saves the provided authentication token to persistent storage.
    ///
    /// This method stores the [token] asynchronously for later retrieval,
    /// typically used for maintaining user sessions.
    ///
    /// [token]: The authentication token to be saved.
    /// 
    /// Returns a [Future] that completes when the token has been saved.
    static Future<void> saveToken(String token) async {
      await _storage.write(key: _key, value: token);
    }

    /// Retrieves the stored authentication token asynchronously.
    ///
    /// Returns a [Future] that completes with the token as a [String], or `null`
    /// if no token is found.
    static Future<String?> getToken() async {
      return await _storage.read(key: _key);
    }

    /// Clears the stored authentication token from persistent storage.
    ///
    /// This method removes the token used for user authentication,
    /// effectively logging the user out or resetting their session.
    /// It is asynchronous and returns a [Future] that completes when
    /// the token has been cleared.
    static Future<void> clearToken() async {
      await _storage.delete(key: _key);
    }
}