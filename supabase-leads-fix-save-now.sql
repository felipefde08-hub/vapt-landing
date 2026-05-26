-- CORRECAO RAPIDA PARA O FORMULARIO SALVAR LEADS
-- Rode no SQL Editor do projeto:
-- https://xudidufzbiiizphtoqwh.supabase.co
--
-- Esta versao libera INSERT publico e bloqueia SELECT publico por permissao.
-- Depois que estiver salvando, se quiser, da para voltar para RLS refinado.

alter table public.leads disable row level security;

revoke all on public.leads from anon;
revoke all on public.leads from authenticated;

grant usage on schema public to anon, authenticated;

grant insert on public.leads to anon;
grant insert on public.leads to authenticated;
grant select on public.leads to authenticated;

grant usage, select on all sequences in schema public to anon, authenticated;
