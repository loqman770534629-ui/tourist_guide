import 'package:flutter/material.dart';
import 'package:tourist_guide/featuers/home/pages/favorites_page.dart';
import 'package:tourist_guide/featuers/home/pages/home_page.dart';
import 'package:tourist_guide/featuers/home/pages/notofication_page.dart'
    hide primaryColor;
import 'package:tourist_guide/featuers/home/pages/profile_page.dart'
    hide primaryColor;
import 'package:tourist_guide/featuers/home/pages/reservations_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    NotificationsPage(),
    FavoritesPage(),
    HomePage(), // هذه هي صفحتك التي أنشأتها
    ReservationsPage(),
    ProfilePage(),
  ];

  // دالة لتغيير الصفحة عند الضغط
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // إزالة تأثير الضغط
          highlightColor: Colors.transparent, // إزالة تأثير التمييز
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: false, // تعطيل الاهتزاز عند الضغط

          items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_on_sharp),
            activeIcon: Icon(Icons.notifications_active),
            label: 'الاشعارات',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'المفضلات',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Builder(
              builder: (context) {
                final primaryColor = Theme.of(context).colorScheme.primary;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryColor, // لون الخلفية الأزرق
                    borderRadius: BorderRadius.circular(20), // حواف دائرية
                  ),
                  child: const Icon(Icons.home_filled, color: Colors.white),
                );
              },
            ),
            label: 'الرئيسية',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star),
            label: 'الحجوزات',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'البروفايل',
          ),
        ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

          selectedItemColor: primaryColor, // لون الأيقونة والنص المحدد
          unselectedItemColor: Colors.grey.shade600, // لون العناصر غير المحددة
          showSelectedLabels: true, // إظهار النص المحدد
          showUnselectedLabels: true, // إظهار النصوص غير المحددة
        ),
      ),
    );
  }
}
