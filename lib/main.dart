import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                                color: Colors.black,
                                width: 2,
                              )),
                              padding: const EdgeInsets.all(10),
                              child: Text(e.value.toString()),
                            ),
                            Column(
                              children: [
                                Text(e.title),
                                Text(e.date.toString())
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
