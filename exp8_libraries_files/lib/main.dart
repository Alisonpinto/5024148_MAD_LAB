import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/note.dart';
import 'services/file_service.dart';
import 'services/prefs_service.dart';

void main() {
  runApp(const Exp8App());
}

class Exp8App extends StatelessWidget {
  const Exp8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libraries & Files',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PrefsService _prefsService = PrefsService();
  final FileService _fileService = FileService();
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fileContentController = TextEditingController();

  String _savedUsername = 'Unknown';
  String _fileContents = 'No file found.';
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await _loadUsername();
    await _refreshFileContents();
    await _loadNotes();
  }

  Future<void> _loadUsername() async {
    final name = await _prefsService.getUsername();
    setState(() {
      _savedUsername = name ?? 'Unknown';
    });
  }

  Future<void> _saveUsername() async {
    if (_usernameController.text.isNotEmpty) {
      await _prefsService.saveUsername(_usernameController.text);
      _usernameController.clear();
      await _loadUsername();
      _showSnackbar('Username saved!');
    }
  }

  Future<void> _refreshFileContents() async {
    final contents = await _fileService.readData();
    setState(() {
      _fileContents = contents.isEmpty ? 'File is empty.' : contents;
    });
  }

  Future<void> _writeFile() async {
    try {
      if (_fileContentController.text.isNotEmpty) {
        await _fileService.writeData(_fileContentController.text);
        await _refreshFileContents();
        _showSnackbar('File overwritten!');
      }
    } catch (e) {
      _showSnackbar('Error: $e');
    }
  }

  Future<void> _appendFile() async {
    try {
      if (_fileContentController.text.isNotEmpty) {
        await _fileService.appendData(_fileContentController.text);
        await _refreshFileContents();
        _showSnackbar('Text appended!');
      }
    } catch (e) {
      _showSnackbar('Error: $e');
    }
  }

  Future<void> _deleteFile() async {
    try {
      await _fileService.deleteData();
      await _refreshFileContents();
      _showSnackbar('File deleted!');
    } catch (e) {
      _showSnackbar('Error: $e');
    }
  }

  Future<void> _loadNotes() async {
    final jsonStr = await _fileService.readJson();
    final List<dynamic> decoded = jsonDecode(jsonStr);
    setState(() {
      _notes = decoded.map((e) => Note.fromJson(e)).toList();
    });
  }

  Future<void> _saveNotes() async {
    final newNote = Note(title: 'Note ${_notes.length + 1}', content: 'Timestamp: ${DateTime.now()}');
    final updatedList = List<Note>.from(_notes)..add(newNote);
    final jsonStr = jsonEncode(updatedList.map((e) => e.toJson()).toList());
    await _fileService.writeJson(jsonStr);
    await _loadNotes();
    _showSnackbar('Note saved as JSON!');
  }

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _buildSection(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libraries & File I/O'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              '1. Shared Preferences',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current User: $_savedUsername', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(labelText: 'Enter new username', border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: _saveUsername, child: const Text('Save')),
                    ],
                  ),
                ],
              ),
            ),

            _buildSection(
              '2. File I/O Operations',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _fileContentController,
                    decoration: const InputDecoration(labelText: 'Enter text for file', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      ElevatedButton(onPressed: _writeFile, child: const Text('Write')),
                      ElevatedButton(onPressed: _appendFile, child: const Text('Append')),
                      ElevatedButton(onPressed: _deleteFile, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white), child: const Text('Delete')),
                      ElevatedButton(onPressed: _refreshFileContents, child: const Text('Refresh')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                    child: Text(_fileContents, style: const TextStyle(fontFamily: 'monospace')),
                  ),
                ],
              ),
            ),

            _buildSection(
              '3. JSON Persistence',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(onPressed: _saveNotes, child: const Text('Add Dummy Note & Save JSON')),
                  const SizedBox(height: 10),
                  _notes.isEmpty 
                    ? const Text('No notes stored.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _notes.length,
                        itemBuilder: (context, index) {
                          final note = _notes[index];
                          return ListTile(
                            leading: const Icon(Icons.note),
                            title: Text(note.title),
                            subtitle: Text(note.content),
                          );
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
