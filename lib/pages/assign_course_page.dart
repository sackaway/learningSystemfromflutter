import 'package:flutter/material.dart';
import '../widgets/sidebar.dart'; // ✅ Import Sidebar

class AssignCoursePage extends StatefulWidget {
  @override
  _AssignCoursePageState createState() => _AssignCoursePageState();
}

class _AssignCoursePageState extends State<AssignCoursePage> {
  final List<String> employees = ["Alice", "Bob", "Charlie"];
  final List<String> courses = ["Flutter", "Dart", "UI/UX"];
  String? selectedEmployee;
  String? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assign คอร์สให้พนักงาน")),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("เลือกพนักงาน"),
            DropdownButton<String>(
              value: selectedEmployee,
              isExpanded: true,
              items: employees.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => selectedEmployee = value),
            ),
            SizedBox(height: 20),
            Text("เลือกคอร์ส"),
            DropdownButton<String>(
              value: selectedCourse,
              isExpanded: true,
              items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => selectedCourse = value),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: selectedEmployee != null && selectedCourse != null
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Assign ${selectedCourse!} ให้ ${selectedEmployee!} สำเร็จ!")),
                );
              }
                  : null,
              child: Text("Assign คอร์ส"),
            ),
          ],
        ),
      ),
    );
  }
}
