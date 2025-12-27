import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_guide/core/auth/auth_service.dart';
import 'package:tourist_guide/core/providers/theme_provider.dart';

// اللون الأساسي الذي تستخدمه في تطبيقك
const Color primaryColor = Color(0xFF0098DB);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  void logout() async {
    await _authService.signOut();
    // إعادة التوجيه إلى صفحة تسجيل الدخول أو الصفحة الرئيسية بعد تسجيل الخروج
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: ListView(
        children: [
          // --- 1. رأس الصفحة (معلومات المستخدم) ---
          _buildProfileHeader(
            name: "لقمان الضلعي",
            email: "loqman770534629@gmail.com",
            imageUrl:
                'https://static.vecteezy.com/system/resources/previews/009/734/564/original/default-avatar-profile-icon-of-social-media-user-vector.jpg',
          ),
          SizedBox(height: 20),

          // --- 2. قائمة الخيارات (الإعدادات) ---
          _buildSettingsGroup(),

          SizedBox(height: 20),

          // --- 3. قائمة الخيارات (الدعم) ---
          _buildSupportGroup(),

          SizedBox(height: 30),

          // --- 4. زر تسجيل الخروج ---
          _buildLogoutButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- ودجت: رأس الصفحة ---
  Widget _buildProfileHeader({
    required String name,
    required String email,
    required String imageUrl,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: isDark 
                ? theme.colorScheme.surface 
                : Colors.grey[200],
            backgroundImage: NetworkImage(imageUrl),
            // في حال عدم وجود صورة، اعرض أيقونة
            child: imageUrl.isEmpty
                ? Icon(
                    Icons.person, 
                    size: 50, 
                    color: theme.textTheme.bodySmall?.color,
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email, 
            style: TextStyle(
              fontSize: 16, 
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'تعديل الملف الشخصي',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // --- ودجت: مجموعة إعدادات التطبيق ---
  Widget _buildSettingsGroup() {
    final theme = Theme.of(context);
    
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0.5,
          child: Column(
            children: [
              // خيار الوضع الداكن
              SwitchListTile(
                title: Text(
                  themeProvider.isDarkMode ? 'الوضع النهاري' : 'الوضع الليلي',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  themeProvider.isDarkMode 
                      ? 'التبديل إلى الوضع النهاري' 
                      : 'التبديل إلى الوضع الليلي',
                  style: TextStyle(
                    fontSize: 12, 
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                value: themeProvider.isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
                secondary: Icon(
                  themeProvider.isDarkMode 
                      ? Icons.light_mode_outlined 
                      : Icons.dark_mode_outlined,
                  color: themeProvider.isDarkMode 
                      ? Colors.amber 
                      : theme.iconTheme.color,
                ),
                activeColor: primaryColor,
              ),
              _buildDivider(),
              // خيار الإشعارات
              _buildProfileOption(
                icon: Icons.notifications_outlined,
                title: 'الإشعارات',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ودجت: مجموعة الدعم ---
  Widget _buildSupportGroup() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: Column(
        children: [
          _buildProfileOption(
            icon: Icons.help_outline,
            title: 'مركز المساعدة',
            onTap: () {},
          ),
          _buildDivider(),
          _buildProfileOption(
            icon: Icons.info_outline,
            title: 'عن التطبيق',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // --- ودجت: زر تسجيل الخروج ---
  Widget _buildLogoutButton() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: _buildProfileOption(
        icon: Icons.logout,
        title: 'تسجيل الخروج',
        color: Colors.red, // تمييز بلون أحمر
        onTap: logout,
      ),
    );
  }

  // ودجت مساعد لبناء خيارات القائمة
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color, // اللون الاختياري
  }) {
    final theme = Theme.of(context);
    final optionColor = color ?? theme.textTheme.bodyLarge?.color;
    
    return ListTile(
      leading: Icon(icon, color: optionColor),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500, 
          color: optionColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: theme.textTheme.bodySmall?.color?.withOpacity(0.5),
      ),
      onTap: onTap,
    );
  }

  // ودجت مساعد لخط فاصل
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).dividerColor,
      indent: 16,
      endIndent: 16,
    );
  }
}
