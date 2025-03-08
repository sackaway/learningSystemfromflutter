import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningsystem/pages/admin_dashboard.dart';
import 'package:learningsystem/pages/assign_course_page.dart';
import 'package:learningsystem/pages/create_user_page.dart';
import 'package:learningsystem/pages/progress_page.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/theme_provider.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/course_detail_page.dart';
import 'pages/video_player_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProgressProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // ✅ ใช้ ThemeProvider
      ],
      child: MyApp(),
    ),
  );
}

// ✅ ตั้งค่า Routing
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/admin', builder: (context, state) => AdminDashboardPage()), // ✅ Route ไป Admin Dashboard
    GoRoute(path: '/progress', builder: (context, state) => ProgressPage()), // ✅ Route ไปหน้า Progress
    GoRoute(path: '/assign', builder: (context, state) => AssignCoursePage()), // ✅ Route ไปหน้า Assign Course
    GoRoute(path: '/create-user', builder: (context, state) => CreateUserPage()),
    GoRoute(
      path: '/course/:courseId',
      builder: (context, state) {
        final String courseId = state.pathParameters['courseId']!;
        return CourseDetailPage(courseId: courseId);
      },
    ),
    GoRoute(
      path: '/video/:videoUrl/:courseId/:sectionTitle',
      builder: (context, state) {
        final String videoUrl = Uri.decodeComponent(state.pathParameters['videoUrl']!);
        final String courseId = state.pathParameters['courseId']!;
        final String sectionTitle = Uri.decodeComponent(state.pathParameters['sectionTitle']!);
        return VideoPlayerPage(videoUrl: videoUrl, courseId: courseId, sectionTitle: sectionTitle);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: _lightTheme, // ✅ ธีมขาว (มินิมอล)
      darkTheme: _darkTheme, // ✅ ธีมมืด (มินิมอล)
      routerConfig: _router,
    );
  }
}

// ✅ ธีมขาว มินิมอล (Light Theme)
final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Color(0xFFF8F8F8), // สีขาวครีม
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  cardColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.grey[800], fontSize: 14),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  iconTheme: IconThemeData(color: Colors.black),
);

// ✅ ธีมมืด มินิมอล (Dark Theme)
final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Color(0xFF121212), // สีดำเทา
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  cardColor: Color(0xFF1E1E1E),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.grey[400], fontSize: 14),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Color(0xFF1E1E1E),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);
