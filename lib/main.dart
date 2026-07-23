import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 02 Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ─── Main Screen with Bottom Navigation ─────────────────
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    CounterPage(),
    FormPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(icon: Icon(Icons.calculate), label: 'Counter'),
          NavigationDestination(icon: Icon(Icons.edit), label: 'Form'),
          NavigationDestination(icon: Icon(Icons.person), label: 'About'),
        ],
      ),
    );
  }
}

// ─── Page 1: Dashboard ──────────────────────────────────
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClockWidget(),
            SizedBox(height: 16),
            Text(
              'ข้อมูลสรุป',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            InfoCard(
              title: 'นักศึกษา',
              value: '42 คน',
              icon: Icons.people,
              color: Colors.indigo,
            ),
            SizedBox(height: 8),
            InfoCard(
              title: 'GPA เฉลี่ย',
              value: '3.21',
              icon: Icons.school,
              color: Colors.green,
            ),
            SizedBox(height: 8),
            InfoCard(
              title: 'รายวิชา',
              value: '5 วิชา',
              icon: Icons.book,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Page 2: Counter ────────────────────────────────────
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const CounterSection(),
    );
  }
}

// ─── Page 3: Form ───────────────────────────────────────
class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สร้างคำทักทาย'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const GreetingForm(),
    );
  }
}

// ─── Page 4: About ───────────────────────────────────────
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: const AssetImage('img/IMG_0305.JPG'),
                child: const Text(
                  'I',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'ITTIKORN TONGSIMA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'รหัสนักศึกษา: 67030261',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'คณะครุศาสตร์อุตสาหกรรมเเละเทคโนโลยี',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Reusable Widgets ────────────────────────────────────

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
    this.color = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
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

// ─── ClockWidget (StatefulWidget) ───────────────────────

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
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _currentTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.access_time, size: 32, color: Colors.indigo),
              Text(
                '${_pad(_currentTime.hour)}:${_pad(_currentTime.minute)}:${_pad(_currentTime.second)}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_currentTime.day}/${_currentTime.month}/${_currentTime.year + 543}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── CounterSection (StatefulWidget) ────────────────────

class CounterSection extends StatefulWidget {
  const CounterSection({super.key});

  @override
  State<CounterSection> createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  int _count = 0;
  int _step = 1;
  final List<String> _history = [];

  String _pad(int n) => n.toString().padLeft(2, '0');

  void _recordHistory(String actionText) {
    final now = DateTime.now();
    final timeStr = '${_pad(now.hour)}:${_pad(now.minute)}:${_pad(now.second)}';
    _history.insert(0, '$timeStr — $actionText');
  }

  void _increment() {
    setState(() {
      _count += _step;
      _recordHistory('เพิ่ม $_step (รวม: $_count)');
    });
  }

  void _decrement() {
    setState(() {
      _count -= _step;
      _recordHistory('ลด $_step (รวม: $_count)');
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
      _recordHistory('Reset (รวม: $_count)');
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '$_count',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: _count >= 0 ? Colors.indigo : Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'dec',
                onPressed: _decrement,
                backgroundColor: Colors.red.shade50,
                child: const Icon(Icons.remove, color: Colors.red),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: _reset,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                heroTag: 'inc',
                onPressed: _increment,
                backgroundColor: Colors.green.shade50,
                child: const Icon(Icons.add, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Step:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 5, 10, 100]
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text('$s'),
                      selected: _step == s,
                      onSelected: (_) => setState(() => _step = s),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ประวัติการใช้งาน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              OutlinedButton.icon(
                onPressed: _history.isEmpty ? null : _clearHistory,
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('ล้าง History'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _history.isEmpty
                ? const Center(
                    child: Text(
                      'ยังไม่มีประวัติการใช้งาน',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            _history[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── GreetingForm (StatefulWidget) ──────────────────────

class GreetingForm extends StatefulWidget {
  const GreetingForm({super.key});

  @override
  State<GreetingForm> createState() => _GreetingFormState();
}

class _GreetingFormState extends State<GreetingForm> {
  final _nameController = TextEditingController();
  String _selectedLanguage = 'ไทย';
  String _greeting = '';
  String _error = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    setState(() {
      if (name.isEmpty) {
        _error = 'กรุณากรอกชื่อ';
        _greeting = '';
      } else {
        _error = '';
        final h = DateTime.now().hour;
        final isMorning = h < 12;
        final isAfternoon = h >= 12 && h < 17;

        switch (_selectedLanguage) {
          case 'อังกฤษ':
            final timeOfDay = isMorning
                ? 'Good morning'
                : isAfternoon
                ? 'Good afternoon'
                : 'Good evening';
            _greeting = '$timeOfDay, $name! 👋\nWelcome to Flutter';
            break;
          case 'ญี่ปุ่น':
            final timeOfDay = isMorning
                ? 'おはようございます'
                : isAfternoon
                ? 'こんにちは'
                : 'こんばんは';
            _greeting = '$timeOfDay, $name さん! 👋\nFlutterへようこそ';
            break;
          case 'ไทย':
          default:
            final period = isMorning
                ? 'ตอนเช้า'
                : isAfternoon
                ? 'ตอนบ่าย'
                : 'ตอนเย็น';
            _greeting = 'สวัสดี$period คุณ$name! 👋\nยินดีต้อนรับสู่ Flutter';
            break;
        }
      }
    });
  }

  void _clear() {
    _nameController.clear();
    setState(() {
      _selectedLanguage = 'ไทย';
      _greeting = '';
      _error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'ชื่อของคุณ',
              hintText: 'เช่น สมชาย',
              prefixIcon: const Icon(Icons.person),
              border: const OutlineInputBorder(),
              errorText: _error.isEmpty ? null : _error,
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedLanguage,
            decoration: const InputDecoration(
              labelText: 'ภาษาของคำทักทาย',
              prefixIcon: Icon(Icons.language),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'ไทย', child: Text('ไทย')),
              DropdownMenuItem(value: 'อังกฤษ', child: Text('อังกฤษ')),
              DropdownMenuItem(value: 'ญี่ปุ่น', child: Text('ญี่ปุ่น')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedLanguage = value;
                });
              }
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.waving_hand),
                  label: const Text('สร้างคำทักทาย'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: _clear, child: const Text('ล้าง')),
            ],
          ),
          const SizedBox(height: 20),
          if (_greeting.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Text(
                _greeting,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
