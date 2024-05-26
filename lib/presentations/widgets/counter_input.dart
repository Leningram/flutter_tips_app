import 'package:flutter/material.dart';

class CounterInput extends StatefulWidget {
  const CounterInput({
    super.key,
    required this.controller,
    this.label,
    this.step = 1,
  });
  final TextEditingController controller;
  final String? label;
  final int step;
  @override
  State<CounterInput> createState() => _CounterInputState();
}

class _CounterInputState extends State<CounterInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _increment() {
    final currentValue = int.tryParse(widget.controller.text) ?? 0;
    final newValue = currentValue + widget.step;
    widget.controller.text = newValue.toString();
  }

  void _decrement() {
    final currentValue = int.tryParse(widget.controller.text) ?? 0;
    if (currentValue > 0) {
      if (currentValue < widget.step) {
        widget.controller.text = '0';
        return;
      }
      final newValue = currentValue - widget.step;
      widget.controller.text = newValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Expanded(
          child: TextField(
            controller: widget.controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {},
            decoration: widget.label != null ? InputDecoration(
              counterText: '',
              label: Align(
                alignment: Alignment.center,
                child: Text(widget.label!),
              ),
            ) : const InputDecoration(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
