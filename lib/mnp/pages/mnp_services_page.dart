import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../widgets/mnp_page_scaffold.dart';

class MNPServicesPage extends StatelessWidget {
  const MNPServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.services,
      body: Column(
        children: [
          _ServicesHero(),
          ..._serviceData.asMap().entries.map(
                (e) => _ServiceDetailSection(
                  service: e.value,
                  reversed: e.key % 2 == 1,
                ),
              ),
          _ServicesCTA(),
        ],
      ),
    );
  }

  static final List<_ServiceData> _serviceData = [
    _ServiceData(
      label: '01',
      title: 'Luxury Residential\nConsulting',
      tagline:
          'Access to the finest residential assets, often ahead of the open market.',
      imageUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80',
      features: [
        'Pre-launch and off-market inventory from DLF, M3M, Sobha, Emaar',
        'Custom property matching based on lifestyle and investment criteria',
        'Due diligence and comprehensive title verification',
        'Post-purchase interior and property management support',
        'Negotiation expertise to secure optimal pricing',
      ],
      areas: [
        'DLF Phase IV & Golf Course Road',
        'Sohna Road Luxury Corridor',
        'South Delhi Premium Addresses',
        'Noida Expressway Residences',
      ],
    ),
    _ServiceData(
      label: '02',
      title: 'Commercial\nAdvisory',
      tagline:
          'Advisory of institutional calibre across Gurugram\'s premier business districts.',
      imageUrl:
          'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80',
      features: [
        'Corporate tenant representation and workplace strategy',
        'Landlord asset positioning and leasing guidance',
        'Investment-grade office and retail acquisition support',
        'Lease restructuring and exit strategy consulting',
        'Market intelligence for informed decision-making',
      ],
      areas: [
        'Cyber City & DLF Cyber Park',
        'Sector 32–44 Business Districts',
        'Udyog Vihar Industrial Area',
        'Aerocity & IGI Corridor',
      ],
    ),
    _ServiceData(
      label: '03',
      title: 'Industrial & Logistics\nAdvisory',
      tagline:
          'Specialist knowledge covering NCR\'s key industrial corridors for long-term value creation.',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800&q=80',
      features: [
        'Site selection for warehousing and manufacturing needs',
        'Sale-leaseback transaction structuring',
        'Institutional investor guidance and facilitation',
        'Regulatory compliance and feasibility assessment',
        'Long-term lease negotiation and management',
      ],
      areas: [
        'NH-48 Industrial Corridor',
        'KMP Expressway Logistics Parks',
        'Manesar Manufacturing Hub',
        'Greater Noida Industrial Zone',
      ],
    ),
    _ServiceData(
      label: '04',
      title: 'Investment &\nPortfolio Strategy',
      tagline:
          'Integrated portfolio advisory — combining asset selection rigour with wealth creation.',
      imageUrl:
          'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800&q=80',
      features: [
        'HNI/UHNI portfolio structuring and diversification',
        'NRI investment guidance with full FEMA/regulatory support',
        'Asset performance reviews and yield optimization',
        'Holistic planning with legal and tax professionals',
        'Pre-launch investment access and priority allocation',
      ],
      areas: [
        'Residential Investment Grade Assets',
        'Commercial Yield-Generating Properties',
        'Industrial Asset Portfolios',
        'NRI Repatriation-Compliant Structures',
      ],
    ),
  ];
}

class _ServicesHero extends StatelessWidget {
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
                'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.68)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WHAT WE OFFER',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Our Services',
                  style: MNPTextStyles.displaySmall(context)
                      .copyWith(color: MNPColors.white),
                ),
                const SizedBox(height: 16),
                Container(width: 60, height: 2, color: MNPColors.gold),
                const SizedBox(height: 24),
                SizedBox(
                  width: 520,
                  child: Text(
                    'Bespoke real estate advisory across residential, commercial, industrial, and investment domains.',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.white.withOpacity(0.8),
                      height: 1.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceDetailSection extends StatelessWidget {
  final _ServiceData service;
  final bool reversed;

  const _ServiceDetailSection({
    required this.service,
    required this.reversed,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);
    final bg = reversed ? MNPColors.ivoryDark : MNPColors.ivory;

    final imageWidget = AspectRatio(
      aspectRatio: 1,
      child: CachedNetworkImage(
        imageUrl: service.imageUrl,
        fit: BoxFit.cover,
      ),
    );

    final textWidget = Padding(
      padding: isDesktop
          ? const EdgeInsets.symmetric(horizontal: 48, vertical: 0)
          : const EdgeInsets.only(top: 40),
      child: _ServiceText(service: service),
    );

    return Container(
      color: bg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: reversed
                  ? [
                      Expanded(child: textWidget),
                      const SizedBox(width: 16),
                      Expanded(child: imageWidget),
                    ]
                  : [
                      Expanded(child: imageWidget),
                      Expanded(child: textWidget),
                    ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [imageWidget, textWidget],
            ),
    );
  }
}

class _ServiceText extends StatelessWidget {
  final _ServiceData service;
  const _ServiceText({required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.label,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: MNPColors.gold.withOpacity(0.3),
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          service.title,
          style: MNPTextStyles.displaySmall(context),
        ),
        const SizedBox(height: 8),
        Container(width: 50, height: 2, color: MNPColors.gold),
        const SizedBox(height: 20),
        Text(
          service.tagline,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 17,
            fontStyle: FontStyle.italic,
            color: MNPColors.warmGrey,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'KEY SERVICES',
          style: GoogleFonts.lato(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        ...service.features.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: MNPColors.gold,
                      )),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    f,
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.warmGrey,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'FOCUS AREAS',
          style: GoogleFonts.lato(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: service.areas
              .map((a) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: MNPColors.lightGrey),
                    ),
                    child: Text(
                      a,
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: MNPColors.warmGrey,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _ServiceData {
  final String label;
  final String title;
  final String tagline;
  final String imageUrl;
  final List<String> features;
  final List<String> areas;

  const _ServiceData({
    required this.label,
    required this.title,
    required this.tagline,
    required this.imageUrl,
    required this.features,
    required this.areas,
  });
}

class _ServicesCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.65)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discuss Your Requirements',
                  style: MNPTextStyles.displaySmall(context)
                      .copyWith(color: MNPColors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Our advisors are available for a private, no-obligation consultation.',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: MNPColors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, MNPRoutes.contact),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    color: MNPColors.gold,
                    child: Text(
                      'BOOK CONSULTATION',
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
          ),
        ],
      ),
    );
  }
}
