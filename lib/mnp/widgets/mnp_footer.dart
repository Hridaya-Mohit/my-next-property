import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';

class _NavLink {
  final String label;
  final String route;
  const _NavLink(this.label, this.route);
}

const List<_NavLink> _navLinks = [
  _NavLink('Home', MNPRoutes.home),
  _NavLink('About', MNPRoutes.about),
  _NavLink('Leadership', MNPRoutes.leadership),
  _NavLink('Services', MNPRoutes.services),
  _NavLink('Gallery', MNPRoutes.gallery),
  _NavLink('Contact', MNPRoutes.contact),
];

class MNPFooter extends StatelessWidget {
  const MNPFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: const Color(0xFF0A0A0A),
      child: Column(
        children: [
          Container(height: 1, color: MNPColors.charcoalMid),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 60),
            child: isDesktop ? _buildDesktopFooter(context) : _buildMobileFooter(context),
          ),
          Container(height: 1, color: MNPColors.charcoalMid),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 My Next Property. All rights reserved.',
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    color: MNPColors.warmGrey,
                    letterSpacing: 0.5,
                  ),
                ),
                if (!MNPDimensions.isMobile(context))
                  Row(
                    children: [
                      _footerLink('Privacy Policy'),
                      const SizedBox(width: 24),
                      _footerLink('Disclaimer'),
                      const SizedBox(width: 24),
                      _footerLink('RERA'),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildBrandColumn(context)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildLinksColumn(context)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildContactColumn()),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(context),
        const SizedBox(height: 40),
        _buildLinksColumn(context),
        const SizedBox(height: 40),
        _buildContactColumn(),
      ],
    );
  }

  Widget _buildBrandColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MY NEXT',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
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
        const SizedBox(height: 24),
        Text(
          'We do not simply sell properties.\nWe counsel legacies.',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: MNPColors.warmGrey,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _socialIcon(Icons.link),
            const SizedBox(width: 16),
            _socialIcon(Icons.camera_alt_outlined),
            const SizedBox(width: 16),
            _socialIcon(Icons.alternate_email),
          ],
        ),
      ],
    );
  }

  Widget _buildLinksColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NAVIGATION',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 20),
        ..._navLinks.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, link.route),
              child: Text(
                link.label,
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: MNPColors.warmGrey,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 20),
        _contactItem(
          Icons.location_on_outlined,
          'Shop No. 37, Opposite Vita Dairy\nSector 46, Gurgaon-122003\nHaryana',
        ),
        const SizedBox(height: 16),
        _contactItem(Icons.phone_outlined, '+91 98188 12223'),
        const SizedBox(height: 16),
        _contactItem(Icons.email_outlined, 'info@mynextproperty.in'),
        const SizedBox(height: 6),
        _contactItem(Icons.email_outlined, 'luxury@mynextproperty.in'),
      ],
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: MNPColors.gold, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: MNPColors.warmGrey,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: MNPColors.charcoalMid),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: MNPColors.warmGrey, size: 16),
    );
  }

  Widget _footerLink(String label) {
    return Text(
      label,
      style: GoogleFonts.lato(
        fontSize: 11,
        color: MNPColors.warmGrey,
        letterSpacing: 0.5,
      ),
    );
  }
}
