import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  Constant._(); // Private constructor to prevent instantiation

  static String get apiUrl =>
      dotenv.env['API_URL'] ?? 'https://api.example.com';
  static String get jwtToken => dotenv.env['JWT_TOKEN'] ?? 'your_jwt_token';
}
