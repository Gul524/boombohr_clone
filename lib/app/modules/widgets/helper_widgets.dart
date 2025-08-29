// training_widgets.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class TrainingListItem extends StatelessWidget {
  final TrainingItem training;
  final Function(bool?) onCheckboxChanged;

  const TrainingListItem({
    super.key,
    required this.training,
    required this.onCheckboxChanged,
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
                onChanged: onCheckboxChanged,
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
                'Due ${_formatDate(training.dueDate!)}${training.isOverdue ? ' (Overdue)' : ''}',
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

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class BenefitsWidget extends StatelessWidget {
  final List<BenefitItem> benefits;

  const BenefitsWidget({Key? key, required this.benefits}) : super(key: key);

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
            const Text(
              'Benefits Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            ..._buildBenefitCategories(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBenefitCategories() {
    final categories = benefits.map((b) => b.benefitType).toSet().toList();
    
    return categories.map((category) {
      final categoryBenefits = benefits.where((b) => b.benefitType == category).toList();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          ...categoryBenefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(benefit.planName),
                ),
                Chip(
                  label: Text(
                    benefit.eligibilityStatus,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: benefit.isEligible ? Colors.green.shade100 : Colors.grey.shade200,
                ),
              ],
            ),
          )),
          const SizedBox(height: 12),
        ],
      );
    }).toList();
  }
}