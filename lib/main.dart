import 'package:flutter/material.dart';
import 'dart:async'; // เพิ่มบรรทัดนี้ที่ด้านบนของไฟล์ (ต่อจาก import แรก)

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
      body: const SingleChildScrollView(
        child: Column(children: [ClockWidget(), CounterSection()]),
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

class CounterSection extends StatefulWidget {
  const CounterSection({super.key});

  @override
  State<CounterSection> createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  // === State ===
  int _count = 0; // ตัวเลข Counter
  int _step = 1; // ค่าที่เพิ่มแต่ละครั้ง

  // === Methods ===
  void _increment() {
    setState(() {
      _count += _step;
      // ลอง: แก้เป็น _count++ แล้วดูว่าต่างกันไหม
    });
  }

  void _decrement() {
    setState(() {
      if (_count - _step < 0) {
        _count = 0; // ไม่ให้ต่ำกว่า 0
      } else {
        _count -= _step;
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _changeStep(int newStep) {
    setState(() {
      _step = newStep;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Counter Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // แสดงตัวเลข
            Text(
              '$_count',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: _count > 0
                    ? Colors.indigo
                    : _count < 0
                    ? Colors.red
                    : Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            // ปุ่มควบคุม
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'dec',
                  onPressed: _decrement,
                  backgroundColor: Colors.red.shade100,
                  child: const Icon(Icons.remove, color: Colors.red),
                ),
                const SizedBox(width: 16),
                OutlinedButton(onPressed: _reset, child: const Text('Reset')),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'inc',
                  onPressed: _increment,
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.add, color: Colors.green),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // เลือก Step
            const Text('ค่าที่เพิ่มแต่ละครั้ง:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 5, 10].map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('$s'),
                    selected: _step == s,
                    onSelected: (_) => _changeStep(s),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState(); // ❗ ต้องเรียกก่อนเสมอ
    _currentTime = DateTime.now();

    // ตั้ง Timer อัปเดตเวลาทุก 1 วินาที
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        // ❗ ตรวจสอบก่อน setState เสมอ
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ❗ ต้องยกเลิก Timer เพื่อป้องกัน Memory Leak
    super.dispose(); // ❗ ต้องเรียกหลังสุดเสมอ
  }

  String _formatTime(DateTime dt) {
    String h = dt.hour.toString().padLeft(2, '0');
    String m = dt.minute.toString().padLeft(2, '0');
    String s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String _formatDate(DateTime dt) {
    const months = [
      '',
      'ม.ค.',
      'ก.พ.',
      'มี.ค.',
      'เม.ย.',
      'พ.ค.',
      'มิ.ย.',
      'ก.ค.',
      'ส.ค.',
      'ก.ย.',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
    ];
    return '${dt.day} ${months[dt.month]} ${dt.year + 543}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.access_time, size: 40, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(
              _formatTime(_currentTime),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              _formatDate(_currentTime),
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
