import 'package:fitsense/widgets/text_input.dart';
import 'package:flutter/material.dart';

class ListSelector extends StatefulWidget {
  const ListSelector({Key? key, this.title, this.initValue, this.onFinished}) : super(key: key);

  final String? title;
  final List<String>? initValue;
  final Function(List<String>)? onFinished;

  @override
  State<ListSelector> createState() => _ListSelectorState();
}

class _ListSelectorState extends State<ListSelector> {
  List<String>? _textList;

  @override
  void initState() {
    _textList = widget.initValue ?? [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onFinished != null) {
              widget.onFinished!(_textList!);
            }
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(context: context, builder: (context) {
          return TextInput(
            onSubmit: (String text) {
              setState(() {
                _textList!.add(text);
              });
            },
          );
        }),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: _textList!
            .map((String text) => Card(
              child: ListTile(
                title: Text(text),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _textList!.remove(text);
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
          ),
            ))
            .toList(),
        ),
      )
    );
  }
}
