# Experiment 2: Hello World App

## Aim
To create a simple "Hello, World!" application in Flutter to understand the basic project structure and fundamental layout widgets.

## Theory
The basic building blocks of a Flutter app are widgets. 
- **`MaterialApp`**: A convenience widget that wraps a number of widgets commonly required for Material Design applications.
- **`Scaffold`**: Implements the basic Material Design visual layout structure.
- **`AppBar`**: A material design app bar, usually displayed at the top of the screen.
- **`Center`**: A layout widget that centers its child within itself.
- **`Text`**: A widget that displays a string of text with a single style.

## Code
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const HelloWorldApp());
}

class HelloWorldApp extends StatelessWidget {
  const HelloWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World App'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
```

## Expected Output
The application should launch displaying a full screen with a blue App Bar titled "Hello World App" at the top (with white text). The center of the screen will show the text "Hello, World!" in a large (32 font size), bold font.
