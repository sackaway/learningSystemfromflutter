import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningsystem/providers/progress_provider.dart';
import 'package:learningsystem/widgets/sidebar.dart'; // ✅ Import Sidebar
import 'package:provider/provider.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseId;

  CourseDetailPage({required this.courseId});

  final Map<String, dynamic> courseDetails = {
    "1": {
      "title": "Flutter for Beginners",
      "instructor": "John Doe",
      "image": "https://source.unsplash.com/800x400/?flutter",
      "description": "เรียนรู้พื้นฐาน Flutter และ Dart เพื่อสร้างแอปมือถือ",
      "duration": "10 ชั่วโมง",
      "sections": [
        {"title": "Introduction to Flutter", "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"},
        {"title": "Dart Basics", "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"},
        {"title": "Flutter Widgets", "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"},
        {"title": "Building a Simple App", "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"},
        {"title": "State Management", "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"},
      ],
    }
  };

  @override
  Widget build(BuildContext context) {
    final course = courseDetails[courseId] ?? {
      "title": "Course Not Found",
      "instructor": "-",
      "image": "https://source.unsplash.com/800x400/?error",
      "description": "No details available",
      "duration": "0 ชั่วโมง",
      "sections": [],
    };

    final totalSections = course["sections"].length;
    final progressProvider = context.watch<ProgressProvider>();
    final progress = progressProvider.getProgress(courseId, totalSections);

    return Scaffold(
      appBar: AppBar(title: Text(course["title"])),
      drawer: Sidebar(), // ✅ เพิ่ม Sidebar ในทุกหน้า
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ รูปภาพคอร์ส
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(course["image"], height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),

              // ✅ ชื่อคอร์ส
              Text(course["title"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // ✅ สอนโดยใคร
              Text("👨‍🏫 สอนโดย: ${course["instructor"]}", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              SizedBox(height: 10),

              // ✅ ระยะเวลาเรียน
              Text("⏳ ระยะเวลาเรียน: ${course["duration"]}", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              SizedBox(height: 10),

              // ✅ รายละเอียดของคอร์ส
              Text("📖 รายละเอียด:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(course["description"], style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // ✅ Progress Bar แสดง % การเรียน
              Text("Progress: ${(progress * 100).toInt()}%"),
              LinearProgressIndicator(value: progress),
              SizedBox(height: 20),

              // ✅ รายชื่อ Sections ที่ต้องเรียน
              Text("📚 เนื้อหาการเรียน (${totalSections} Sections)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: totalSections,
                itemBuilder: (context, index) {
                  final section = course["sections"][index];
                  return ListTile(
                    leading: Icon(
                      progressProvider.isSectionCompleted(courseId, section["title"])
                          ? Icons.check_circle
                          : Icons.play_circle_fill,
                      color: Colors.red,
                    ),
                    title: Text(section["title"]),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      context.go('/video/${Uri.encodeComponent(section["videoUrl"])}/$courseId/${Uri.encodeComponent(section["title"])}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
