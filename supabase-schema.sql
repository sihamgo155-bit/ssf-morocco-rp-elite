-- Optional starter schema only. Review and test security policies before real use.
create table if not exists public.applications (
  id uuid primary key default gen_random_uuid(),
  full_name text not null check (char_length(full_name) between 2 and 60),
  discord_name text not null check (char_length(discord_name) between 2 and 80),
  age integer not null check (age between 13 and 99),
  availability text not null,
  experience text not null,
  motivation text not null,
  status text not null default 'pending' check (status in ('pending','reviewing','accepted','rejected')),
  created_at timestamptz not null default now()
);
alter table public.applications enable row level security;
-- Example minimum: public may submit only. Reading/updating/deleting should be limited to trusted admin identities.
drop policy if exists "public can submit application" on public.applications;
create policy "public can submit application" on public.applications for insert to anon, authenticated with check (true);
-- Intentionally no public SELECT/UPDATE/DELETE policy. Add admin-only policies after setting up trusted auth metadata.
