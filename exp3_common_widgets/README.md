# Experiment 3: Common Widgets UI

## Aim
To explore and demonstrate the usage of various common Flutter UI widgets inside a scrollable layout, while managing widget state.

## Theory
Flutter provides a rich set of pre-built widgets. In this experiment, we use:
- **`SingleChildScrollView`**: A box in which a single widget can be scrolled. This is necessary because combining many widgets can exceed the screen height.
- **`Text`**: A run of text with a single style.
- **`Image.network`**: A widget that displays an image fetched from a URL.
- **`ElevatedButton`**: A Material Design elevated button.
- **`TextField`**: A Material Design text field for user input.
- **`Switch`**: A Material Design switch used to toggle the on/off state of a single setting. Requires a `StatefulWidget` to update its value.
- **`CheckboxListTile`**: A convenience widget that combines a checkbox with a `ListTile`. Requires a `StatefulWidget`.
- **`Card`**: A Material Design card that provides rounded corners and a drop shadow.
- **`ListTile`**: A single fixed-height row that typically contains some text as well as a leading or trailing icon. Often used inside Cards or ListViews.

## Steps
1. Create a `StatefulWidget` to hold the boolean state variables for the Switch and Checkbox.
2. Structure the UI with a `Scaffold` and use `SingleChildScrollView` for the body.
3. Inside a `Column`, define styled section headers using a custom `_buildSectionHeader` method.
4. Add the requested widgets: `Text`, `Image.network`, `ElevatedButton`, `TextField`, `Switch`, `CheckboxListTile`, and `Card` (with an inner `ListTile`).
5. Update state using `setState` when the Switch or Checkbox is interacted with.
