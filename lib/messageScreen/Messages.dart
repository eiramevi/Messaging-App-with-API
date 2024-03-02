import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final String message;
  const Messages({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Color(0xFF9BB8CD)),
      child: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
