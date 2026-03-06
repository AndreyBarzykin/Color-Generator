import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// This is the home page of the app, where users can tap
/// to generate random colors or play a color animation.
class HomePage extends StatefulWidget {
  /// Creates a [HomePage] widget.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int alpha = 255;
  static const int _maxColorVal = 256;

  final random = Random();

  bool isColorPlay = false;
  Timer? _timer;
  Color bgColor = const Color.fromARGB(alpha, 255, 255, 255);

  void _generateColor() {
    if (!mounted) return;

    setState(() {
      bgColor = Color.fromARGB(
        alpha,
        random.nextInt(_maxColorVal),
        random.nextInt(_maxColorVal),
        random.nextInt(_maxColorVal),
      );
    });
  }

  void _playColor() {
    if (isColorPlay) return;

    setState(() => isColorPlay = true);
    _timer = Timer.periodic(const Duration(milliseconds: 750), (_) {
      _generateColor();
    });
  }

  void _stopColor() {
    setState(() => isColorPlay = false);
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(bgColor);
    final iconColor = brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        key: const Key('bg_gesture'),
        onTap: _generateColor,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(color: bgColor),
          child: Center(
            child: Text(
              'Hi there!',
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: isColorPlay ? _stopColor : _playColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    isColorPlay
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 50,
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    isColorPlay = false;
    _timer?.cancel();
    super.dispose();
  }
}
