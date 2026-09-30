# Experiment 8: Libraries & Working with Files

## Aim
To manage dependencies using `pubspec.yaml`, use external libraries like `shared_preferences` and `path_provider`, and perform file I/O operations including reading/writing plain text and JSON.

## Theory
- **pub.dev & pubspec.yaml**: `pub.dev` is the official package repository for Dart and Flutter. Dependencies are managed in the `pubspec.yaml` file. Running `flutter pub get` fetches them into the project.
- **`shared_preferences`**: A package that provides a persistent store for simple data (key-value pairs) like strings, integers, and booleans. It uses `SharedPreferences` on Android and `NSUserDefaults` on iOS.
- **`path_provider`**: A plugin for finding commonly used locations on the filesystem, such as the `temp` and `app_data` directories.
- **File I/O**: The `dart:io` library provides the `File` class. Using the path from `path_provider`, we can write strings to files `writeAsString()` (with `FileMode.append` for appending), read them `readAsString()`, and delete them `delete()`.
- **JSON Serialization**: The `dart:convert` library provides `jsonEncode` (converts Dart objects to JSON strings) and `jsonDecode` (converts JSON strings to Dart dynamic Maps/Lists). A custom data model (e.g., `Note`) typically defines `toJson` and `fromJson` methods to map between objects and JSON.

## Steps
1. Add dependencies to `pubspec.yaml` (`path_provider`, `shared_preferences`, `http`).
2. Create `lib/services/prefs_service.dart` to abstract `shared_preferences` interactions.
3. Create `lib/services/file_service.dart` to handle fetching the local path via `path_provider` and handling `File` read, write, append, and delete operations.
4. Create a `lib/models/note.dart` data model with `toJson()` and `fromJson()`.
5. Build a `StatefulWidget` dashboard with three sections:
   - **SharedPreferences**: A text field and button to save/load a username.
   - **File I/O**: Buttons to Write, Append, Delete, and Refresh a text file, and a container showing its contents. Errors are caught via `try/catch` and shown using a `SnackBar`.
   - **JSON Persistence**: A button to generate dummy `Note` objects, encode a `List<Note>` to JSON, write it to a file, and then decode and display it using a `ListView`.
