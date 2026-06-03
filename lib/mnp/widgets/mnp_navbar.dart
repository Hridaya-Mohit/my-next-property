import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';

class MNPNavbar extends StatefulWidget {
  final String activePage;
  const MNPNavbar({super.key, required this.activePage});

  @override
  State<MNPNavbar> createState() => _MNPNavbarState();
}

class _MNPNavbarState extends State<MNPNavbar> {
  bool _scrolled = false;

  final List<_NavItem> _navItems = [
    _NavItem('HOME', MNPRoutes.home),
    _NavItem('ABOUT', MNPRoutes.about),
    _NavItem('LEADERSHIP', MNPRoutes.leadership),
    _NavItem('SERVICES', MNPRoutes.services),
    _NavItem('GALLERY', MNPRoutes.gallery),
    _NavItem('CONTACT', MNPRoutes.contact),
  ];

  void _navigate(String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MNPDimensions.isDesktop(context);
    final hPad = MNPDimensions.horizontalPadding(context);

    return Container(
      color: _scrolled ? MNPColors.charcoal.withOpacity(0.97) : Colors.transparent,
      child: isDesktop ? _buildDesktopNav(hPad) : _buildMobileNav(hPad),
    );
  }

  Widget _buildDesktopNav(double hPad) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          ..._navItems.map((item) => _buildNavItem(item)),
          const SizedBox(width: 24),
          _buildWhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildMobileNav(double hPad) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: const Icon(Icons.menu, color: MNPColors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => _navigate(MNPRoutes.home),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY NEXT',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MNPColors.white,
              letterSpacing: 4,
            ),
          ),
          Text(
            'PROPERTY',
            style: GoogleFonts.lato(
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: MNPColors.gold,
              letterSpacing: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(_NavItem item) {
    final isActive = widget.activePage == item.route;
    return GestureDetector(
      onTap: () => _navigate(item.route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.label,
              style: GoogleFonts.lato(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: isActive ? MNPColors.gold : MNPColors.white,
                letterSpacing: 2.5,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(
                height: 1,
                width: 20,
                color: MNPColors.gold,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsAppButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: MNPColors.gold, width: 1),
        ),
        child: Text(
          '+91 98188 12223',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: MNPColors.gold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class MNPDrawer extends StatelessWidget {
  const MNPDrawer({super.key});

  final List<_NavItem> _navItems = const [
    _NavItem('HOME', MNPRoutes.home),
    _NavItem('ABOUT', MNPRoutes.about),
    _NavItem('LEADERSHIP', MNPRoutes.leadership),
    _NavItem('SERVICES', MNPRoutes.services),
    _NavItem('GALLERY', MNPRoutes.gallery),
    _NavItem('CONTACT', MNPRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MNPColors.charcoal,
      width: 280,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MY NEXT',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MNPColors.white,
                          letterSpacing: 4,
                        ),
                      ),
                      Text(
                        'PROPERTY',
                        style: GoogleFonts.lato(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: MNPColors.gold,
                          letterSpacing: 6,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: MNPColors.white, size: 22),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: MNPColors.charcoalMid),
            const SizedBox(height: 16),
            ..._navItems.map((item) => _buildDrawerItem(context, item)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 1, color: MNPColors.charcoalMid),
                  const SizedBox(height: 20),
                  Text(
                    '+91 98188 12223',
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.gold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'info@mynextproperty.in',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.warmGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, _NavItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, item.route);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          item.label,
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: MNPColors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String route;
  const _NavItem(this.label, this.route);
}
