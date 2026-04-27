import 'package:flutter/material.dart';
import 'package:manga/features/watchlists/presentation/page/watchlist_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar + Nom + Email
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/ben.jpg"),
            ),
            const SizedBox(height: 10),

            const Text(
              "Ben Said",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const Text(
              "bensaid@email.com",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [_StatItem(title: "Watchlist", value: "07")],
            ),

            const SizedBox(height: 30),

            //Boutons
            _buildButton(
              icon: Icons.bookmark,
              color: Colors.grey,

              text: "Ma Watchlist",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WatchlistPage()),
                );
              },
            ),

            _buildButton(
              icon: Icons.settings,
              color: Colors.grey,
              text: "Paramètres",
              onTap: () {},
            ),

            _buildButton(
              icon: Icons.logout,
              text: "Déconnexion",
              color: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  //Widget bouton
  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

//Widget Stat
class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }
}
