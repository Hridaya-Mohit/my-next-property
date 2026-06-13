import 'package:flutter/material.dart';
import '../theme/mnp_theme.dart';
import 'mnp_navbar.dart';
import 'mnp_footer.dart';

class MNPPageScaffold extends StatefulWidget {
  final String activePage;
  final Widget body;

  const MNPPageScaffold({
    super.key,
    required this.activePage,
    required this.body,
  });

  @override
  State<MNPPageScaffold> createState() => _MNPPageScaffoldState();
}

class _MNPPageScaffoldState extends State<MNPPageScaffold> {
  final _scrollController = ScrollController();
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolled = _scrollController.offset > 80;
      if (isScrolled != _scrolled) {
        setState(() => _scrolled = isScrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      endDrawer: MNPDrawer(activePage: widget.activePage),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                widget.body,
                const MNPFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _ScrollAwareNavbar(
              activePage: widget.activePage,
              scrolled: _scrolled,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollAwareNavbar extends StatelessWidget {
  final String activePage;
  final bool scrolled;

  const _ScrollAwareNavbar({
    required this.activePage,
    required this.scrolled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: scrolled ? MNPColors.charcoal.withOpacity(0.97) : Colors.transparent,
        gradient: scrolled
            ? null
            : LinearGradient(
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
        child: MNPNavbar(activePage: activePage),
      ),
    );
  }
}
