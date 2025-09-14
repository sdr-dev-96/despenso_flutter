import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'expenses_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Color(0xFFECF0F1),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou icône
              Icon(Icons.account_balance_wallet,
                  size: 80, color: Color(0xFF27AE60)),
              const SizedBox(height: 20),

              Text("Despenso",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF27AE60),
                      )),
              const SizedBox(height: 8),
              Text("Connectez-vous pour continuer",
                  style: TextStyle(color: Colors.grey[600])),

              const SizedBox(height: 30),

              // Champ email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Champ password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // Bouton login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27AE60),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: loading
                      ? null
                      : () async {
                          setState(() => loading = true);
                          final success = await auth.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          setState(() => loading = false);
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ExpensesPage()),
                            );
                          } else {
                            setState(() => error = 'Échec de connexion');
                          }
                        },
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Text("Se connecter",
                          style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 12),

              if (error != null)
                Text(error!,
                    style: const TextStyle(color: Colors.red, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
