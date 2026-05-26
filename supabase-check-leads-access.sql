-- Rode este SQL para verificar como a tabela leads esta configurada.
-- Se ainda nao salvar depois do fix, me mande o resultado dessas consultas.

select
  n.nspname as schema,
  c.relname as tabela,
  c.relrowsecurity as rls_ativo,
  c.relforcerowsecurity as rls_forcado
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where n.nspname = 'public'
  and c.relname = 'leads';

select
  schemaname,
  tablename,
  policyname,
  roles,
  cmd,
  qual,
  with_check
from pg_policies
where schemaname = 'public'
  and tablename = 'leads';

select
  grantee,
  privilege_type
from information_schema.role_table_grants
where table_schema = 'public'
  and table_name = 'leads'
  and grantee in ('anon', 'authenticated')
order by grantee, privilege_type;
