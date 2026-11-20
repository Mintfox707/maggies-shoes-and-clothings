# Maggie's Shoes & Clothings

Responsive Zambia-focused shoes and clothing storefront.

## Install on Android or iPhone

The shop is a Progressive Web App (PWA). After it is published at an HTTPS address:

1. Open the shop in Chrome or another compatible mobile browser.
2. Tap **Install** in the header, or open the browser menu and choose **Install app** / **Add to Home screen**.
3. Maggie's will appear on the home screen and open in its own app-style window.

The PWA also works for basic browsing offline after its first successful visit. Product updates and checkout require an internet connection.

## Shared product setup

1. Create a Supabase project at https://supabase.com.
2. Copy the Project URL and anon/public key into `config.js`.
3. Run `supabase/schema.sql` in the Supabase SQL Editor.
4. Create the owner's email/password account, copy its UUID, and add it to `shop_admins`.
5. Publish the repository using GitHub Pages.

Never place a Supabase `service_role` key in browser files.

## Google Play Store

A PWA can be added to the Android home screen, but publishing the shop in Google Play requires an additional Android/TWA package, Play Store assets, a Play Developer account, app signing, and a privacy policy. The PWA is the first step toward that package.

## Payment verification

Checkout sends an order request through WhatsApp and does not verify money. Verified payments require a Zambia-supported gateway, merchant onboarding, a secure server endpoint, and signed webhook/status verification.
