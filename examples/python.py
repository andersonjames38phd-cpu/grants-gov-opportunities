"""Grants.gov Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Open climate grants
run = client.actor("Turboextract/grants-gov-opportunities").call(run_input={
    "keywords": [
        "climate"
    ],
    "status": "posted",
    "maxResults": 100
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("title"), item.get("closeDate"), item.get("awardCeiling"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
