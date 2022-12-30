import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key, this.onSubmit}) : super(key: key);

  final Function(String)? onSubmit;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String text) {
                  setState(() {
                    _text = text;
                  });
                },
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              onPressed: () {
                if (widget.onSubmit != null) {
                  widget.onSubmit!(_text);
                }
                Navigator.pop(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
