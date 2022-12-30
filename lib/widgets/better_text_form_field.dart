import 'package:flutter/material.dart';

class BetterTextFormField extends StatefulWidget {
  const BetterTextFormField(
      {Key? key,
      this.labelText,
      this.initValue,
      this.fetchInitValue,
      this.onChanged})
      : super(key: key);

  final String? labelText;
  final String? initValue;
  final Function(String)? onChanged;
  final Future<String> Function()? fetchInitValue;

  @override
  State<BetterTextFormField> createState() => _BetterTextFormFieldState();
}

class _BetterTextFormFieldState extends State<BetterTextFormField> {
  final TextEditingController _controller = TextEditingController();

  void _handleChange(String newText) {
    if (widget.onChanged != null) {
      _controller.text = newText;
      _controller.selection = TextSelection.collapsed(offset: newText.length);
      widget.onChanged!(newText);
    }
  }

  @override
  void initState() {
    if (widget.fetchInitValue != null) {
      widget.fetchInitValue!().then((String text) => _handleChange(text));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (String text) => _handleChange(text),
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
