import 'package:flutter/material.dart';

void main() {
  runApp(const CommonWidgetsApp());
}

class CommonWidgetsApp extends StatelessWidget {
  const CommonWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common Widgets UI',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const CommonWidgetsScreen(),
    );
  }
}

class CommonWidgetsScreen extends StatefulWidget {
  const CommonWidgetsScreen({super.key});

  @override
  State<CommonWidgetsScreen> createState() => _CommonWidgetsScreenState();
}

class _CommonWidgetsScreenState extends State<CommonWidgetsScreen> {
  bool _switchValue = false;
  bool _checkboxValue = false;

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Widgets'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Text Widget'),
            const Text(
              'This is a standard Text widget. It is used to display strings on the screen.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),

            _buildSectionHeader('2. Image.network Widget'),
            Center(
              child: Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const Divider(),

            _buildSectionHeader('3. ElevatedButton Widget'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Button Pressed!')),
                  );
                },
                child: const Text('Click Me'),
              ),
            ),
            const Divider(),

            _buildSectionHeader('4. TextField Widget'),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter some text',
                border: OutlineInputBorder(),
              ),
            ),
            const Divider(),

            _buildSectionHeader('5. Switch Widget'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable notifications', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            const Divider(),

            _buildSectionHeader('6. CheckboxListTile Widget'),
            CheckboxListTile(
              title: const Text('Accept Terms and Conditions'),
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(),

            _buildSectionHeader('7. Card with ListTile Widget'),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.album, size: 40, color: Colors.indigo),
                title: const Text('Heart Shaker'),
                subtitle: const Text('TWICE - Merry & Happy'),
                trailing: const Icon(Icons.more_vert),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
