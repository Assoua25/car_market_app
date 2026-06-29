import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'add_car_screen.dart';
import 'profile_screen.dart';

// ============================================================
// ÉCRAN NAVIGATION : BottomNavigationBar avec les écrans
// ============================================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Liste des écrans (sans AddCarScreen qui s'ouvre en modal)
  final List<Widget> _screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 1) {
      // Onglet "Ajouter" : ouvre AddCarScreen en push (modal)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddCarScreen(),
          fullscreenDialog: true,
        ),
      ).then((_) {
        // Rafraîchir la page d'accueil après ajout
        setState(() {});
      });
    } else {
      setState(() {
        _currentIndex = index == 0 ? 0 : 1; // Accueil=0, Profil=1
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex == 0 ? 0 : 2, // Décalage à cause de +
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: AppTheme.accentColor,
              radius: 16,
              child: Icon(Icons.add, color: Colors.white, size: 20),
            ),
            label: 'Vendre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}