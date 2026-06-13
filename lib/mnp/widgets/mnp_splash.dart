import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';

class MNPSplash extends StatefulWidget {
  final Widget child;
  const MNPSplash({super.key, required this.child});

  @override
  State<MNPSplash> createState() => _MNPSplashState();
}

class _MNPSplashState extends State<MNPSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Gold line expands from 0 to 60px
  late final Animation<double> _lineWidth;
  // Logo fades in after line appears
  late final Animation<double> _logoOpacity;
  // Entire overlay fades out at the end
  late final Animation<double> _overlayOpacity;

  @override
  void initState() {
    super.initState();

    // Total duration: 3 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // 0.0 – 0.2 (0–600ms): gold line expands
    _lineWidth = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    // 0.2 – 0.4 (600ms–1200ms): logo fades in
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );

    // 0.75 – 1.0 (2250ms–3000ms): overlay fades out
    _overlayOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (_overlayOpacity.value == 0) return const SizedBox.shrink();
            return Opacity(
              opacity: _overlayOpacity.value,
              child: Container(
                color: MNPColors.charcoal,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gold line
                    Container(
                      width: _lineWidth.value,
                      height: 1,
                      color: MNPColors.gold,
                    ),
                    const SizedBox(height: 20),
                    // Logo
                    Opacity(
                      opacity: _logoOpacity.value,
                      child: Column(
                        children: [
                          Text(
                            'MY NEXT',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: MNPColors.white,
                              letterSpacing: 8,
                            ),
                          ),
                          Text(
                            'PROPERTY',
                            style: GoogleFonts.lato(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: MNPColors.gold,
                              letterSpacing: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
