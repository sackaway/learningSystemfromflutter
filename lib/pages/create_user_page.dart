import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/sidebar.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? _image;

  // 📌 ฟังก์ชันเลือกภาพ
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // 📌 ฟังก์ชันสร้างผู้ใช้
  void _createUser() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("สร้างผู้ใช้ใหม่สำเร็จ!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("สร้างผู้ใช้ใหม่")),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 📌 ช่องกรอกข้อมูล
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "อีเมล"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "กรุณากรอกอีเมล" : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "รหัสผ่าน"),
                obscureText: true,
                validator: (value) => value!.length < 6 ? "รหัสผ่านต้องมีอย่างน้อย 6 ตัว" : null,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: "ยืนยันรหัสผ่าน"),
                obscureText: true,
                validator: (value) => value != passwordController.text ? "รหัสผ่านไม่ตรงกัน" : null,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "ชื่อพนักงาน"),
                validator: (value) => value!.isEmpty ? "กรุณากรอกชื่อพนักงาน" : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "เบอร์โทรศัพท์"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length != 10 ? "เบอร์โทรศัพท์ต้องมี 10 หลัก" : null,
              ),
              SizedBox(height: 20),

              // 📌 ส่วนแสดงรูปโปรไฟล์
              Center(
                child: Column(
                  children: [
                    // 📷 แสดงรูปเป็นวงกลม
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    SizedBox(height: 10),

                    // 📌 ปุ่มเลือกรูป
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text("เลือกรูป"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // 📌 ปุ่มสร้างผู้ใช้ใหม่
              ElevatedButton(
                onPressed: _createUser,
                child: Text("สร้างผู้ใช้ใหม่"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
