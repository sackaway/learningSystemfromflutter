import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          // ✅ ส่วนหัว Sidebar (โปรไฟล์ผู้ใช้)
          UserAccountsDrawerHeader(
            accountName: Text(authProvider.userEmail ?? "Guest"),
            accountEmail: Text(authProvider.userEmail == "admin@example.com" ? "Admin" : "User"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://source.unsplash.com/100x100/?face"),
            ),
          ),
          ListTile(
          leading: Icon(Icons.dashboard),
          title: Text("Home"),
          onTap: () => context.go('/home'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () => context.go('/admin'),
          ),
          Divider(),
          // ✅ ปุ่มเปลี่ยนธีม
          ListTile(
            leading: Icon(themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            title: Text("เปลี่ยนธีม"),
            onTap: () => themeProvider.toggleTheme(),
          ),
          Divider(),

          // ✅ ปุ่ม Logout
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              authProvider.userEmail = null;
              context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
