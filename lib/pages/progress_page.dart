import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // ✅ ใช้สำหรับ Chart
import '../widgets/sidebar.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final List<Map<String, dynamic>> employees = [
    {
      "name": "Alice",
      "progress": 100,
      "image": "https://source.unsplash.com/100x100/?woman",
      "courses": [
        {"title": "Flutter for Beginners", "progress": 100, "sections": ["Introduction", "Widgets", "State Management"]}
      ]
    },
    {
      "name": "Bob",
      "progress": 50,
      "image": "https://source.unsplash.com/100x100/?man",
      "courses": [
        {"title": "Flutter for Beginners", "progress": 50, "sections": ["Introduction", "Widgets"]}
      ]
    },
    {
      "name": "Charlie",
      "progress": 30,
      "image": "https://source.unsplash.com/100x100/?boy",
      "courses": [
        {"title": "Flutter for Beginners", "progress": 30, "sections": ["Introduction"]}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    int completed = employees.where((e) => e["progress"] == 100).length;
    int inProgress = employees.where((e) => e["progress"] < 100).length;

    return Scaffold(
      appBar: AppBar(title: Text("Progress พนักงาน")),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // 📊 Chart สรุป Progress
            Text("สรุปการเรียนของพนักงาน", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: completed.toDouble(),
                      title: "จบแล้ว ($completed)",
                      radius: 50,
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: inProgress.toDouble(),
                      title: "ยังไม่จบ ($inProgress)",
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // 📌 รายการพนักงานพร้อม Progress Bar
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(employees[index]["image"]),
                    ),
                    title: Text(employees[index]["name"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: employees[index]["progress"] / 100,
                          backgroundColor: Colors.grey[300],
                          color: Colors.green,
                        ),
                        Text("${employees[index]["progress"]}%"),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: employees[index]["courses"].map<Widget>((course) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("📚 ${course["title"]} - ${course["progress"]}%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ...course["sections"].map<Widget>((section) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Text("• $section"),
                                  );
                                }).toList(),
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
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
