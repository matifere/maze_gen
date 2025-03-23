import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  final bool road;

  const Cell({super.key, required this.road} );

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.road ? selected ? Colors.amber : Colors.white  : Colors.black,
          ),
        ),
      ),
    );
  }
}