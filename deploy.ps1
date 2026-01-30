# EmersonDigital Website Deployment Script (PowerShell)
# =====================================================
# This script builds and deploys the website to AWS S3 and invalidates CloudFront cache.

$ErrorActionPreference = "Stop"

# Configuration
$S3_BUCKET = "emersondigital-website"
# Set your CloudFront distribution ID here
$CLOUDFRONT_DIST_ID = ""

Write-Host "`n🚀 EmersonDigital Website Deployment" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Build the site
Write-Host "`n📦 Building site..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed" -ForegroundColor Red
    exit 1
}

# Check if AWS CLI is installed
try {
    aws --version | Out-Null
} catch {
    Write-Host "❌ AWS CLI is not installed. Please install it first." -ForegroundColor Red
    Write-Host "   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
}

# Check if bucket name is configured
if ($S3_BUCKET -eq "emersondigital-website") {
    Write-Host "`n⚠️  Using default bucket name: $S3_BUCKET" -ForegroundColor Yellow
    Write-Host "   Edit this script to change the bucket name if needed."
}

# Sync to S3
Write-Host "`n☁️  Syncing to S3..." -ForegroundColor Yellow
aws s3 sync dist/ "s3://$S3_BUCKET" --delete

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ S3 sync failed" -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Files uploaded to S3" -ForegroundColor Green

# Invalidate CloudFront cache if distribution ID is set
if ($CLOUDFRONT_DIST_ID) {
    Write-Host "`n🔄 Invalidating CloudFront cache..." -ForegroundColor Yellow
    aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST_ID --paths "/*"

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ CloudFront cache invalidation started" -ForegroundColor Green
    }
} else {
    Write-Host "`n⚠️  CloudFront distribution ID not set." -ForegroundColor Yellow
    Write-Host '   To invalidate cache, run:'
    Write-Host '   aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths "/*"'
}

Write-Host "`n🎉 Deployment complete!" -ForegroundColor Green
Write-Host "`nYour site should be live at:"
Write-Host "   S3: http://$S3_BUCKET.s3-website-us-east-1.amazonaws.com"
Write-Host "   (or your CloudFront/custom domain)"
