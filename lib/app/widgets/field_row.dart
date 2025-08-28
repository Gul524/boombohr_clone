import 'package:flutter/material.dart';

class FieldRow extends StatelessWidget {
  final String label;
  final String type;
  final bool requiredFlag;
  final VoidCallback? onTap;

  const FieldRow({super.key, required this.label, required this.type, this.requiredFlag = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        subtitle: Text('$type ${requiredFlag ? "• Required" : ""}'),
        trailing: const Icon(Icons.drag_handle),
      ),
    );
  }
}
