import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../mnp_analytics.dart';
import '../widgets/mnp_animated_section.dart';
import '../widgets/mnp_page_scaffold.dart';

class MNPHomePage extends StatelessWidget {
  const MNPHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.home,
      body: Column(
        children: [
          _HeroSection(),
          _StatsSection(),
          MNPAnimatedSection(child: _PortfolioSection()),
          MNPAnimatedSection(child: _PhilosophySection()),
          MNPAnimatedSection(child: _ServicesSection()),
          MNPAnimatedSection(child: _DeveloperSection()),
          MNPAnimatedSection(child: _CTASection()),
        ],
      ),
    );
  }
}

// ─── Hero ─────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final hPad = MNPDimensions.horizontalPadding(context);
    final isMobile = MNPDimensions.isMobile(context);

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xCC0A0A0A), Color(0x660A0A0A)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PREMIUM REAL ESTATE',
                  style: MNPTextStyles.labelLarge(context),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Elevating Real Estate\n',
                        style: MNPTextStyles.displayLarge(context),
                      ),
                      TextSpan(
                        text: 'Advisory',
                        style: MNPTextStyles.italic(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: isMobile ? double.infinity : 520,
                  child: Text(
                    'Curated luxury residential, commercial & industrial assets across Delhi NCR\'s most coveted addresses.',
                    style: GoogleFonts.lato(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.white.withOpacity(0.8),
                      height: 1.8,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _PrimaryButton(
                            label: 'Schedule Consultation',
                            onTap: () {
                              trackEvent('cta_click', label: 'schedule_consultation_hero');
                              Navigator.pushNamed(context, MNPRoutes.contact);
                            },
                          ),
                          const SizedBox(height: 14),
                          _OutlineButton(
                            label: 'Explore Portfolio',
                            onTap: () {
                              trackEvent('cta_click', label: 'explore_portfolio_hero');
                              Navigator.pushNamed(context, MNPRoutes.gallery);
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _PrimaryButton(
                            label: 'Schedule Consultation',
                            onTap: () {
                              trackEvent('cta_click', label: 'schedule_consultation_hero');
                              Navigator.pushNamed(context, MNPRoutes.contact);
                            },
                          ),
                          const SizedBox(width: 20),
                          _OutlineButton(
                            label: 'Explore Portfolio',
                            onTap: () {
                              trackEvent('cta_click', label: 'explore_portfolio_hero');
                              Navigator.pushNamed(context, MNPRoutes.gallery);
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'SCROLL',
                  style: GoogleFonts.lato(
                    fontSize: 9,
                    letterSpacing: 3,
                    color: MNPColors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 1,
                  height: 40,
                  color: MNPColors.gold.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats ────────────────────────────────────────────────────────────────────

class _Stat {
  final int value;
  final String prefix;
  final String suffix;
  final String label;
  const _Stat({
    required this.value,
    this.prefix = '',
    this.suffix = '',
    required this.label,
  });
}

class _StatsSection extends StatefulWidget {
  @override
  State<_StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<_StatsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curve;
  bool _triggered = false;

  static const _stats = [
    _Stat(value: 15, suffix: '+', label: 'Years of\nExperience'),
    _Stat(prefix: '₹', value: 2000, suffix: ' Cr+', label: 'In Transactions\nAdvised'),
    _Stat(value: 8, suffix: '+', label: 'Developer\nAssociations'),
    _Stat(value: 500, suffix: '+', label: 'Clients\nServed'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (!_triggered && info.visibleFraction > 0.2) {
      _triggered = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isMobile = MNPDimensions.isMobile(context);

    return VisibilityDetector(
      key: const ValueKey('stats_section'),
      onVisibilityChanged: _onVisibility,
      child: Container(
        color: MNPColors.sectionDark,
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 60),
        child: isMobile
            ? GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                children: _stats
                    .map((s) => _CounterTile(stat: s, animation: _curve))
                    .toList(),
              )
            : Row(
                children: _stats.asMap().entries.map((e) {
                  final isLast = e.key == _stats.length - 1;
                  return Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _CounterTile(
                              stat: e.value, animation: _curve),
                        ),
                        if (!isLast)
                          Container(
                            width: 1,
                            height: 60,
                            color: MNPColors.charcoalMid,
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}

class _CounterTile extends StatelessWidget {
  final _Stat stat;
  final Animation<double> animation;
  const _CounterTile({required this.stat, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final current = (stat.value * animation.value).round();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${stat.prefix}$current${stat.suffix}',
              style: GoogleFonts.cormorantGaramond(
                fontSize: MNPDimensions.isDesktop(context) ? 48 : 36,
                fontWeight: FontWeight.w300,
                color: MNPColors.gold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stat.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: MNPColors.warmGrey,
                letterSpacing: 1.5,
                height: 1.6,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Portfolio ────────────────────────────────────────────────────────────────

class _PortfolioSection extends StatelessWidget {
  final List<_PortfolioItem> _items = const [
    _PortfolioItem(
      'Luxury Residences',
      'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80',
    ),
    _PortfolioItem(
      'Grade-A Commercial',
      'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80',
    ),
    _PortfolioItem(
      'Signature Interiors',
      'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800&q=80',
    ),
    _PortfolioItem(
      'Gated Villas',
      'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=800&q=80',
    ),
    _PortfolioItem(
      'Industrial & Logistics',
      'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800&q=80',
    ),
    _PortfolioItem(
      'Modern Skylines',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);
    final isMobile = MNPDimensions.isMobile(context);
    final crossCount = isDesktop ? 3 : (isMobile ? 1 : 2);

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          _SectionLabel('OUR PORTFOLIO'),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Assets of ',
                  style: MNPTextStyles.displayMedium(context),
                ),
                TextSpan(
                  text: 'Distinction',
                  style: MNPTextStyles.italicMedium(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: _items.length,
            itemBuilder: (ctx, i) => _PortfolioCard(item: _items[i]),
          ),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatefulWidget {
  final _PortfolioItem item;
  const _PortfolioCard({required this.item});

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: _hovered ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: CachedNetworkImage(
                  imageUrl: widget.item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xCC000000)],
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 30, height: 1, color: MNPColors.gold),
                    const SizedBox(height: 10),
                    Text(
                      widget.item.title,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: MNPColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioItem {
  final String title;
  final String imageUrl;
  const _PortfolioItem(this.title, this.imageUrl);
}

// ─── Philosophy ───────────────────────────────────────────────────────────────

class _PhilosophySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: MNPColors.sectionDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _philosophyText(context)),
                const SizedBox(width: 80),
                Expanded(child: _philosophyImage(context)),
              ],
            )
          : Column(
              children: [
                _philosophyImage(context),
                const SizedBox(height: 48),
                _philosophyText(context),
              ],
            ),
    );
  }

  Widget _philosophyText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('OUR PHILOSOPHY', light: true),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Where Counsel Meets\n',
                style: MNPTextStyles.displaySmall(context)
                    .copyWith(color: MNPColors.white),
              ),
              TextSpan(
                text: 'Conviction',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: MNPDimensions.isDesktop(context) ? 38 : 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  color: MNPColors.gold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'At My Next Property, we operate at the intersection of market intelligence and client aspiration. We do not merely transact — we curate enduring partnerships.',
          style: MNPTextStyles.bodyLarge(context)
              .copyWith(color: MNPColors.warmGrey),
        ),
        const SizedBox(height: 20),
        Text(
          'With 15+ years of expertise across Delhi NCR\'s most coveted corridors, our counsel is shaped by proprietary research, developer relationships, and an unwavering commitment to your interests.',
          style: MNPTextStyles.bodyLarge(context)
              .copyWith(color: MNPColors.warmGrey),
        ),
        const SizedBox(height: 40),
        _OutlineButton(
          label: 'Discover Our Story',
          onTap: () {
            trackEvent('cta_click', label: 'discover_our_story');
            Navigator.pushNamed(context, MNPRoutes.about);
          },
          light: true,
        ),
      ],
    );
  }

  Widget _philosophyImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85,
      child: CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80',
        fit: BoxFit.cover,
      ),
    );
  }
}

// ─── Services ────────────────────────────────────────────────────────────────

class _ServicesSection extends StatelessWidget {
  final List<_ServiceItem> _services = const [
    _ServiceItem(
      Icons.home_work_outlined,
      'Luxury Residential Advisory',
      'Access to the finest residential assets, often ahead of the open market.',
    ),
    _ServiceItem(
      Icons.business_outlined,
      'Commercial Leasing & Sales',
      'Advisory of institutional calibre across Gurugram\'s premier business districts.',
    ),
    _ServiceItem(
      Icons.warehouse_outlined,
      'Industrial Asset Consulting',
      'Specialist knowledge covering NCR\'s key industrial corridors.',
    ),
    _ServiceItem(
      Icons.trending_up_outlined,
      'Investment & Portfolio Strategy',
      'Integrated portfolio advisory — combining asset selection rigour with wealth creation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);
    final isMobile = MNPDimensions.isMobile(context);

    return Container(
      color: MNPColors.ivoryDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          _SectionLabel('WHAT WE OFFER'),
          const SizedBox(height: 16),
          Text('Our Services', style: MNPTextStyles.displaySmall(context)),
          const SizedBox(height: 60),
          isDesktop || !isMobile
              ? Row(
                  children: _services
                      .map((s) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: _ServiceCard(service: s),
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: _services
                      .map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _ServiceCard(service: s),
                          ))
                      .toList(),
                ),
          const SizedBox(height: 48),
          _PrimaryButton(
            label: 'All Services',
            onTap: () {
              trackEvent('cta_click', label: 'all_services');
              Navigator.pushNamed(context, MNPRoutes.services);
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceItem service;
  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _hovered ? MNPColors.charcoal : MNPColors.white,
          border: Border.all(
            color: _hovered ? MNPColors.gold : MNPColors.lightGrey,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.service.icon,
              color: MNPColors.gold,
              size: 32,
            ),
            const SizedBox(height: 20),
            Container(width: 30, height: 1, color: MNPColors.gold),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _hovered ? MNPColors.white : MNPColors.charcoal,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.service.description,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: _hovered ? MNPColors.warmGrey : MNPColors.warmGrey,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String title;
  final String description;
  const _ServiceItem(this.icon, this.title, this.description);
}

// ─── Developer Associations ───────────────────────────────────────────────────

class _DeveloperSection extends StatelessWidget {
  final List<String> _developers = const [
    'DLF',
    'M3M India',
    'Sobha Realty',
    'Adani Realty',
    'Godrej Properties',
    'Emaar India',
    'Prestige Group',
    'Brigade Group',
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 60),
      child: Column(
        children: [
          _SectionLabel('DEVELOPER ASSOCIATIONS'),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 0,
            runSpacing: 0,
            children: _developers
                .map((d) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: MNPColors.lightGrey.withOpacity(0.5)),
                      ),
                      child: Text(
                        d,
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MNPColors.warmGrey,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ─── CTA ──────────────────────────────────────────────────────────────────────

class _CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);

    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.65)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SectionLabel('READY TO BEGIN', light: true),
                const SizedBox(height: 16),
                Text(
                  'Book a Private Consultation',
                  style: MNPTextStyles.displaySmall(context)
                      .copyWith(color: MNPColors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'All communications are handled with absolute discretion.',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: MNPColors.white.withOpacity(0.7),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _PrimaryButton(
                  label: 'Schedule Now',
                  onTap: () {
                    trackEvent('cta_click', label: 'schedule_now_cta_section');
                    Navigator.pushNamed(context, MNPRoutes.contact);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool light;
  const _SectionLabel(this.text, {this.light = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 40, height: 1, color: MNPColors.gold),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(width: 12),
        Container(width: 40, height: 1, color: MNPColors.gold),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        color: MNPColors.gold,
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool light;

  const _OutlineButton({
    required this.label,
    required this.onTap,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: MNPColors.white, width: 1),
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: MNPColors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
