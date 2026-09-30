# Experiment 4: Interactive Form Widget

## Aim
To build an interactive registration form using the `Form` widget, handle user inputs via controllers, and implement robust field validation.

## Theory
Handling user input efficiently is crucial for interactive applications.
- **`Form` & `GlobalKey<FormState>`**: The `Form` widget acts as a container for grouping multiple form fields. The `GlobalKey<FormState>` allows us to trigger validation across all fields simultaneously.
- **`TextFormField`**: A specialized `TextField` wrapped in a `FormField` to integrate seamlessly with the `Form` widget's validation logic.
- **`TextEditingController`**: Controllers allow reading text input values dynamically and clearing/updating inputs programmatically. They must be disposed of when the widget is destroyed.
- **Validation**: The `validator` property of a `TextFormField` receives the input value and returns a `String` if an error occurs, or `null` if the input is valid. Regex (Regular Expressions) can be used for advanced validations like email formatting.
- **Interactive Feedback**: A `SnackBar` is used for lightweight error messages (e.g., terms not accepted), while an `AlertDialog` provides modal feedback for significant events like successful registration.

## Steps
1. Create a `StatefulWidget` and define a `GlobalKey<FormState>`.
2. Initialize `TextEditingController` for Name, Email, and Password, and properly dispose of them in the `dispose` method.
3. Build the UI with a `Form` containing `TextFormField`s, a `DropdownButtonFormField`, and a `CheckboxListTile`.
4. Apply specific validation logic (e.g., RegEx for email, length check for password).
5. On the submit button press, call `_formKey.currentState!.validate()`.
6. Add custom validation to check if terms are accepted; if not, show a `SnackBar`.
7. If all validations pass, extract data from the controllers and show an `AlertDialog`.
