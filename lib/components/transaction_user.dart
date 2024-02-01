import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: '1',
      title: 'Compra de alimentos',
      value: 50.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Pagamento de conta',
      value: 100.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: '3',
      title: 'Gasolina',
      value: 30.0,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(transactions: _transactions),
        TransactionForm(),
      ],
    );
  }
}