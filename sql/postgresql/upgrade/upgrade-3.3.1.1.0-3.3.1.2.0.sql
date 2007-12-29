-- upgrade-3.3.1.1.0-3.3.1.2.0.sql





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




-- -------------------------------------------------------
-- Setup "components" menu 
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu			integer;
	v_admin_menu		integer;
	v_main_menu		integer;
BEGIN
	select menu_id into v_main_menu
	from im_menus where label = ''admin'';

	-- Main admin menu - just an invisible top-menu
	-- for all admin entries links under Projects
	v_admin_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-core'',		-- package_name
		''admin_components'',		-- label
		''Components'',			-- name
		''/intranet/admin/components/'', -- url
		90,				-- sort_order
		v_main_menu,			-- parent_menu_id
		''0''				-- p_visible_tcl
	);

	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();




-- -------------------------------------------------------
-- Setup "DynView" menu 
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu			integer;
	v_admin_menu		integer;
	v_main_menu		integer;
BEGIN
	select menu_id into v_main_menu
	from im_menus where label = ''admin'';

	-- Main admin menu - just an invisible top-menu
	-- for all admin entries links under Projects
	v_admin_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-core'',		-- package_name
		''admin_dynview'',		-- label
		''DynView'',			-- name
		''/intranet/admin/views/'',	-- url
		751,				-- sort_order
		v_main_menu,			-- parent_menu_id
		''0''				-- p_visible_tcl
	);

	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();



-- -------------------------------------------------------
-- Setup "backup" menu 
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu			integer;
	v_admin_menu		integer;
	v_main_menu		integer;
BEGIN
	select menu_id into v_main_menu
	from im_menus where label = ''admin'';

	-- Main admin menu - just an invisible top-menu
	-- for all admin entries links under Projects
	v_admin_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-core'',		-- package_name
		''admin_backup'',		-- label
		''Backup'',			-- name
		''/intranet/admin/backup/'',	-- url
		11,				-- sort_order
		v_main_menu,			-- parent_menu_id
		''0''				-- p_visible_tcl
	);

	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();



-- -------------------------------------------------------
-- Setup "Packages" menu 
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu			integer;
	v_admin_menu		integer;
	v_main_menu		integer;
BEGIN
	select menu_id into v_main_menu
	from im_menus where label = ''admin'';

	-- Main admin menu - just an invisible top-menu
	-- for all admin entries links under Projects
	v_admin_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-core'',		-- package_name
		''admin_packages'',		-- label
		''Packages'',			-- name
		''/acs-admin/apm/'',		-- url
		190,				-- sort_order
		v_main_menu,			-- parent_menu_id
		''0''				-- p_visible_tcl
	);

	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();



-- -------------------------------------------------------
-- Setup "Workflow" menu 
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu			integer;
	v_admin_menu		integer;
	v_main_menu		integer;
BEGIN
	select menu_id into v_main_menu
	from im_menus where label = ''admin'';

	-- Main admin menu - just an invisible top-menu
	-- for all admin entries links under Projects
	v_admin_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-workflow'',		-- package_name
		''admin_workflow'',		-- label
		''Workflow'',			-- name
		''/workflow/admin/'',		-- url
		1090,				-- sort_order
		v_main_menu,			-- parent_menu_id
		''0''				-- p_visible_tcl
	);

	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();

