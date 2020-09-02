import 'package:flutter/cupertino.dart';

class Expense {
  int id;
  final String title;
  final double amount;
  final String dateis;

  Expense(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.dateis});

  Map<String, dynamic> toMap() {
    return {'title': title, 'amount': amount, 'dateis': dateis};
  }

  factory Expense.fromMap(dynamic map) {
    return Expense(
      id: map['_id'] as int,
      title: map['title'] as String,
      amount: map['amount'] as double,
      dateis: map['dateis'] as String,
    );
  }
}
