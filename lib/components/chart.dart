import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart({super.key, required this.recentTransaction});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var transaction in recentTransaction) {
        bool sameDay = transaction.date.day == weekDay.day;
        bool sameMonth = transaction.date.month == weekDay.month;
        bool sameYear = transaction.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (sum, tr) => sum += tr['value'] as double);
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: tr['value'] as double,
                  percentage: (tr['value'] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
