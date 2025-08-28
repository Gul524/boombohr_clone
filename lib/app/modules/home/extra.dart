
import 'package:flutter/material.dart';

class VitalsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const VitalsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// widgets/vitals_card.dart

class VitalsCard extends StatelessWidget {
  const VitalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_pin_outlined, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Vitals',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(height: 20, color: Colors.grey),
            VitalsItem(
                icon: Icons.phone, title: 'Phone', value: '+1 (555) 123-4567'),
            VitalsItem(
                icon: Icons.email,
                title: 'Email',
                value: 'john.doe@company.com'),
            VitalsItem(
                icon: Icons.location_on,
                title: 'Location',
                value: 'San Francisco, California, United States'),
            VitalsItem(
                icon: Icons.access_time,
                title: 'Local Time',
                value: '03:15 AM local time'),
            VitalsItem(
                icon: Icons.badge, title: 'Employee ID', value: 'EMP001234'),
            VitalsItem(
                icon: Icons.group, title: 'Department', value: 'American'),
            VitalsItem(
                icon: Icons.bloodtype,
                title: 'Blood Group',
                value: 'Blood group'),
            VitalsItem(icon: Icons.favorite, title: 'Status', value: 'Married'),
            VitalsItem(
                icon: Icons.language,
                title: 'Languages',
                value: 'English, Spanish, French'),
          ],
        ),
      ),
    );
  }
}

// widgets/basic_info_card.dart

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({super.key});

  Widget _buildBasicInfoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.assignment, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Basic Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.grey),
            const SizedBox(height: 10),
            _buildBasicInfoItem('Employee # *', 'EMP001234'),
            // Add more basic information items here
          ],
        ),
      ),
    );
  }
}
