// Grants.gov Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Everything NSF has open or coming
const run = await client.actor('Turboextract/grants-gov-opportunities').call({
    "agencies": [
        "NSF"
    ],
    "status": "open",
    "maxResults": 200
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.title, item.closeDate, item.awardCeiling);
}
