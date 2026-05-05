import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class History extends StatelessWidget
{
  final String code;
  const History({
    super.key, required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(code),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Copied: $code")),
            );
          },
        ),
      ),
    );
  }
}