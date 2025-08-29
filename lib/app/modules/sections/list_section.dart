import 'package:demo_app/app/modules/home/tabWidgetController.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/app/data/models/models.dart';

class ListSection extends StatelessWidget {
  final Section section;
  final TabControllerX controller;

  const ListSection({
    super.key,
    required this.section,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.sectionName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),

            // Render items
            ...section.items.map((item) {
              if (item is TrainingItem) {
                return _TrainingItemWidget(training: item, controller: controller);
              } else if (item is String) {
                return _SimpleListItemWidget(item: item);
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}

class _TrainingItemWidget extends StatelessWidget {
  final TrainingItem training;
  final TabControllerX controller;

  const _TrainingItemWidget({
    required this.training,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: training.isCompleted,
                onChanged: null, // disabled for now, but you can link to controller
              ),
              Expanded(
                child: Text(
                  training.trainingName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: training.isOverdue ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),

          if (training.dueDate != null)
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 4),
              child: Text(
                'Due ${controller.formatDate(training.dueDate!)}'
                '${training.isOverdue ? ' (Overdue)' : ''}',
                style: TextStyle(
                  color: training.isOverdue ? Colors.red : Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),

          if (training.category.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 2),
              child: Text(
                training.category,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SimpleListItemWidget extends StatelessWidget {
  final String item;

  const _SimpleListItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(item),
    );
  }
}
