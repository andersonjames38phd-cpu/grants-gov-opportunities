#!/usr/bin/env bash
# Grants.gov Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~grants-gov-opportunities"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Open climate grants (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "keywords": [
      "climate"
    ],
    "status": "posted",
    "maxResults": 100
  }'

# 2. Everything NSF has open or coming (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "agencies": [
      "NSF"
    ],
    "status": "open",
    "maxResults": 200
  }'

# 3. Grants posted in the last 7 days (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "keywords": [],
    "postedWithinDays": 7
  }'
