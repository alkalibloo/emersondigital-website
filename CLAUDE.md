# EmersonDigital Website

## Project Overview
Marketing website for EmersonDigital, showcasing three apps: North Star Learning, BIMGeoSpace, and Neon Task Grid.

**Live URL:** https://emersondigital.dev

## Tech Stack
- **Framework:** Astro 5.x (static site generation)
- **Styling:** Tailwind CSS 4.x
- **Content:** Markdown with frontmatter (blog posts)
- **Hosting:** AWS S3 + CloudFront CDN
- **Domain:** Cloudflare (emersondigital.dev)

## Design System: "Light Synthwave"
- Background: #FAFAFA (off-white)
- Surface: #FFFFFF (cards)
- Text Primary: #1a1a2e (deep navy)
- Accent Cyan: #06b6d4
- Accent Pink: #ec4899
- Gradient: linear-gradient(135deg, cyan, pink)

## Project Structure
```
src/
├── components/     # Reusable Astro components
├── content/blog/   # Markdown blog posts
├── layouts/        # Page layouts (Base, Blog)
├── pages/          # Routes
│   ├── apps/       # App detail pages
│   └── blog/       # Blog listing + dynamic [slug]
├── styles/         # Global CSS
└── lib/            # Utility functions
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

## Next Steps (for Claude)
When user returns, potential tasks:
- [ ] Add Google Analytics (need Measurement ID)
- [ ] Add newsletter signup form
- [ ] Build custom /links page
- [ ] Create social media graphics templates
- [ ] Add press kit page (/press)
