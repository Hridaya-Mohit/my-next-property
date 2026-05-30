import 'package:flutter/material.dart';
import 'mnp_navbar.dart';
import 'mnp_footer.dart';

/// Wraps a page with the transparent overlay navbar (positioned over a dark hero)
/// and footer at bottom. The [body] should include its own hero section first.
class MNPPageScaffold extends StatelessWidget {
  final String activePage;
  final Widget body;

  const MNPPageScaffold({
    super.key,
    required this.activePage,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      endDrawer: const MNPDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                body,
                const MNPFooter(),
              ],
            ),
          ),
          // Fixed transparent navbar overlaid on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _ScrollAwareNavbar(activePage: activePage),
          ),
        ],
      ),
    );
  }
}

class _ScrollAwareNavbar extends StatefulWidget {
  final String activePage;
  const _ScrollAwareNavbar({required this.activePage});

  @override
  State<_ScrollAwareNavbar> createState() => _ScrollAwareNavbarState();
}

class _ScrollAwareNavbarState extends State<_ScrollAwareNavbar> {
  // Navbar is always shown as transparent overlay; solid bg handled in MNPNavbar
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: MNPNavbar(activePage: widget.activePage),
      ),
    );
  }
}
