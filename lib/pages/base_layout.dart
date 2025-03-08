import 'package:flutter/material.dart';
import '../widgets/sidebar.dart'; // ✅ Import Sidebar

class BaseLayout extends StatelessWidget {
  final Widget child;

  BaseLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Learning Platform")),
      drawer: Sidebar(), // ✅ ใส่ Sidebar ไว้ทุกหน้า
      body: child,
    );
  }
}
