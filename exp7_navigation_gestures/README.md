# Experiment 7: Navigation, Routing & Gestures

## Aim
To implement application routing using named routes, pass data between screens, and utilize gestures to create interactive UIs.

## Theory
- **Navigator 1.0 (Named Routes)**: Flutter manages screens as a stack. `Navigator.pushNamed()` pushes a new screen, and `Navigator.pop()` removes the top screen. Use `onGenerateRoute` in `MaterialApp` to parse arguments passed to a named route.
- **Push vs PushReplacement**: Use `push` to add a new screen and allow returning back. Use `pushReplacement` to swap the current screen (e.g., after login).
- **Gestures**: `GestureDetector` recognizes gestures like taps, long presses, and drags (`onPanUpdate`). `InkWell` is similar but adds a Material ripple effect. `Dismissible` is a specialized widget for swipe-to-delete interactions.
- **App Layouts**: `BottomNavigationBar` creates tabs at the bottom, and `Drawer` adds a side menu.

## Steps
1. Define named routes (`/`, `/settings`) and handle `/detail` dynamically in `onGenerateRoute` in `lib/main.dart`.
2. Build `HomeScreen` with a `Drawer` (linking to Settings) and a `BottomNavigationBar` to toggle between Home and Gestures tabs.
3. In the Home tab, use a button to `pushNamed` to `/detail`, passing string data as arguments.
4. In `DetailScreen`, read the data via constructor and display it, with a button to `pop` back.
5. In `GestureDemo`, use `GestureDetector` to detect single, double, and long presses, and update a text label.
6. Use `onPanUpdate` to make a draggable circle around the screen.
7. Wrap items in a `ListView` with a `Dismissible` widget to implement swipe-to-delete.
