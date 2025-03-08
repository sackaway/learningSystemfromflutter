import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // ✅ พื้นหลังสีอ่อน
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          width: 380, // ✅ ปรับขนาดให้ไม่ใหญ่เกินไป
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ โลโก้
              Icon(Icons.lock, size: 50, color: Colors.blueGrey),
              SizedBox(height: 10),

              // ✅ หัวข้อ Login
              Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
              ),
              SizedBox(height: 20),

              // ✅ ช่องกรอก Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 15),

              // ✅ ช่องกรอก Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),

              // ✅ ลืมรหัสผ่าน
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("ลืมรหัสผ่าน?", style: TextStyle(color: Colors.blueGrey[700])),
                ),
              ),

              SizedBox(height: 10),

              // ✅ ปุ่ม Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isNotEmpty && password.isNotEmpty) {
                      context.read<AuthProvider>().login(email);
                      context.go('/home'); // ไปหน้าเลือกคอร์ส
                    }
                  },
                  child: Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
                ),
              ),

              SizedBox(height: 10),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("ยังไม่มีบัญชี?", style: TextStyle(color: Colors.blueGrey[700])),
              //     TextButton(
              //       onPressed: () {
              //         context.go('/register'); // ไปหน้า Register
              //       },
              //       child: Text("สมัครสมาชิก", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[900])),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
