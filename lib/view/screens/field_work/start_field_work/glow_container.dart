// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';


class GlowingButton extends StatefulWidget {
  const GlowingButton({super.key});

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
    Timer? _pauseTimer;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 2, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    startLoop();
  }

 
  void startLoop() {
    _controller.repeat(reverse: true);
    Timer(const Duration(seconds: 3), () {
      _controller.stop();
      _pauseTimer?.cancel();
      _pauseTimer = Timer(const Duration(seconds: 10), () {
        startLoop(); // restart after 10s pause
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pauseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: _animation.value,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                  backgroundColor: Colors.white,
                ),
                child: const Icon(Icons.favorite, color: Colors.red, size: 32),
              ),
            );
          },
        ),
      ),
    );
  }
}
