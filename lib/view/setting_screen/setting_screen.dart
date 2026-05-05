import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_taking_application/controller/api_provider.dart';
import '../profile_screen/profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _entries = [
    'Entry 1',
    'Entry 2',
    'Entry 3',
    'Entry 4',
  ];

  static const Color primaryColor = Color(0xFF3F5C4A);

  void _showEntriesSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.builder(
            itemCount: _entries.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.list, color: primaryColor),
                title: Text(_entries[index]),
              );
            },
          ),
        );
      },
    );
  }

  void _downloadEntriesSheet() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading entries sheet...')),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Consumer<ApiProvider>(
        builder: (context,controller,child) {
          return ListView(
            children: [
              _buildSectionTitle("Account"),
              _buildSettingsCard(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              _buildSettingsCard(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("About App"),
                      content: const Text("This will be update soon"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              _buildSectionTitle("Entries"),
              _buildSettingsCard(
                icon: Icons.list_alt,
                title: 'Show Entries Sheet',
                onTap:()async {
                  await controller.openBookDataSpreadSheet();
                },
              ),
              _buildSettingsCard(
                icon: Icons.download_rounded,
                title: 'Download Entries Sheet',
                onTap: ()async {
                  await controller.downloadExcelSheetAvailableBooks();
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
