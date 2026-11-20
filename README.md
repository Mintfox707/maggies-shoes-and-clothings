# Maggie's Shoes & Clothings

A responsive starter storefront for a Zambia-based shoes and clothing shop. It includes a product catalogue, category filters and search, a shopping bag, an owner product editor with photo uploads, and order handoff through WhatsApp with MTN Mobile Money, Airtel Money, Zamtel Kwacha, or cash selected as the customer's preferred payment method.

## Preview the shop

The easiest option is GitHub Pages: open **Settings → Pages**, choose **Deploy from a branch**, select `main` and `/ (root)`, then save. GitHub will show the published URL when deployment is ready. You can also download the repository and open `index.html` in a browser; a local web server is recommended for the best experience.

## Add your own products

1. Open the shop and tap the menu icon (☰) in the top-right to open **Manage your shop**.
2. Under **Add a product**, enter its name, price in ZMW, category, and short description.
3. Choose a product photo from your phone or computer (JPEG/PNG/WebP; up to 2 MB), then select **Save product**.
4. Add the shop WhatsApp number in international format using digits only, for example `260977123456`, and save it. Customers can add products to their bag, enter delivery details, select a preferred payment option, and send the order details to the shop in WhatsApp.
5. Use **Edit** or **Delete** in the product list to manage products.

## Important before taking real orders

This version is a front-end prototype. Products, photos, and the WhatsApp setting are saved in the current browser's local storage; they are **not uploaded to a shared online database**, so products added on one device do not automatically appear on other customers' devices. The sample catalogue is demo content. Remove it and add your actual stock before using the shop.

Checkout creates a WhatsApp order request; it does not collect money or verify payment. The customer and shop owner must confirm stock, delivery costs, and Mobile Money instructions directly. Never ask customers for a Mobile Money PIN or OTP. Before publicly launching a real shop, connect a secure backend and a payment provider that supports your Zambian business and preferred networks, and configure hosting/domain and privacy practices.

## Files

- `index.html` — storefront, cart, checkout and shop-management dialogs
- `styles.css` — responsive visual styling
- `app.js` — product catalogue, browser storage, cart and WhatsApp order flow

No build step or npm packages are required.
