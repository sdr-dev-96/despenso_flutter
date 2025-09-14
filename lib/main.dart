import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/expenses_page.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despenso',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Consumer<AuthService>(
        builder: (context, auth, _) {
          if (1 < 2) {
            return const ExpensesPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
