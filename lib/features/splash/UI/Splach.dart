import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import 'package:grocery2/features/on_boarding/presentation/UI/first_board.dart';
import 'package:grocery2/features/home/presentation/ui/home_view.dart';
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _appleScale;
  late Animation<double> _appleMove;
  late Animation<double> _shadowOpacity;
  late Animation<double> _plusScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    _appleMove = Tween<double>(begin: 60, end: -40).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _appleScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.3, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.7)),
    );

    _shadowOpacity = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _plusScale = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FirstBoard()),
        );
        // Check if the user is logged in
        // Assuming PreferenceManager has a method like 'isLoggedIn' or 'getAuthToken'
        // For this example, we'll use a placeholder 'isLoggedIn' boolean.
        // You might need to adjust this based on how your PreferenceManager stores login status.
        final bool isLoggedIn = PreferenceManager().getBool('isLoggedIn') ?? false;

        if (isLoggedIn) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstBoard()));
        }
      }
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
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -20,
                  child: Opacity(
                    opacity: _shadowOpacity.value,
                    child: Transform.scale(
                      scale: 1 + (_controller.value * 0.2),
                      child: Image.asset(
                        'assets/images/Ellipse.png',
                        width: 90,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, _appleMove.value),
                  child: Transform.scale(
                    scale: _appleScale.value,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          'assets/images/apple.png',
                          width: 130,
                        ),
                        Positioned(
                          right: -12,
                          top: 18,
                          child: Transform.scale(
                            scale: _plusScale.value,
                            child: Opacity(
                              opacity: _plusScale.value.clamp(0.0, 1.0),
                              child: Image.asset(
                                'assets/images/+.png',
                                width: 32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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