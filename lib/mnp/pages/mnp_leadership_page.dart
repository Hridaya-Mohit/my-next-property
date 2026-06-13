import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../widgets/mnp_animated_section.dart';
import '../widgets/mnp_page_scaffold.dart';

class MNPLeadershipPage extends StatelessWidget {
  const MNPLeadershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.leadership,
      body: Column(
        children: [
          _LeadershipHero(),
          MNPAnimatedSection(child: _LeadershipIntro()),
          MNPAnimatedSection(child: _TeamSection()),
          MNPAnimatedSection(child: _ConsultationCTA()),
        ],
      ),
    );
  }
}

class _LeadershipHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return SizedBox(
      height: 480,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1497366216548-37526070297c?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE TEAM',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Our Leadership',
                  style: MNPTextStyles.displaySmall(context)
                      .copyWith(color: MNPColors.white),
                ),
                const SizedBox(height: 16),
                Container(width: 60, height: 2, color: MNPColors.gold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadershipIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'COUNSEL SHAPED BY EXPERIENCE',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 700,
            child: Text(
              'Our leadership team brings decades of combined experience across luxury residential, commercial, and industrial real estate. Every client relationship is personally overseen by our principals.',
              style: MNPTextStyles.bodyLarge(context),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: MNPColors.ivoryDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _LeaderCard(member: _khalid)),
                const SizedBox(width: 40),
                Expanded(child: _LeaderCard(member: _tolani)),
              ],
            )
          : Column(
              children: [
                _LeaderCard(member: _khalid),
                const SizedBox(height: 40),
                _LeaderCard(member: _tolani),
              ],
            ),
    );
  }

  static const _khalid = _TeamMember(
    name: 'Mohd. Khalid',
    title: 'Founder & Director',
    imageAsset: 'assets/urban_edge/images/mohd_khalid.png',
    experience: '17+ Years',
    sector: 'Automobiles & Real Estate',
    stat1Label: 'Transactions Advised',
    stat1Value: '₹2000 Cr+',
    stat2Label: 'Recent Advisory',
    stat2Value: '₹150 Cr+',
    bio:
        'A leader with 17 years of distinguished experience across the automobiles and real estate sectors, Mohd. Khalid has facilitated ₹150+ crore in strategic investments and identified early-stage investment corridors across the Gurugram–Delhi NCR belt. His institutional relationships with top developers give clients privileged access to pre-launch inventory and exclusive pricing.',
  );

  static const _tolani = _TeamMember(
    name: 'Ramesh Tolani',
    title: 'Director',
    imageAsset: 'assets/urban_edge/images/ramesh_tolani.png',
    experience: '15+ Years',
    sector: 'NCR Real Estate',
    stat1Label: 'Transactions Facilitated',
    stat1Value: '₹1500 Cr+',
    stat2Label: 'Years of Experience',
    stat2Value: '15+',
    bio:
        'Ramesh Tolani brings strategic clarity and operational excellence to premium residential and investment portfolio management. Known for meticulous deal execution, he has guided HNIs, families, institutional investors, and NRI buyers through complex transactions with absolute discretion and precision.',
  );
}

class _LeaderCard extends StatelessWidget {
  final _TeamMember member;
  const _LeaderCard({required this.member});

  @override
  Widget build(BuildContext context) {
    final isMobile = MNPDimensions.isMobile(context);

    return Container(
      color: MNPColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo
          AspectRatio(
            aspectRatio: 0.9,
            child: Image.asset(
              member.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: MNPColors.beige,
                child: Center(
                  child: Icon(Icons.person_outline,
                      size: 80, color: MNPColors.warmGrey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 40, height: 2, color: MNPColors.gold),
                const SizedBox(height: 16),
                Text(
                  member.name,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: MNPColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member.title,
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                // Stats
                isMobile
                    ? Column(
                        children: [
                          _StatItem(
                              label: member.stat1Label,
                              value: member.stat1Value),
                          const SizedBox(height: 16),
                          _StatItem(
                              label: member.stat2Label,
                              value: member.stat2Value),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _StatItem(
                                label: member.stat1Label,
                                value: member.stat1Value),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatItem(
                                label: member.stat2Label,
                                value: member.stat2Value),
                          ),
                        ],
                      ),
                const SizedBox(height: 24),
                Container(height: 1, color: MNPColors.lightGrey),
                const SizedBox(height: 24),
                Text(
                  member.bio,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: MNPColors.warmGrey,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      member.experience,
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        color: MNPColors.warmGrey,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                        width: 4, height: 4, color: MNPColors.gold),
                    const SizedBox(width: 8),
                    Text(
                      member.sector,
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        color: MNPColors.warmGrey,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MNPColors.ivoryDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: MNPColors.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: MNPColors.warmGrey,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMember {
  final String name;
  final String title;
  final String imageAsset;
  final String experience;
  final String sector;
  final String stat1Label;
  final String stat1Value;
  final String stat2Label;
  final String stat2Value;
  final String bio;

  const _TeamMember({
    required this.name,
    required this.title,
    required this.imageAsset,
    required this.experience,
    required this.sector,
    required this.stat1Label,
    required this.stat1Value,
    required this.stat2Label,
    required this.stat2Value,
    required this.bio,
  });
}

class _ConsultationCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return Container(
      color: MNPColors.sectionDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'PRIVATE CONSULTATION',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Speak Directly With Our Leadership',
            style: MNPTextStyles.displaySmall(context)
                .copyWith(color: MNPColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Every client conversation is handled with absolute discretion.',
            style: GoogleFonts.lato(
              fontSize: 14,
              color: MNPColors.warmGrey,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MNPRoutes.contact),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              color: MNPColors.gold,
              child: Text(
                'BEGIN A CONVERSATION',
                style: GoogleFonts.lato(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: MNPColors.white,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
