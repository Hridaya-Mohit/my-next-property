# My Next Property — TODO

## In Progress
_Nothing currently in progress._

## Pending

### UX / Interactions
- [ ] Scroll-triggered fade/slide-in animations for page sections
- [ ] Animated statistics counter on home page (e.g. "500+ properties", "15+ years")
- [ ] Smooth animated page transitions between routes
- [ ] Navbar background transition on scroll (currently wired but `_scrolled` never set to true)

### Navigation
- [ ] Wire scroll listener in `MNPNavbar` to actually toggle `_scrolled` state
- [ ] Active state highlight in mobile drawer (currently missing)

### Home Page
- [ ] Add testimonials / client quotes section
- [ ] Replace developer name text with actual logos in the Developer Associations section
- [ ] Floating WhatsApp CTA button (quick contact widget)

### Contact Page
- [ ] Form submission integration (email service / backend)
- [ ] Client-side form validation with visual feedback

### Gallery Page
- [ ] Lightbox / fullscreen image viewer
- [ ] Category filtering (Residential, Commercial, Industrial)

### Footer
- [ ] Wire social icon buttons (LinkedIn, Instagram, etc.) to real URLs
- [ ] Make Privacy Policy, Disclaimer, RERA footer links functional
- [ ] Add RERA registration number

### SEO & Web
- [ ] Add meta title, description, og:image tags in `web/index.html`
- [ ] Add sitemap.xml
- [ ] Add robots.txt
- [x] Add Google Analytics GA4 + Microsoft Clarity
- [ ] Add GA4 hostname filter to only count traffic from `mynextproperty.in` (GA4 → Admin → Data Streams → your stream → Configure tag settings → hostname filters)
- [ ] Move GA4 and Clarity IDs to GitHub repository secrets and inject via environment variables at build time in GitHub Actions

### Content
- [ ] Replace Unsplash placeholder images with real property photos
- [ ] Add real team bios and headshots to Leadership page

## Completed
- [x] Initial site scaffold (Home, About, Leadership, Services, Gallery, Contact)
- [x] Responsive layout (mobile / tablet / desktop breakpoints)
- [x] Navbar with desktop nav + mobile drawer
- [x] Footer with brand, navigation, and contact columns
- [x] GitHub Actions deployment to GitHub Pages
- [x] Custom domain `mynextproperty.in` configured
