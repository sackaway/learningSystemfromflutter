import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learningsystem/widgets/sidebar.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {"id": "1", "title": "หลักสูตร คอส1", "image": "https://source.unsplash.com/250x150/?marketing"},
    {"id": "2", "title": "หลักสูตร คอส2", "image": "https://source.unsplash.com/250x150/?content"},
    {"id": "3", "title": "หลักสูตร คอส3", "image": "https://source.unsplash.com/250x150/?strategy"},
    {"id": "4", "title": "หลักสูตร คอส4", "image": "https://source.unsplash.com/250x150/?seo"},
    {"id": "5", "title": "หลักสูตร คอส5", "image": "https://source.unsplash.com/250x150/?facebook"},
    {"id": "6", "title": "หลักสูตร คอส6", "image": "https://source.unsplash.com/250x150/?design"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เลือกหลักสูตร", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ หัวข้อหลัก
            Text(
              "เลือกหลักสูตร",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "เรามีหลักสูตรให้เลือกเรียนมากมาย คลิกที่ชื่อหลักสูตรเพื่อดูรายละเอียด",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // ✅ Grid Layout
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  double cardWidth = constraints.maxWidth / crossAxisCount - 20; // ✅ ลดความกว้างของการ์ดลง

                  if (constraints.maxWidth < 1000) {
                    crossAxisCount = 2;
                    cardWidth = constraints.maxWidth / crossAxisCount - 20;
                  }
                  if (constraints.maxWidth < 600) {
                    crossAxisCount = 1;
                    cardWidth = constraints.maxWidth / crossAxisCount - 20;
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.8, // ✅ ปรับให้การ์ดไม่กว้างเกินไป
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.go('/course/${courses[index]['id']}');
                        },
                        child: SizedBox(
                          width: cardWidth, // ✅ จำกัดความกว้างของการ์ด
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                            child: Stack(
                              children: [
                                // ✅ รูปภาพพื้นหลัง
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      courses[index]['image']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // ✅ Gradient Overlay
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                // ✅ ชื่อคอร์ส (แสดงอยู่บนภาพ)
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Text(
                                    courses[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
