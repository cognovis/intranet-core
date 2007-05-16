



create or replace function inline_0 ()
returns integer as '
declare
        v_count                 integer;
begin
        select  count(*)
        into    v_count
        from    user_tab_columns
        where   upper(table_name) = upper(''users'')
                and upper(column_name) = upper(''theme'');

        if v_count > 0 then
            return 0;
        end if;

        alter table users add theme varchar(32);

    return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();
