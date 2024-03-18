import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.onRemove,
    required this.tr,
  });

  final void Function(String p1) onRemove;
  final Transaction tr;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      elevation: 5,
      child: ListTile(
        trailing: MediaQuery.of(context).size.width > 480
            ? IconButton(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                color: Colors.red,
              )
            : TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  'Excluir',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy').format(widget.tr.date),
        ),
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                'R\$ ${widget.tr.value.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
