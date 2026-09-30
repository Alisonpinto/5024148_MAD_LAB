import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// Firebase.initializeApp() must be called before any Firebase services can be used.
// It initializes the Firebase app using the default FirebaseOptions (which flutterfire configures in firebase_options.dart).
// For simplicity in this lab before flutterfire configure is run, we wrap it in a try-catch,
// but usually it just looks like: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed (Did you run flutterfire configure?): $e");
  }
  runApp(const FirebaseAppLab());
}

class FirebaseAppLab extends StatelessWidget {
  const FirebaseAppLab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Realtime DB Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const StudentManager(),
    );
  }
}

class StudentManager extends StatefulWidget {
  const StudentManager({super.key});

  @override
  State<StudentManager> createState() => _StudentManagerState();
}

class _StudentManagerState extends State<StudentManager> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  // DatabaseReference provides a reference to a specific node in the database.
  // Here we refer to the 'students' node at the root of the database.
  final DatabaseReference _studentsRef = FirebaseDatabase.instance.ref().child('students');

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _addStudent() {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    
    if (name.isNotEmpty && age.isNotEmpty) {
      // push() generates a unique random key for the new child node.
      // This allows adding multiple students to the 'students' node without overwriting each other.
      final newStudentRef = _studentsRef.push();
      
      newStudentRef.set({
        'name': name,
        'age': age,
      }).then((_) {
        _nameController.clear();
        _ageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student Added Successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add student: $error')),
        );
      });
    }
  }

  void _deleteStudent(String key) {
    // remove() deletes the node at this specific database reference location.
    _studentsRef.child(key).remove().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student Deleted')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Database'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Add New Student', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Student Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _addStudent,
                      child: const Text('Add Student'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Students List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              // StreamBuilder with DatabaseReference.onValue listens for real-time updates from Firebase.
              // Whenever the 'students' node changes (add, update, delete), it rebuilds with new data.
              child: StreamBuilder<DatabaseEvent>(
                stream: _studentsRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                    return const Center(child: Text('No students found in database.'));
                  }

                  // Data comes as a Map where keys are the push() IDs and values are the student Maps.
                  final studentsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  final studentsList = studentsMap.entries.map((e) {
                    return {
                      'key': e.key,
                      'name': e.value['name'],
                      'age': e.value['age'],
                    };
                  }).toList();

                  return ListView.builder(
                    itemCount: studentsList.length,
                    itemBuilder: (context, index) {
                      final student = studentsList[index];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(student['name'] ?? ''),
                          subtitle: Text('Age: ${student['age'] ?? ''}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteStudent(student['key']),
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
