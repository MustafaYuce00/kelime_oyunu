import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Settings'),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '@johndoe',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Text("Online", style: TextStyle(color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: const Text('Profile'),
                  subtitle: const Text('Edit your profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.person),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Change Password'),
                  subtitle: const Text('Change your password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.lock),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Manage notifications'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.notifications),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Privacy'),
                  subtitle: const Text('Privacy settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.privacy_tip),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Security'),
                  subtitle: const Text('Security settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.security),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  'General',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: const Text('Language'),
                  subtitle: const Text('Change language'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.language),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Theme'),
                  subtitle: const Text('Change theme'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.color_lens),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Currency'),
                  subtitle: const Text('Change currency'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.money),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Location'),
                  subtitle: const Text('Change location'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.location_on),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('About the app'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.info),
                  onTap: () {},
                ),
              ],
            ),
          ))),
    );
  }
}
