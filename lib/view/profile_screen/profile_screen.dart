import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/profile_screen_provider.dart';
import '../../resources/widgets/custom_text.dart';
import '../Auth/login_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              }


            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data when screen loads
    Provider.of<ProfileProvider>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, _) {
          final username = profile.username;
          final email = profile.email;


          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(
                  (username != null && username.isNotEmpty) ? username[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('User Name'),
                subtitle: Text(username ?? 'Loading'),
              ),

              const Divider(),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(email ?? 'Loading'),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const CustomText(text:'Logout', color: Colors.black,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _logout,
              ),
            ],
          );
        },
      ),
    );
  }
}
