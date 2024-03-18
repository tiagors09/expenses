import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrainsts) {
              return Column(
                children: [
                  SizedBox(
                    height: constrainsts.maxHeight * 0.3,
                    child: Text(
                      'Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: constrainsts.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map(
                  (tr) => TransactionItem(
                    key: GlobalObjectKey(tr),
                    onRemove: onRemove,
                    tr: tr,
                  ),
                )
                .toList(),
          );
  }
}

/**
 * ListView(
            children: transactions
                .map(
                  (tr) => TransactionItem(
                    key: ValueKey(tr.id),
                    onRemove: onRemove,
                    tr: tr,
                  ),
                )
                .toList(),
          );
 */

/*
ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(onRemove: onRemove, tr: tr);
            },
          );
*/
