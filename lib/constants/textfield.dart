import 'package:ect/constants/colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String labelText;

  const MyTextField({super.key, required this.labelText});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 12,
            child: AnimatedOpacity(
              opacity:
                  _isFocused || _textEditingController.text.isNotEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Text(
                widget.labelText,
                style: const TextStyle(color: customPurple),
              ),
            ),
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: '',
            ),
            onTap: () {
              setState(() {
                _isFocused = true;
              });
            },
            onEditingComplete: () {
              setState(() {
                _isFocused = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
