import 'package:demo_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primaryLight, AppTheme.primary]),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    'CN',
                    style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Company Name Logo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Home
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              // Handle Home tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          // My Info - Active state
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: ListTile(
                leading: const Icon(Icons.person, color: AppTheme.primary),
                title: const Text('My Info',
                    style: TextStyle(color: AppTheme.primary)),
                selected: true,
                selectedTileColor: AppTheme.primaryExtraLight
                    .withAlpha(50), // Light background for active item
                onTap: () {
                  // Handle My Info tap
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // People
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('People'),
            onTap: () {
              // Handle People tap
              Navigator.pop(context);
            },
          ),
          // Hiring
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Hiring'),
            onTap: () {
              // Handle Hiring tap
              Navigator.pop(context);
            },
          ),
          // Reports
          ListTile(
            leading: const Icon(Icons.insert_chart_outlined),
            title: const Text('Reports'),
            onTap: () {
              // Handle Reports tap
              Navigator.pop(context);
            },
          ),
          // Files
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Files'),
            onTap: () {
              // Handle Files tap
              Navigator.pop(context);
            },
          ),
          // Compensation
          ListTile(
            leading: const Icon(Icons.attach_money_outlined),
            title: const Text('Compensation'),
            onTap: () {
              // Handle Compensation tap
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
