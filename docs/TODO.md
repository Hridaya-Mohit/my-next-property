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
- [ ] Add meta title, description, og:image tags in `web/index.html`
- [ ] Add sitemap.xml
- [ ] Add robots.txt
- [x] Add Google Analytics GA4 + Microsoft Clarity
- [ ] Add GA4 hostname filter to only count traffic from `mynextproperty.in` (GA4 → Admin → Data Streams → your stream → Configure tag settings → hostname filters)
- [ ] Move GA4 and Clarity IDs to GitHub repository secrets and inject via environment variables at build time in GitHub Actions

### Content
- [ ] Replace Unsplash placeholder images with real property photos
- [ ] Add real team bios and headshots to Leadership page

## Enhancements
_Better long-term replacements for current implementations. Not urgent — revisit when the site scales._

### Form Submission
- [ ] **Firebase Firestore + Trigger Email extension** — replaces EmailJS. Every submission is saved as a lead in Firestore (queryable database of all enquiries) and simultaneously triggers an email notification. Gives you a full CRM-like lead history, not just inbox emails.

### Analytics
- [ ] **PostHog** — replaces GA4 + Clarity with a single unified platform. Gives you event tracking, session recordings, heatmaps, funnels, and user journeys all in one place. Open-source and can be self-hosted for full data ownership with no monthly cost.

## Completed
- [x] Initial site scaffold (Home, About, Leadership, Services, Gallery, Contact)
- [x] Responsive layout (mobile / tablet / desktop breakpoints)
- [x] Navbar with desktop nav + mobile drawer
- [x] Footer with brand, navigation, and contact columns
- [x] GitHub Actions deployment to GitHub Pages
- [x] Custom domain `mynextproperty.in` configured
