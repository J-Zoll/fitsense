import 'package:flutter/material.dart';

class TextSelectFormField extends StatefulWidget {
  const TextSelectFormField({
    Key? key,
    required this.options,
    this.labelText,
    this.onChanged,
    this.fetchInitValue,
  }) : super(key: key);

  final List<String> options;
  final String? labelText;
  final Function(String)? onChanged;
  final Future<String> Function()? fetchInitValue;

  @override
  State<TextSelectFormField> createState() => _TextSelectFormFieldState();
}

class _TextSelectFormFieldState extends State<TextSelectFormField> {
  String? _text;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _text = "";
    if (widget.fetchInitValue != null) {
      widget.fetchInitValue!()
          .then((String initValue) => setState(() {
            _text = initValue;
            _controller.text = initValue;
          }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _controller,
      onTap: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.labelText ?? ""),
            content: Column(
              children: widget.options.map((String text) => ListTile(
                title: Text(text),
                onTap: () => setState(() {
                  _text = text;
                  _controller.text = text;
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                  Navigator.of(context).pop();
                }),
              ))
                  .toList(),
            ),
          );
        },
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
