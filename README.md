# Maggie's Shoes & Clothings

Responsive Zambia-focused shoes and clothing storefront. The optional Supabase setup makes the product catalogue, uploaded photos, and shop WhatsApp number shared between devices, while owner-only product editing is protected by Supabase Auth and row-level security (RLS).

## Connect shared products and photos

1. Create a Supabase project at [supabase.com](https://supabase.com/).
2. In **Project Settings → API**, copy the Project URL and the **anon/public** key. Put them into `config.js`. The anon key is intended for browser use; never put a `service_role` key in this website.
3. In Supabase **SQL Editor**, run the contents of `supabase/schema.sql`.
4. In Supabase **Authentication → Users**, create the owner's email/password account. Copy that user's UUID and run the final `insert into public.shop_admins ...` statement in the SQL editor, substituting the UUID. Disable public sign-ups after creating the owner.
5. Publish the repository using **Settings → Pages → Deploy from a branch → main → /(root)**. Open the published site; products and uploaded photos now load from Supabase for every visitor/device. Sign in through the menu icon to add/edit/delete products.

The `product-images` storage bucket is public for product display; only the owner membership allowed by RLS can upload or change photos. Use small JPG, PNG, or WebP photos (up to 2 MB). Products that were previously saved in a browser's local storage do not automatically migrate; re-add them from the owner device after setup.

## Payments: important setup still required

Checkout currently sends an order request through WhatsApp and **does not collect or verify money**. No payment is marked as successful based on a screenshot, customer message, or browser request. To enable automatic verified payments, Maggie's must first register with a Zambia-supported payment provider (for example Ontech Payments, Digital PayGo, or Just-Tap), complete their merchant onboarding, and obtain their official API/webhook documentation and sandbox/live credentials. The secure server-side checkout and signed webhook must then be implemented for the chosen provider and deployed with its secrets stored as server-side environment variables (never in `config.js` or browser code).

Before implementing the provider-specific payment integration, choose your provider and share a link to its official API/webhook docs. Do not send API secrets, passwords, Mobile Money PINs, or OTPs in chat. The gateway must confirm the transaction server-to-server before an order is marked paid.

## Local preview

Open `index.html` in a browser for the local demo. Without Supabase config the sample products and browser-local editor work on that device only. No npm/build step is required. With Supabase configured, serve the repository over HTTPS (GitHub Pages is fine) and complete the setup above for shared data.
