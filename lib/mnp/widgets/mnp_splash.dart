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

  late final Animation<double> _lineWidth;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _overlayOpacity;

  bool _done = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // Gold line draws left to right
    _lineWidth = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.22, curve: Curves.easeOut),
      ),
    );

    // Logo fades in
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.18, 0.38, curve: Curves.easeOut),
      ),
    );

    // Logo slides up — fractional offset relative to its own height
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.18, 0.38, curve: Curves.easeOut),
      ),
    );

    // Tagline fades in after logo
    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.36, 0.54, curve: Curves.easeIn),
      ),
    );

    // Overlay fades out at the end
    _overlayOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.74, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Remove overlay entirely once animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _done = true);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: widget.child,
      );
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          RepaintBoundary(
            child: FadeTransition(
              opacity: _overlayOpacity,
              child: Container(
                color: MNPColors.charcoal,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gold line — isolated AnimatedBuilder, only redraws the line
                    AnimatedBuilder(
                      animation: _lineWidth,
                      builder: (context, _) => SizedBox(
                        width: 60,
                        height: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: _lineWidth.value,
                            height: 1,
                            color: MNPColors.gold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Logo — GPU-accelerated fade + slide
                    FadeTransition(
                      opacity: _logoOpacity,
                      child: SlideTransition(
                        position: _logoSlide,
                        child: Column(
                          children: [
                            Text(
                              'MY NEXT',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                color: MNPColors.white,
                                letterSpacing: 10,
                              ),
                            ),
                            Text(
                              'PROPERTY',
                              style: GoogleFonts.lato(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: MNPColors.gold,
                                letterSpacing: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Tagline — GPU-accelerated fade
                    FadeTransition(
                      opacity: _taglineOpacity,
                      child: Text(
                        'We do not simply sell properties. We counsel legacies.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: MNPColors.warmGrey,
                          letterSpacing: 0.5,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
