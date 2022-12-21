import 'package:flutter/material.dart';

class BigIconButton extends StatelessWidget {
  const BigIconButton({Key? key, required this.iconData, required this.text, required this.onPressed}) : super(key: key);

  final IconData iconData;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width / 2 - 27,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Column(
            children: [
              Icon(
                iconData,
                size: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
