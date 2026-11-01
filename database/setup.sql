-- Ejecutar una vez en un proyecto NUEVO de Supabase.
-- No crea usuarios ni asigna permisos de equipo automáticamente.
create table public.pv_members (
 user_id uuid primary key references auth.users(id) on delete cascade,
 created_at timestamptz not null default now()
);
alter table public.pv_members enable row level security;
grant select on public.pv_members to authenticated;
create policy member_self on public.pv_members for select to authenticated using (user_id=(select auth.uid()));
create table public.pv_products (
 id uuid primary key default gen_random_uuid(), sku text not null unique check(length(sku) between 1 and 60),
 name text not null check(length(name) between 1 and 160), category text not null default '',
 price numeric(12,2) not null default 0 check(price>=0), stock integer not null default 0 check(stock>=0),
 description text not null default '', created_at timestamptz not null default now()
);
create table public.pv_clients (
 id uuid primary key default gen_random_uuid(), name text not null check(length(name) between 1 and 160),
 document text not null default '' check(document='' or document ~ '^([0-9]{8}|[0-9]{11})$'),
 phone text not null default '', email text not null default '', notes text not null default '',
 created_at timestamptz not null default now()
);
create table public.pv_quotes (
 id uuid primary key default gen_random_uuid(), client_id uuid not null references public.pv_clients(id) on delete restrict,
 product_id uuid not null references public.pv_products(id) on delete restrict,
 quantity integer not null check(quantity>0), unit_price numeric(12,2) not null check(unit_price>=0),
 status text not null default 'Pendiente' check(status in ('Pendiente','Enviada','Ganada','Perdida')),
 follow_up date, notes text not null default '', created_at timestamptz not null default now()
);
create index pv_quotes_client on public.pv_quotes(client_id);
create index pv_quotes_product on public.pv_quotes(product_id);
create index pv_quotes_followup on public.pv_quotes(follow_up);
alter table public.pv_products enable row level security;
alter table public.pv_clients enable row level security;
alter table public.pv_quotes enable row level security;
grant select,insert,update,delete on public.pv_products,public.pv_clients,public.pv_quotes to authenticated;
create policy team_products on public.pv_products for all to authenticated using (exists(select 1 from public.pv_members where user_id=(select auth.uid()))) with check (exists(select 1 from public.pv_members where user_id=(select auth.uid())));
create policy team_clients on public.pv_clients for all to authenticated using (exists(select 1 from public.pv_members where user_id=(select auth.uid()))) with check (exists(select 1 from public.pv_members where user_id=(select auth.uid())));
create policy team_quotes on public.pv_quotes for all to authenticated using (exists(select 1 from public.pv_members where user_id=(select auth.uid()))) with check (exists(select 1 from public.pv_members where user_id=(select auth.uid())));
-- Crear/invitar a cada usuario desde Supabase Auth. Luego, como administrador:
-- insert into public.pv_members(user_id) values ('UUID_REAL_DEL_USUARIO');
-- No conceder INSERT/UPDATE/DELETE en pv_members a los usuarios del navegador.
