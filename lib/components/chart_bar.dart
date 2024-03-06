import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (cxt, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('R\$${value.toStringAsFixed(2)}'),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(158, 158, 158, 1),
                          width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Text(label),
          ],
        );
      },
    );
  }
}
