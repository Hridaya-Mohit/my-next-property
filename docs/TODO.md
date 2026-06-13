# My Next Property — TODO

## In Progress
_Nothing currently in progress._

## Pending

### UX / Interactions
- [x] Scroll-triggered fade/slide-in animations for page sections (all pages)
- [x] Animated statistics counter on home page (15+ years, ₹2000 Cr+, 8+ developers, 500+ clients)
- [ ] Smooth animated page transitions between routes
- [x] Splash screen with gold line reveal animation
- [x] Navbar background transition on scroll

### Navigation
- [ ] Active state highlight in mobile drawer (currently missing)

### Home Page
- [ ] Add testimonials / client quotes section
- [ ] Replace developer name text with actual logos in the Developer Associations section
- [x] Floating WhatsApp CTA button (quick contact widget)

### Contact Page
- [x] Form submission via EmailJS
- [ ] Client-side form validation with visual feedback

### Gallery Page
- [ ] Lightbox / fullscreen image viewer
- [ ] Category filtering (Residential, Commercial, Industrial)

### Footer
- [ ] Wire social icon buttons (LinkedIn, Instagram, etc.) to real URLs
- [ ] Make Privacy Policy, Disclaimer, RERA footer links functional
- [ ] Add RERA registration number

### SEO & Web
- [x] Fix page title and meta description in `web/index.html`
- [ ] Add og:image tags in `web/index.html`
- [ ] Add sitemap.xml
- [ ] Add robots.txt
- [x] Add Google Analytics GA4 + Microsoft Clarity (Clarity has limited value on Flutter web — canvas rendering prevents session recordings and heatmaps from working)
- [x] Add GA4 CTA event tracking across all buttons (cta_click + form_submit events)
- [ ] Remove Clarity script from `index.html` once PostHog is integrated
- [ ] Add GA4 hostname filter to only count traffic from `mynextproperty.in` (GA4 → Admin → Data Streams → your stream → Configure tag settings → hostname filters)
- [ ] Move GA4 and Clarity IDs to GitHub repository secrets and inject via environment variables at build time in GitHub Actions

### Content
- [ ] Replace Unsplash placeholder images with real property photos
- [x] Updated leadership page to single member (Vishal Kathuria) with placeholder image
- [ ] Add real headshot for Vishal Kathuria

## Enhancements
_Better long-term replacements for current implementations. Not urgent — revisit when the site scales._

### Form Submission
- [ ] **Firebase Firestore + Trigger Email extension** — replaces EmailJS. Every submission is saved as a lead in Firestore (queryable database of all enquiries) and simultaneously triggers an email notification. Gives you a full CRM-like lead history, not just inbox emails.

### Analytics
- [ ] **PostHog** — supplement GA4 with richer product analytics (funnels, user journeys, retention, heatmaps via code events). Works perfectly with Flutter web canvas rendering since it tracks via Dart events not DOM. Session recordings have same canvas limitation as Clarity. Free tier: 1M events/month. Self-hostable.

## Completed
- [x] Initial site scaffold (Home, About, Leadership, Services, Gallery, Contact)
- [x] Responsive layout (mobile / tablet / desktop breakpoints)
- [x] Navbar with desktop nav + mobile drawer
- [x] Footer with brand, navigation, and contact columns
- [x] GitHub Actions deployment to GitHub Pages
- [x] Custom domain `mynextproperty.in` configured
- [x] GA4 + Microsoft Clarity analytics
- [x] GA4 SPA page tracking via NavigatorObserver
- [x] GA4 CTA event tracking (cta_click + form_submit)
- [x] Scroll-triggered animations on all pages via MNPAnimatedSection
- [x] Contact form submission via EmailJS
- [x] WhatsApp buttons wired with pre-filled message
- [x] Splash screen with gold line reveal animation
- [x] Navbar scroll-aware background
