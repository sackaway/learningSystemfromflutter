import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sidebar.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      drawer: Sidebar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/progress'),
              child: Text("ดู Progress พนักงาน"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/assign'),
              child: Text("Assign คอร์สให้พนักงาน"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/create-user'),
              child: Text("สร้างผู้ใช้ใหม่"),
            ),
          ],
        ),
      ),
    );
  }
}
