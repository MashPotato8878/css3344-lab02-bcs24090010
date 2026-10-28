import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime _selectedMaterialDate = DateTime.now();
  DateTime _selectedCupertinoDate = DateTime.now();
  String _selectedMaterialRole = 'Student';
  String _selectedCupertinoHouse = 'Student';

  final List<String> _roles = ['Student', 'Developer', 'Designer', 'Guest'];

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedMaterialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedMaterialDate) {
      setState(() {
        _selectedMaterialDate = picked;
      });
    }
  }

  void _selectCupertinoDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _selectedCupertinoDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedCupertinoDate = newDate;
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  void _selectCupertinoHouse(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController: FixedExtentScrollController(
                  initialItem: _roles.indexOf(_selectedCupertinoHouse),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedCupertinoHouse = _roles[index];
                  });
                },
                children: _roles.map((role) => Center(child: Text(role))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: Student Details Card ---
  Widget _buildStudentDetails() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Goh Min Jie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const Text(
              'Student ID: BCS24090010',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Divider(height: 20, thickness: 1),
            const Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              '"To pass my degree with flying colours and work hard to make my family happy"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }

  // --- SECTION 2: Location, Image, and Pickers ---
  List<Widget> _buildLocationAndPickers() {
    return [
      const TitleSection(
        title: 'China Shanghai Skyline',
        subtitle: 'Shanghai, China',
        rating: 49,
      ),
      const SizedBox(height: 8),
      const ImageSection(imagePath: 'assets/spot.jpg'),
      const SizedBox(height: 24),
      const Divider(thickness: 1),
      const Text(
        'Interactive Pickers (Lab 02)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 12),

      // Date Pickers Row
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
              onPressed: () => _selectMaterialDate(context),
              child: Text(
                'Material Date\n${_selectedMaterialDate.toLocal().toString().split(' ')[0]}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              color: CupertinoColors.activeBlue,
              onPressed: () => _selectCupertinoDate(context),
              child: Text(
                'Cupertino Date\n${_selectedCupertinoDate.toLocal().toString().split(' ')[0]}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),

      // Selection Pickers Row
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: DropdownButtonFormField<String>(
                value: _selectedMaterialRole,
                decoration: const InputDecoration(
                  labelText: 'Dropdown',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role, style: const TextStyle(fontSize: 11)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedMaterialRole = newValue;
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                ),
                onPressed: () => _selectCupertinoHouse(context),
                child: Text(
                  'Wheel: $_selectedCupertinoHouse',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  // --- Adaptive Views ---
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildStudentDetails(), // Section 1 on top
        const SizedBox(height: 16),
        ..._buildLocationAndPickers(), // Section 2 below it
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildStudentDetails(), // Section 1 on the left side
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: _buildLocationAndPickers(), // Section 2 on the right side
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int rating;

  const TitleSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 4),
          Text('$rating', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}