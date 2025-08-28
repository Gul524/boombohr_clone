import 'package:flutter/material.dart';

class ChipFilter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onSelected;

  const ChipFilter({super.key, required this.label, this.selected = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected?.call(),
      ),
    );
  }
}
