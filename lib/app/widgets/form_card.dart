import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String pill;
  final VoidCallback? onTap;

  const FormCard({super.key, required this.title, required this.subtitle, this.pill = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ]),
              ),
              if (pill.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(pill),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
