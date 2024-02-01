import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
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

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Card(
                color: Color.fromRGBO(255, 248, 225, 1),
                child: Text('Gráfico'),
              ),
            ),
            Column(
              children: _transactions
                  .map((e) => Card(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.purple,
                                width: 2,
                              )),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'R\$ ${e.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(e.date),
                                  style: TextStyle(color: Colors.grey.shade400),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ));
  }
}
