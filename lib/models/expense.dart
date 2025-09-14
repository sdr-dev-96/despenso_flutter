class Expense {
  final int? id;
  final String title;
  final double amount;
  Expense({this.id, required this.title, required this.amount});

  /// Creates an [Expense] instance from a JSON map.
  /// 
  /// Takes a [Map<String, dynamic>] representing the JSON data and
  /// returns an [Expense] object with the corresponding fields populated.
  /// 
  /// Throws an exception if required fields are missing or have invalid types.
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
    );
  }

  /// Converts the [Expense] object into a JSON-compatible map.
  ///
  /// Returns a [Map] where the keys are [String]s representing the property names
  /// and the values are the corresponding property values of the [Expense] object.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
    };
  }
}