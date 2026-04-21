import 'package:flutter/material.dart';
import 'package:grocery2/features/on_boarding/presentation/UI/first_board.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
   
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _appleScale;
  late Animation<double> _appleMove;
  late Animation<double> _plusScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _appleScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.4).chain(CurveTween(curve: Curves.easeOutQuart)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.4, end: 0.8).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.7)),
    );

    _appleMove = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -50.0).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -50.0, end: -35.0).chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.9)),
    );

    _plusScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
      Future.delayed(const Duration(milliseconds  : 500), () {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstBoard()));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -25,
                      child: Opacity(
                        opacity: (0.3 - (_controller.value * 0.3)).clamp(0.0, 1.0),
                        child: Image.asset(
                          'assets/images/Ellipse.png',
                          width: 75,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, _appleMove.value),
                      child: Transform.scale(
                        scale: _appleScale.value,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/images/apple.png', width: 125),
                            Positioned(
                              right: -10,
                              top: 20,
                              child: Transform.scale(
                                scale: _plusScale.value,
                                child: Opacity(
                                  opacity: _plusScale.value.clamp(0.0, 1.0),
                                  child: Image.asset(
                                    'assets/images/+.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}