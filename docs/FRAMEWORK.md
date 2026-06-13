# My Next Property — Core Framework

## Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter (Web target) |
| Language | Dart |
| Hosting | GitHub Pages |
| Domain | mynextproperty.in |
| CI/CD | GitHub Actions |

## Project Structure

```
lib/
  main.dart                        # Entry point
  mnp/
    mnp_app.dart                   # MaterialApp, route definitions (MNPRoutes)
    theme/
      mnp_theme.dart               # Colors, text styles, dimensions
    pages/
      mnp_home_page.dart
      mnp_about_page.dart
      mnp_leadership_page.dart
      mnp_services_page.dart
      mnp_gallery_page.dart
      mnp_contact_page.dart
    widgets/
      mnp_page_scaffold.dart       # Shared page wrapper (navbar + footer + body)
      mnp_navbar.dart              # Top navbar + mobile drawer
      mnp_footer.dart              # Site-wide footer
docs/
  TODO.md
  FRAMEWORK.md
```

## Routing

Defined in `MNPRoutes` (`mnp_app.dart`):

| Constant | Path | Page |
|---|---|---|
| `MNPRoutes.home` | `/` | `MNPHomePage` |
| `MNPRoutes.about` | `/about` | `MNPAboutPage` |
| `MNPRoutes.leadership` | `/leadership` | `MNPLeadershipPage` |
| `MNPRoutes.services` | `/services` | `MNPServicesPage` |
| `MNPRoutes.gallery` | `/gallery` | `MNPGalleryPage` |
| `MNPRoutes.contact` | `/contact` | `MNPContactPage` |

Navigation uses `Navigator.pushNamed`.

## Theme System (`mnp_theme.dart`)

### Colors (`MNPColors`)
| Token | Hex | Usage |
|---|---|---|
| `gold` | `#C9A96E` | Primary accent, CTAs, active states |
| `goldDark` | `#B8860B` | Gold hover/press variant |
| `ivory` | `#FAF7F2` | Default light section background |
| `ivoryDark` | `#F0EBE3` | Alternate light section background |
| `charcoal` | `#1A1A1A` | Primary dark background, dark cards |
| `charcoalMid` | `#2C2C2C` | Dividers, borders on dark backgrounds |
| `sectionDark` | `#111111` | Philosophy / dark sections |
| `warmGrey` | `#8A8A8A` | Body text, secondary text |
| `lightGrey` | `#D4CFC9` | Borders on light backgrounds |
| `white` | `#FFFFFF` | Text on dark backgrounds |

### Typography (`MNPTextStyles`)
All text styles are responsive via `_responsive(context, desktop, tablet, mobile)`.

| Style | Font | Usage |
|---|---|---|
| `displayLarge` | Cormorant Garamond 72/52/38 w300 | Hero headline |
| `displayMedium` | Cormorant Garamond 52/40/32 w300 | Section headlines |
| `displaySmall` | Cormorant Garamond 38/32/26 w400 | Sub-section headlines |
| `headlineLarge` | Cormorant Garamond 28/24/20 w500 | Card titles |
| `bodyLarge` | Lato 16/15/14 w300 | Paragraph text |
| `bodyMedium` | Lato 14/13/13 w400 | Secondary body text |
| `labelLarge` | Lato 11 w700 letterSpacing 3 | Section eyebrow labels |
| `navItem` | Lato 12 w400 letterSpacing 2.5 | Navbar links |
| `italic` | Cormorant Garamond italic w300 | Hero italic accent word |
| `italicMedium` | Cormorant Garamond italic w300 | Section italic accent word |

### Breakpoints & Layout (`MNPDimensions`)
| Breakpoint | Width |
|---|---|
| Desktop | >= 1024px |
| Tablet | 768px – 1023px |
| Mobile | < 768px |

Horizontal padding:
- >= 1200px: auto-centering within 1140px max-width container
- >= 1024px: 60px
- >= 768px: 40px
- Mobile: 24px

## Page Scaffold

Every page uses `MNPPageScaffold` which wraps content with:
- `MNPNavbar` (sticky, overlaid on content, transparent by default)
- `MNPFooter`
- `SingleChildScrollView` for the body

## Key Dependencies

| Package | Purpose |
|---|---|
| `google_fonts` | Cormorant Garamond + Lato typefaces |
| `cached_network_image` | Image loading with cache |

## Brand

- **Name:** My Next Property
- **Tagline:** "We do not simply sell properties. We counsel legacies."
- **Phone:** +91 98188 12223
- **Email:** info@mynextproperty.in / luxury@mynextproperty.in
- **Address:** Shop No. 37, Opposite Vita Dairy, Sector 46, Gurgaon-122003, Haryana
- **Domain:** mynextproperty.in
