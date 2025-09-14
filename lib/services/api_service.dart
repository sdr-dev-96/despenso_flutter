import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';
import '../utils/constant.dart';

class ApiService {
  static final baseUrl = Constant.apiUrl;

  /// Authenticates a user with the provided [email] and [password].
  ///
  /// Returns a [String] containing the authentication token if login is successful,
  /// or `null` if authentication fails.
  ///
  /// Throws an exception if there is a network or server error.
  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    }
    return null;
  }

  /// Fetches a list of [Expense] objects from the API using the provided authentication [token].
  ///
  /// Returns a [Future] that completes with a list of [Expense] instances.
  /// Throws an exception if the request fails or the response cannot be parsed.
  static Future<List<Expense>> fetchExpenses(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/expenses'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => Expense.fromJson(e)).toList();
    }
    return [];
  }

  /// Adds a new expense to the server.
  ///
  /// Takes an authentication [token] and an [expense] object to be added.
  ///
  /// Returns `true` if the expense was successfully added, otherwise `false`.
  ///
  /// Throws an exception if the request fails.
  static Future<bool> addExpense(String token, Expense expense) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(expense.toJson()),
    );
    return response.statusCode == 201;
  }
}
