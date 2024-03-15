import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({
    super.key,
    required this.onSubmit,
  }) {
    print('calling TransactionForm constructor');
  }

  @override
  State<TransactionForm> createState() => _TransactionForm();
}

class _TransactionForm extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0.0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  void initState() {
    print('calling initState TransactionForm');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('calling didChangeDependencies TransactionForm');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TransactionForm oldWidget) {
    print('calling didUpdateWidget TransactionForm');
    super.didUpdateWidget(oldWidget);
  }

  // chamado quando é removido da árvore de widgets
  @override
  void deactivate() {
    print('calling deactivate TransactionForm');
    super.deactivate();
  }

  // Chamado quando é removido permanentemente
  // da árvore de widgets
  @override
  void dispose() {
    print('calling dispose TransactionForm');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('calling build TransactionForm');
    return Card(
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(controller: titleController, label: 'Título'),
              AdaptativeTextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submitForm(),
                controller: valueController,
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChange: (newDate) => setState(() {
                  _selectedDate = newDate;
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                      label: 'Nova Transação',
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
