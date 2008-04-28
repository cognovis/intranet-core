-- upgrade-3.3.1.1.0-3.3.1.2.0.sql

\i upgrade-3.0.0.0.first.sql

CREATE OR REPLACE FUNCTION im_category_new (
        integer, varchar, varchar
) RETURNS integer as '
DECLARE
        p_category_id           alias for $1;
        p_category              alias for $2;
        p_category_type         alias for $3;
        v_count                 integer;
BEGIN
        select  count(*) into v_count
        from    im_categories
        where   category = p_category and
                category_type = p_category_type;

        IF v_count > 0 THEN return 0; END IF;

        insert into im_categories(category_id, category, category_type)
        values (p_category_id, p_category, p_category_type);

        RETURN 0;
end;' language 'plpgsql';




-- Add "require_manual_login" privilege

create or replace function inline_0 ()
returns integer as '
declare
        v_count                 integer;
begin
        select count(*) into v_count from acs_privileges
        where privilege = ''require_manual_login'';
        IF 0 != v_count THEN return 0; END IF;

	PERFORM acs_privilege__create_privilege(
		''require_manual_login'',
		''Require manual login - dont allow auto-login'',
		''Require manual login - dont allow auto-login''
	);
	PERFORM acs_privilege__add_child(''admin'', ''require_manual_login'');

    return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();

select im_priv_create('require_manual_login','P/O Admins');
select im_priv_create('require_manual_login','Senior Managers');
select im_priv_create('require_manual_login','Project Managers');
select im_priv_create('require_manual_login','Accounting');
-- select im_priv_create('require_manual_login','Employees');


-- Add a "rounding factor" to currencies.
-- This factor is 100 (2 digits) for EUR, USD, GBP etc,
-- but 20 for CHF (rounding on 0.05 CHF)
alter table currency_codes
add rounding_factor integer default 100;

update currency_codes set rounding_factor = 20 where iso='CHF';

