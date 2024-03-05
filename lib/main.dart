import 'dart:math';
import 'dart:io';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/services.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    */

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        primaryColor: Colors.purple,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.amber,
            ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 20.0),
          toolbarTextStyle: TextStyle(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  Widget _getIconButton({
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return !kIsWeb && Platform.isIOS
        ? GestureDetector()
        : IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            color: Colors.white,
          );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList =
        !kIsWeb && Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final chartList =
        !kIsWeb && Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    var actions = [
      _getIconButton(
        onPressed: () => _openTransactionFormModal(context),
        icon: Icons.add,
      ),
      if (isLandscape)
        _getIconButton(
          onPressed: () => setState(() {
            _showChart = !_showChart;
          }),
          icon: _showChart ? iconList : chartList,
        ),
    ];

    final PreferredSizeWidget appBar = !kIsWeb && Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ) as PreferredSizeWidget,
          )
        : AppBar(
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize: mediaQuery.textScaler.scale(20),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            actions: actions,
          ) as PreferredSizeWidget;

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Visibility(
              visible: _showChart || !isLandscape,
              child: SizedBox(
                height: availableHeight * (isLandscape ? 0.70 : 0.30),
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            ),
            Visibility(
              visible: !_showChart || !isLandscape,
              child: SizedBox(
                height: availableHeight * 0.70,
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _deleteTransaction,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return !kIsWeb && Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _openTransactionFormModal(context);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
