import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../widgets/mnp_animated_section.dart';
import '../widgets/mnp_page_scaffold.dart';

class MNPGalleryPage extends StatefulWidget {
  const MNPGalleryPage({super.key});

  @override
  State<MNPGalleryPage> createState() => _MNPGalleryPageState();
}

class _MNPGalleryPageState extends State<MNPGalleryPage> {
  String _activeFilter = 'All Assets';

  static const List<_GalleryItem> _items = [
    _GalleryItem(
      title: 'Signature Villa',
      category: 'Residential',
      imageUrl:
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Corporate Tower',
      category: 'Commercial',
      imageUrl:
          'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Premium Interior',
      category: 'Residential',
      imageUrl:
          'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Gated Enclave',
      category: 'Residential',
      imageUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Logistics Park',
      category: 'Industrial',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Office Campus',
      category: 'Commercial',
      imageUrl:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Luxury Penthouse',
      category: 'Residential',
      imageUrl:
          'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Retail Destination',
      category: 'Commercial',
      imageUrl:
          'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=600&q=80',
    ),
    _GalleryItem(
      title: 'Grade-A Warehouse',
      category: 'Industrial',
      imageAsset: 'assets/urban_edge/images/warehouse.jpg',
    ),
  ];

  List<_GalleryItem> get _filtered {
    if (_activeFilter == 'All Assets') return _items;
    return _items.where((i) => i.category == _activeFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.gallery,
      body: Column(
        children: [
          _GalleryHero(),
          MNPAnimatedSection(child: _buildGalleryContent(context)),
        ],
      ),
    );
  }

  Widget _buildGalleryContent(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);
    final isMobile = MNPDimensions.isMobile(context);
    final cols = isDesktop ? 3 : (isMobile ? 1 : 2);

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        children: [
          Text(
            'A VISUAL SURVEY OF DISTINGUISHED ASSETS',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Curated Imagery',
            style: MNPTextStyles.displaySmall(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Filters
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 0,
            children: ['All Assets', 'Residential', 'Commercial', 'Industrial']
                .map((f) => _FilterTab(
                      label: f,
                      isActive: _activeFilter == f,
                      onTap: () => setState(() => _activeFilter = f),
                    ))
                .toList(),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: _filtered.length,
            itemBuilder: (ctx, i) => _GalleryCard(item: _filtered[i]),
          ),
        ],
      ),
    );
  }
}

class _GalleryHero extends StatelessWidget {
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
                'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1600&q=80',
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
                  'OUR PORTFOLIO',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Gallery',
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

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? MNPColors.charcoal : Colors.transparent,
          border: Border.all(
            color: isActive ? MNPColors.charcoal : MNPColors.lightGrey,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: isActive ? MNPColors.white : MNPColors.warmGrey,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final _GalleryItem item;
  const _GalleryCard({required this.item});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _showFullscreen(context),
        child: ClipRRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: _hovered ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: widget.item.imageAsset != null
                    ? Image.asset(
                        widget.item.imageAsset!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: MNPColors.beige,
                          child: const Icon(Icons.image_outlined,
                              size: 48, color: MNPColors.warmGrey),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.item.imageUrl!,
                        fit: BoxFit.cover,
                      ),
              ),
              AnimatedOpacity(
                opacity: _hovered ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xDD000000)],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                bottom: _hovered ? 24 : 0,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _hovered ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.category.toUpperCase(),
                        style: GoogleFonts.lato(
                          fontSize: 9,
                          color: MNPColors.gold,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.title,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: MNPColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Always visible category tag
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  color: MNPColors.charcoal.withOpacity(0.7),
                  child: Text(
                    widget.item.category.toUpperCase(),
                    style: GoogleFonts.lato(
                      fontSize: 8,
                      color: MNPColors.gold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullscreen(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.pop(ctx),
        child: Stack(
          children: [
            Center(
              child: widget.item.imageAsset != null
                  ? Image.asset(
                      widget.item.imageAsset!,
                      fit: BoxFit.contain,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.item.imageUrl!,
                      fit: BoxFit.contain,
                    ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: MNPColors.charcoal,
                  child: const Icon(Icons.close,
                      color: MNPColors.white, size: 20),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.category.toUpperCase(),
                    style: GoogleFonts.lato(
                      fontSize: 9,
                      color: MNPColors.gold,
                      letterSpacing: 3,
                    ),
                  ),
                  Text(
                    widget.item.title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: MNPColors.white,
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
}

class _GalleryItem {
  final String title;
  final String category;
  final String? imageUrl;
  final String? imageAsset;

  const _GalleryItem({
    required this.title,
    required this.category,
    this.imageUrl,
    this.imageAsset,
  });
}
