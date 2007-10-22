-- upgrade-3.3.0.0.0-3.4.0.0.0.sql


create or replace function inline_0 ()
returns integer as '
DECLARE
        v_count                 integer;
BEGIN
	select count(*) into v_count
	from user_tab_columns
	where	lower(table_name) = ''persons''
		and lower(column_name) = ''skin'';
	IF v_count > 0 THEN return 0; END IF;

	alter table persons add skin int not null default 0;

	return 0;
end;' language 'plpgsql';
select inline_0();
drop function inline_0();

