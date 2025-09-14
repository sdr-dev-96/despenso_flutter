import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../models/expense.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});
  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Expense> expenses = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final list = await ApiService.fetchExpenses(auth.token!);
    setState(() => expenses = list);
  }

  Future<void> addExpense() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final exp = Expense(
      title: titleController.text,
      amount: double.tryParse(amountController.text) ?? 0,
    );
    final success = await ApiService.addExpense(auth.token!, exp);
    if (success) {
      titleController.clear();
      amountController.clear();
      loadExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Dépenses'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout), onPressed: () => auth.logout()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titre')),
            TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number),
            const SizedBox(height: 24),
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
                onPressed: addExpense,
                child: const Text('Ajouter une dépense'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final e = expenses[index];
                  return ListTile(
                      title: Text(e.title),
                      trailing: Text(e.amount.toString()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
