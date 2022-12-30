import 'package:flutter/material.dart';

import '../views/profile/list_selector.dart';

class TextListFormField extends StatefulWidget {
  const TextListFormField({Key? key, this.initValue, this.onChanged, this.labelText, this.fetchInitValue}) : super(key: key);
  final List<String>? initValue;
  final Function(List<String>)? onChanged;
  final String? labelText;
  final Future<List<String>> Function()? fetchInitValue;

  @override
  State<TextListFormField> createState() => _TextListFormFieldState();
}

class _TextListFormFieldState extends State<TextListFormField> {
  List<String>? _textList;
  TextEditingController _controller = TextEditingController();

  void _setTextList(List<String> textList) {
    _controller.text = textList.fold("", (prefix, element) => "$prefix- ${element}\n").trim();
  }

  @override
  void initState() {
    _textList = widget.initValue ?? [];

    if (widget.fetchInitValue != null) {
      widget.fetchInitValue!().then((List<String> textList) => setState(() {
        _textList = textList;
        _setTextList(textList);
      }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      maxLines: null,
      readOnly: true,
      decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ListSelector(
              title: "Allergien",
              initValue: _textList,
              onFinished: (textList) {
                setState(() {
                  _textList = textList;
                  _setTextList(textList);
                  if (widget.onChanged != null) {
                    widget.onChanged!(_textList!);
                  }
                });
              }),
        ),
      ),
    );
  }
}
