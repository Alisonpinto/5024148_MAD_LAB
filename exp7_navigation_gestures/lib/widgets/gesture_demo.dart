import 'package:flutter/material.dart';

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String _gestureAction = 'Perform a gesture';
  Offset _panPosition = const Offset(50, 50);
  final List<String> _items = List.generate(5, (index) => 'Swipe Item $index');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_gestureAction, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _gestureAction = 'Tapped!'),
                  onDoubleTap: () => setState(() => _gestureAction = 'Double Tapped!'),
                  onLongPress: () => setState(() => _gestureAction = 'Long Pressed!'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.amber,
                    child: const Text('Gesture Box'),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _gestureAction = 'InkWell Ripple Tapped!'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.lightGreen,
                    child: const Text('InkWell Box'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Swipe to Delete List:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Dismissible(
                    key: Key(item),
                    onDismissed: (direction) {
                      setState(() {
                        _items.removeAt(index);
                        _gestureAction = 'Dismissed $item';
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(title: Text(item)),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          left: _panPosition.dx,
          top: _panPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _panPosition += details.delta;
                _gestureAction = 'Dragging Pan Box';
              });
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text('Drag Me', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
