# EmersonDigital Website

## Project Overview
Marketing website for EmersonDigital, showcasing three apps:
- **North Star Learning** - Educational games for kids (Flutter, closed beta)
- **BIMGeoSpace** - GPS-accurate AR for construction documentation (Android/Kotlin, ARCore)
- **Neon Task Grid** - Voice-powered task management (TypeScript, AWS, OpenAI)

**Live URL:** https://emersondigital.dev
**Status:** North Star Learning in closed beta, other apps coming soon

## Tech Stack
- **Framework:** Astro 5.x (static site generation)
- **Styling:** Tailwind CSS 4.x
- **Content:** Markdown with frontmatter (blog posts)
- **Hosting:** AWS S3 + CloudFront CDN
- **Domain:** Cloudflare (emersondigital.dev)

## Design System: "Light Synthwave" + App Themes
**Default (Light):**
- Background: #FAFAFA (off-white)
- Surface: #FFFFFF (cards)
- Text Primary: #1a1a2e (deep navy)
- Accent Cyan: #06b6d4
- Accent Pink: #ec4899
- Gradient: linear-gradient(135deg, cyan, pink)

**Dark Neon Theme** (Neon Task Grid):
- Background: #0c1020 (deep blue-black)
- Accent Cyan: #60f2ff, Accent Pink: #ff6fbf
- Scanlines overlay, neon glows

**Dark Geo Theme** (BIMGeoSpace):
- Background: #0a1628 (earth/satellite blue)
- Accent Cyan: #03dac5, Accent Purple: #bb86fc
- Topo-line overlay, accuracy pulse animations

## Project Structure
```
src/
├── components/     # Reusable Astro components
├── content/blog/   # Blog posts (currently "coming soon" placeholder)
├── layouts/        # Page layouts (Base, Blog)
├── pages/          # Routes
│   ├── apps/       # App detail pages (learning-games, bimgeospace, neon-task-grid)
│   └── blog/       # Blog listing + dynamic [slug]
├── styles/         # Global CSS
└── lib/            # Utility functions
promo/              # Marketing images (Instagram posts, ads, app illustrations)
```

## AWS Infrastructure
- **S3 Bucket:** emersondigital-website
- **CloudFront Distribution:** ENN2X7ZMEE1PY
- **CloudFront Domain:** d36aqd64of20jg.cloudfront.net
- **ACM Certificate:** arn:aws:acm:us-east-1:970547335738:certificate/2e3a8c39-b0d2-41c5-8044-00f5881bc06c

## Cloudflare DNS Records
| Type | Name | Target |
|------|------|--------|
| CNAME | @ | d36aqd64of20jg.cloudfront.net |
| CNAME | www | d36aqd64of20jg.cloudfront.net |
| CNAME | _a6066af081b71a6dd0772d4c73088613 | (ACM validation) |

## Commands

### Development
```bash
npm run dev      # Start dev server at localhost:4321
npm run build    # Build to dist/
npm run preview  # Preview production build
```

### Deployment
```bash
# Build and sync to S3
npm run build
aws s3 sync dist/ s3://emersondigital-website --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id ENN2X7ZMEE1PY --paths "/*"
```

## Adding Blog Posts
Create a new `.md` file in `src/content/blog/` with frontmatter:
```yaml
---
title: "Post Title"
description: "Brief description"
date: 2025-01-30
tags: ["tag1", "tag2"]
image: "/images/blog/optional-image.png"
---
```

## Key Files
- `astro.config.mjs` - Astro + Tailwind config
- `src/styles/global.css` - Design system, utilities
- `src/layouts/BaseLayout.astro` - Main layout with SEO
- `src/content/config.ts` - Content collection schema

## Repository
- **GitHub:** https://github.com/alkalibloo/emersondigital-website
- **Branch:** master

## Related Resources
- `ROLLOUT-PLAN.md` - Marketing strategy and social media plan
- `YOUR-TASKS-CHECKLIST.html` - Manual setup tasks (accounts to create)
- `promo/` - Marketing images for Instagram/ads (5 Instagram posts, 5 ads, app illustrations)

## Recent Changes
- Renamed learning games app to "North Star Learning"
- Added closed beta signup CTA to North Star Learning page
- Redesigned app page with 5 game modes (Memory Cards, Math Bucket, Word Match, Spell It!, Typing Fun)
- Replaced blog with "coming soon" placeholder
- Removed GitHub link from footer and contact page
- Updated social links (Twitter: @EmersonDigit, Email: contact@emersondigital.dev)
- **Neon Task Grid page redesign**: Dark neon synthwave theme, voice AI feature highlight, accurate tech stack, UI mockups
  - Added `theme` prop to BaseLayout for dark-neon mode
  - Added comprehensive dark theme CSS with neon glows, scanlines, and animations
- **BIMGeoSpace page redesign**: Dark geo theme with earth/satellite colors, accurate Android AR app features
  - Added `dark-geo` theme to BaseLayout and global.css
  - Accurate tech stack: Kotlin, ARCore Geospatial API, SceneView, AWS Lambda, DynamoDB, S3
  - AR interface mockup with accuracy indicators, coordinate HUD, three tap modes (ADD/POLL/DELETE)
  - Cloud architecture diagram, site documentation workflow, professional use cases
  - Source app analyzed from: `C:\Users\alkal\AndroidStudioProjects\BIMGeoSpace`

## Next Steps (for Claude)
When user returns, potential tasks:
- [ ] Add Google Analytics (need Measurement ID)
- [ ] Add newsletter signup form
- [ ] Build custom /links page
- [ ] Add press kit page (/press)
- [ ] Add the promo/ images to git if ready to commit
- [ ] Write first blog posts when ready
