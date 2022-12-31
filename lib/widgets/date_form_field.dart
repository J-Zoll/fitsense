import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  const DateFormField(
      {Key? key,
      this.initValue,
      this.fetchInitValue,
      this.onChanged,
      this.labelText})
      : super(key: key);

  final DateTime? initValue;
  final Future<DateTime> Function()? fetchInitValue;
  final Function(DateTime date)? onChanged;
  final String? labelText;

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  final TextEditingController _controller = TextEditingController();

  void _handleChanged(DateTime newDate) {
    print(newDate);
    _controller.text =
        "${newDate.day.toString().padLeft(2, "0")}.${newDate.month.toString().padLeft(2, "0")}.${newDate.year}";
    widget.onChanged!(newDate);
  }

  @override
  void initState() {
    if (widget.fetchInitValue != null) {
      widget.fetchInitValue!()
          .then((DateTime initValue) => _handleChanged(initValue));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _controller,
      onTap: () => showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDate: DateTime.now(),
      ).then((DateTime? date) {
        if (date != null && widget.onChanged != null) {
          _handleChanged(date);
        }
      }),
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
