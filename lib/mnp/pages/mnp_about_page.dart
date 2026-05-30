import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../widgets/mnp_page_scaffold.dart';

class MNPAboutPage extends StatelessWidget {
  const MNPAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.about,
      body: Column(
        children: [
          _AboutHero(),
          _StorySection(),
          _VMPSection(),
          _DifferentiatorsSection(),
          _TimelineSection(),
          _AboutCTA(),
        ],
      ),
    );
  }
}

// ─── Hero ─────────────────────────────────────────────────────────────────────

class _AboutHero extends StatelessWidget {
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
                'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.65)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OUR STORY',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'About My Next Property',
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

// ─── Story ────────────────────────────────────────────────────────────────────

class _StorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _storyImage()),
                const SizedBox(width: 80),
                Expanded(child: _storyText(context)),
              ],
            )
          : Column(
              children: [
                _storyImage(),
                const SizedBox(height: 48),
                _storyText(context),
              ],
            ),
    );
  }

  Widget _storyImage() {
    return AspectRatio(
      aspectRatio: 0.9,
      child: CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _storyText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FOUNDED 2009',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Where Intelligence\nMeets Integrity',
          style: MNPTextStyles.displaySmall(context),
        ),
        const SizedBox(height: 8),
        Container(width: 50, height: 2, color: MNPColors.gold),
        const SizedBox(height: 28),
        Text(
          'At My Next Property, we operate at the intersection of market intelligence and client aspiration. We do not simply sell properties — we counsel legacies.',
          style: MNPTextStyles.bodyLarge(context),
        ),
        const SizedBox(height: 16),
        Text(
          'Our firm operates with the discretion of a private bank and the market access of an established brokerage. Every mandate we accept is handled with the rigour, confidentiality, and personalised attention that high-value transactions demand.',
          style: MNPTextStyles.bodyLarge(context),
        ),
      ],
    );
  }
}

// ─── Vision / Mission / Philosophy ───────────────────────────────────────────

class _VMPItem {
  final String title;
  final String description;
  final IconData icon;
  const _VMPItem(this.title, this.description, this.icon);
}

class _VMPSection extends StatelessWidget {
  static const List<_VMPItem> _items = [
    _VMPItem(
      'Our Vision',
      'To become Delhi NCR\'s most trusted real estate advisory, serving high-net-worth clients and institutional investors with counsel that transcends transactional services.',
      Icons.visibility_outlined,
    ),
    _VMPItem(
      'Our Mission',
      'To deliver bespoke, research-driven advisory that consistently prioritises client interests through rigorous market research, developer relationships, and unwavering integrity.',
      Icons.flag_outlined,
    ),
    _VMPItem(
      'Our Philosophy',
      '"We do not simply sell properties. We counsel legacies." — operating with private bank discretion and established brokerage market access.',
      Icons.auto_awesome_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: MNPColors.sectionDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'Vision, Mission & Philosophy',
            style: MNPTextStyles.displaySmall(context)
                .copyWith(color: MNPColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _items
                      .map((item) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: _VMPCard(item: item),
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: _items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _VMPCard(item: item),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _VMPCard extends StatelessWidget {
  final _VMPItem item;
  const _VMPCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        border: Border.all(color: MNPColors.charcoalMid),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: MNPColors.gold, size: 28),
          const SizedBox(height: 20),
          Container(width: 30, height: 1, color: MNPColors.gold),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: MNPColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: MNPColors.warmGrey,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Differentiators ─────────────────────────────────────────────────────────

class _Differentiator {
  final String title;
  final String description;
  const _Differentiator(this.title, this.description);
}

class _DifferentiatorsSection extends StatelessWidget {
  static const List<_Differentiator> _items = [
    _Differentiator(
      'Uncompromising Confidentiality',
      'Every client mandate is handled with absolute discretion. Your privacy is our foundational commitment.',
    ),
    _Differentiator(
      'Intelligence-Led Decisions',
      'Our proprietary research informs every recommendation — market data, pricing trends, and micro-market insights.',
    ),
    _Differentiator(
      'Developer Access',
      'Pre-launch inventory, exclusive pricing, and off-market opportunities from India\'s premier developers.',
    ),
    _Differentiator(
      'End-to-End Partnership',
      'From mandate through post-acquisition support, we remain your trusted partner at every stage.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);
    final isMobile = MNPDimensions.isMobile(context);
    final cols = isDesktop ? 2 : 1;

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'OUR DIFFERENTIATORS',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'What Sets Us Apart',
            style: MNPTextStyles.displaySmall(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 2.5 : 3,
            ),
            itemCount: _items.length,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                border: Border.all(color: MNPColors.lightGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '0${i + 1}',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: MNPColors.gold.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _items[i].title,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: MNPColors.charcoal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _items[i].description,
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.warmGrey,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Timeline ────────────────────────────────────────────────────────────────

class _TimelineEvent {
  final String year;
  final String description;
  const _TimelineEvent(this.year, this.description);
}

class _TimelineSection extends StatelessWidget {
  static const List<_TimelineEvent> _events = [
    _TimelineEvent('2009', 'Foundation established — pioneering luxury advisory in Gurugram'),
    _TimelineEvent('2013', 'Commercial practice launched, entering Grade-A office and retail segments'),
    _TimelineEvent('2017', 'NRI Advisory Desk created, bridging global capital with NCR real estate'),
    _TimelineEvent('2020', 'Industrial & Logistics Advisory entered amid supply-chain restructuring'),
    _TimelineEvent('2024', 'Portfolio Structuring Practice formalised for HNI/UHNI wealth integration'),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);

    return Container(
      color: MNPColors.ivoryDark,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'OUR JOURNEY',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Milestones',
            style: MNPTextStyles.displaySmall(context),
          ),
          const SizedBox(height: 60),
          ...List.generate(
            _events.length,
            (i) => _TimelineItem(
              event: _events[i],
              isLast: i == _events.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final _TimelineEvent event;
  final bool isLast;

  const _TimelineItem({required this.event, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              event.year,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: MNPColors.gold,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: MNPColors.gold, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1, color: MNPColors.lightGrey),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
              child: Text(
                event.description,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: MNPColors.warmGrey,
                  height: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CTA ──────────────────────────────────────────────────────────────────────

class _AboutCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return Container(
      color: MNPColors.charcoal,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'Begin a Confidential Conversation',
            style: MNPTextStyles.displaySmall(context)
                .copyWith(color: MNPColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Our leadership team personally oversees every client relationship.',
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              color: MNPColors.gold,
              child: Text(
                'SCHEDULE A CONSULTATION',
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
