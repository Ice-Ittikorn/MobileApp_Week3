import 'package:flutter/material.dart';

// จุดเริ่มต้นของ App ทุกตัว
void main() {
  runApp(const MyApp());
}

// Root Widget ของแอป
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 02 Lab',
      // ปิด Banner "DEBUG" ที่มุมขวาบน
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// หน้าแรก
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 02 Flutter Lab'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ข้อมูลสรุป',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ใช้ InfoCard ซ้ำได้หลายครั้งด้วย Parameter ต่างกัน
            const InfoCard(
              title: 'จำนวนนักศึกษา',
              value: '42 คน',
              icon: Icons.people,
              color: Colors.indigo,
            ),

            const SizedBox(height: 8),

            const InfoCard(
              title: 'GPA เฉลี่ย',
              value: '3.21',
              icon: Icons.school,
              color: Colors.green,
            ),

            const SizedBox(height: 8),

            InfoCard(
              title: 'รายวิชาที่ลงทะเบียน',
              value: '5 วิชา',
              icon: Icons.book,
              color: Colors.orange,
            ),
            const SizedBox(height: 8),

            InfoCard(
              title: 'คณะ',
              value: 'คณะหมูกรอบ',
              icon: Icons.account_balance,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

// StatelessWidget ที่รับ Parameter
class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color = Colors.indigo, // มีค่า default
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // ไอคอนในวงกลมสี
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            // ข้อมูล
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
