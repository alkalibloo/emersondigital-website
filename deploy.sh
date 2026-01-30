#!/bin/bash

# EmersonDigital Website Deployment Script
# =========================================
# This script builds and deploys the website to AWS S3 and invalidates CloudFront cache.

set -e

# Configuration
S3_BUCKET="emersondigital-website"
# Set your CloudFront distribution ID here
CLOUDFRONT_DIST_ID=""

echo "🚀 EmersonDigital Website Deployment"
echo "====================================="

# Build the site
echo ""
echo "📦 Building site..."
npm run build

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    echo "   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

# Check if bucket name is configured
if [ "$S3_BUCKET" = "emersondigital-website" ]; then
    echo ""
    echo "⚠️  Using default bucket name: $S3_BUCKET"
    echo "   Edit this script to change the bucket name if needed."
fi

# Sync to S3
echo ""
echo "☁️  Syncing to S3..."
aws s3 sync dist/ s3://$S3_BUCKET --delete

echo ""
echo "✅ Files uploaded to S3"

# Invalidate CloudFront cache if distribution ID is set
if [ -n "$CLOUDFRONT_DIST_ID" ]; then
    echo ""
    echo "🔄 Invalidating CloudFront cache..."
    aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST_ID --paths "/*"
    echo "✅ CloudFront cache invalidation started"
else
    echo ""
    echo "⚠️  CloudFront distribution ID not set."
    echo "   To invalidate cache, run:"
    echo "   aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths \"/*\""
fi

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "Your site should be live at:"
echo "   S3: http://$S3_BUCKET.s3-website-us-east-1.amazonaws.com"
echo "   (or your CloudFront/custom domain)"
