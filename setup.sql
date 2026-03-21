-- ══════════════════════════════════════════════
-- OS SUSHINADOS — Setup do banco de dados
-- Cole este SQL no Supabase: SQL Editor → New query
-- ══════════════════════════════════════════════

-- Tabela de restaurantes
create table public.restaurants (
  id text primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  name text not null,
  cuisine text default '',
  city text default '',
  price text default '',
  stars integer default 0,
  voltar text default '',
  visit_date text default '',
  notes text default '',
  maps_link text default '',
  fav boolean default false,
  photo_count integer default 0,
  created_at bigint not null
);

-- Tabela de lista de desejos
create table public.wishes (
  id text primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  name text not null,
  cuisine text default '',
  city text default '',
  notes text default '',
  created_at bigint not null
);

-- Tabela de fotos (base64 comprimido)
create table public.photos (
  id text primary key,
  restaurant_id text not null,
  user_id uuid references auth.users(id) on delete cascade not null,
  data text not null,
  sort_order integer default 0
);

-- Ativar segurança por linha (RLS)
alter table public.restaurants enable row level security;
alter table public.wishes enable row level security;
alter table public.photos enable row level security;

-- Políticas: cada usuário só vê e edita os próprios dados
create policy "owner_restaurants" on public.restaurants
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "owner_wishes" on public.wishes
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "owner_photos" on public.photos
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
