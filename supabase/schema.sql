-- Run this in Supabase Dashboard > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.shop_admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 1 and 70),
  price integer not null check (price > 0),
  category text not null check (category in ('Shoes', 'Clothing', 'Accessories')),
  description text not null default '',
  image_url text not null,
  badge text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.shop_settings (
  key text primary key,
  value text not null default '',
  updated_at timestamptz not null default now()
);

alter table public.shop_admins enable row level security;
alter table public.products enable row level security;
alter table public.shop_settings enable row level security;

-- A signed-in owner can see their own admin membership. Add the owner's user UUID below.
drop policy if exists "Admins can read own membership" on public.shop_admins;
create policy "Admins can read own membership" on public.shop_admins
  for select to authenticated using (user_id = (select auth.uid()));

drop policy if exists "Anyone can view products" on public.products;
create policy "Anyone can view products" on public.products
  for select to anon, authenticated using (true);

drop policy if exists "Admins can add products" on public.products;
create policy "Admins can add products" on public.products
  for insert to authenticated with check (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  );
drop policy if exists "Admins can update products" on public.products;
create policy "Admins can update products" on public.products
  for update to authenticated using (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  ) with check (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  );
drop policy if exists "Admins can delete products" on public.products;
create policy "Admins can delete products" on public.products
  for delete to authenticated using (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  );

drop policy if exists "Anyone can view shop settings" on public.shop_settings;
create policy "Anyone can view shop settings" on public.shop_settings
  for select to anon, authenticated using (true);
drop policy if exists "Admins can manage shop settings" on public.shop_settings;
create policy "Admins can manage shop settings" on public.shop_settings
  for all to authenticated using (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  ) with check (
    exists (select 1 from public.shop_admins a where a.user_id = (select auth.uid()))
  );

-- Product photos are public to display in the shop; only listed admins can upload/change/delete.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('product-images', 'product-images', true, 2097152, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 2097152,
  allowed_mime_types = array['image/jpeg','image/png','image/webp'];

drop policy if exists "Anyone can view product photos" on storage.objects;
create policy "Anyone can view product photos" on storage.objects
  for select to anon, authenticated using (bucket_id = 'product-images');
drop policy if exists "Admins can upload product photos" on storage.objects;
create policy "Admins can upload product photos" on storage.objects
  for insert to authenticated with check (
    bucket_id = 'product-images' and exists (
      select 1 from public.shop_admins a where a.user_id = (select auth.uid())
    )
  );
drop policy if exists "Admins can update product photos" on storage.objects;
create policy "Admins can update product photos" on storage.objects
  for update to authenticated using (
    bucket_id = 'product-images' and exists (
      select 1 from public.shop_admins a where a.user_id = (select auth.uid())
    )
  ) with check (
    bucket_id = 'product-images' and exists (
      select 1 from public.shop_admins a where a.user_id = (select auth.uid())
    )
  );
drop policy if exists "Admins can delete product photos" on storage.objects;
create policy "Admins can delete product photos" on storage.objects
  for delete to authenticated using (
    bucket_id = 'product-images' and exists (
      select 1 from public.shop_admins a where a.user_id = (select auth.uid())
    )
  );

-- After creating the shop owner's account in Supabase Auth, replace the UUID and run:
-- insert into public.shop_admins (user_id) values ('OWNER-AUTH-USER-UUID');
