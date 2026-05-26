-- Rode este SQL no projeto correto do Supabase:
-- https://xudidufzbiiizphtoqwh.supabase.co
--
-- Ele permite que o site cadastre leads e que apenas o admin leia a tabela.

alter table public.leads enable row level security;

do $$
declare
  policy_record record;
begin
  for policy_record in
    select policyname
    from pg_policies
    where schemaname = 'public'
      and tablename = 'leads'
  loop
    execute format('drop policy if exists %I on public.leads', policy_record.policyname);
  end loop;
end
$$;

grant usage on schema public to anon, authenticated;
grant insert on public.leads to anon, authenticated;
grant select on public.leads to authenticated;
grant usage, select on all sequences in schema public to anon, authenticated;

create policy "Public can create leads"
on public.leads
for insert
to public
with check (true);

create policy "Only admin can read leads"
on public.leads
for select
to authenticated
using (
  lower(auth.jwt() ->> 'email') = lower('vaptadmin@gmail.com')
);
