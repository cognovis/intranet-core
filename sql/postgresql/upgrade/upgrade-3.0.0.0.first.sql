--  upgrade-3.0.0.0.first.sql


-- Special upgrade script that includes a number of changed creation
-- scritps that are tollerant agains already existing data.


-- acs_privilege__create_privilege
-- acs_privilege__add_child
-- im_menu__new
-- im_component_plugin__new


-----------------------------------------------------------------------
-- acs_privileges
-----------------------------------------------------------------------

create or replace function acs_privilege__create_privilege (varchar,varchar,varchar)
returns integer as '
declare
	create_privilege__privilege             alias for $1;  
	create_privilege__pretty_name           alias for $2;  -- default null  
	create_privilege__pretty_plural         alias for $3;  -- default null
	v_count					integer;
begin
	select count(*) into v_count from acs_privileges
	where privilege = create_privilege__privilege;
	IF v_count > 0 THEN return 0; END IF;

	insert into acs_privileges (
		privilege, pretty_name, pretty_plural
	) values (
		create_privilege__privilege, 
		create_privilege__pretty_name, 
		create_privilege__pretty_plural
	);

    return 0; 
end;' language 'plpgsql';



create or replace function acs_privilege__add_child (varchar,varchar)
returns integer as '
declare
	add_child__privilege            alias for $1;  
	add_child__child_privilege      alias for $2;  
	v_count				integer;
begin
	select count(*) into v_count from acs_privilege_hierarchy
	where privilege = add_child__privilege and child_privilege = add_child__child_privilege;
	IF v_count > 0 THEN return 0; END IF;
	
	insert into acs_privilege_hierarchy (
		privilege, child_privilege
	) values (
		add_child__privilege, add_child__child_privilege
	);

    return 0; 
end;' language 'plpgsql';



-----------------------------------------------------------------------
-- im_menus
-----------------------------------------------------------------------

create or replace function im_menu__new (integer, varchar, timestamptz, integer, varchar, integer,
varchar, varchar, varchar, varchar, integer, integer, varchar) returns integer as '
declare
	p_menu_id	  alias for $1;   -- default null
        p_object_type	  alias for $2;   -- default ''acs_object''
        p_creation_date	  alias for $3;   -- default now()
        p_creation_user	  alias for $4;   -- default null
        p_creation_ip	  alias for $5;   -- default null
        p_context_id	  alias for $6;   -- default null
	p_package_name	  alias for $7;
	p_label		  alias for $8;
	p_name		  alias for $9;
	p_url		  alias for $10;
	p_sort_order	  alias for $11;
	p_parent_menu_id  alias for $12;
	p_visible_tcl	  alias for $13;  -- default null

	v_menu_id	  im_menus.menu_id%TYPE;
begin
	select	menu_id	into v_menu_id from im_menus m where m.label = p_label;
	IF v_menu_id is not null THEN return v_menu_id; END IF;

	v_menu_id := acs_object__new (
                p_menu_id,    -- object_id
                p_object_type,  -- object_type
                p_creation_date,        -- creation_date
                p_creation_user,        -- creation_user
                p_creation_ip,  -- creation_ip
                p_context_id    -- context_id
        );

	insert into im_menus (
		menu_id, package_name, label, name, 
		url, sort_order, parent_menu_id, visible_tcl
	) values (
		v_menu_id, p_package_name, p_label, p_name, p_url, 
		p_sort_order, p_parent_menu_id, p_visible_tcl
	);
	return v_menu_id;
end;' language 'plpgsql';


create or replace function im_new_menu (varchar, varchar, varchar, varchar, integer, varchar, varchar) 
returns integer as '
declare
	p_package_name		alias for $1;
	p_label			alias for $2;
	p_name			alias for $3;
	p_url			alias for $4;
	p_sort_order		alias for $5;
	p_parent_menu_label	alias for $6;
	p_visible_tcl		alias for $7;

	v_menu_id		integer;
	v_parent_menu_id	integer;
begin
	-- Check for duplicates
	select	menu_id into v_menu_id
	from	im_menus m where m.label = p_label;
	IF v_menu_id is not null THEN return v_menu_id; END IF;

	-- Get parent menu
	select	menu_id into v_parent_menu_id
	from	im_menus m where m.label = p_parent_menu_label;

	v_menu_id := im_menu__new (
		null,					-- p_menu_id
		''im_menu'',				-- object_type
		now(),					-- creation_date
		null,					-- creation_user
		null,					-- creation_ip
		null,					-- context_id
		p_package_name,
		p_label,
		p_name,
		p_url,
		p_sort_order,
		v_parent_menu_id,
		p_visible_tcl
	);

	return v_menu_id;
end;' language 'plpgsql';

create or replace function im_new_menu_perms (varchar, varchar)
returns integer as '
declare
	p_label		alias for $1;
	p_group		alias for $2;
	v_menu_id		integer;
	v_group_id		integer;
begin
	select	menu_id into v_menu_id
	from	im_menus where label = p_label;

	select	group_id into v_group_id
	from	groups where lower(group_name) = lower(p_group);

	PERFORM acs_permission__grant_permission(v_menu_id, v_group_id, ''read'');
	return v_menu_id;
end;' language 'plpgsql';





-----------------------------------------------------------------------
-- im_plugin_components
-----------------------------------------------------------------------


create or replace function im_component_plugin__new (
	integer, varchar, timestamptz, integer, varchar, integer, 
	varchar, varchar, varchar, varchar, varchar, integer, 
	varchar, varchar
) returns integer as '
declare
	p_plugin_id	alias for $1;	-- default null
	p_object_type	alias for $2;	-- default ''acs_object''
	p_creation_date	alias for $3;	-- default now()
	p_creation_user	alias for $4;	-- default null
	p_creation_ip	alias for $5;	-- default null
	p_context_id	alias for $6;	-- default null

	p_plugin_name	alias for $7;
	p_package_name	alias for $8;
	p_location	alias for $9;
	p_page_url	alias for $10;
	p_view_name	alias for $11;	-- default null
	p_sort_order	alias for $12;
	p_component_tcl	alias for $13;
	p_title_tcl	alias for $14;

	v_plugin_id	im_component_plugins.plugin_id%TYPE;
begin
	select plugin_id into v_plugin_id from im_component_plugins
	where plugin_name = p_plugin_name and package_name = p_package_name;
	IF v_plugin_id is not null THEN return v_plugin_id; END IF;

	v_plugin_id := acs_object__new (
		p_plugin_id,	-- object_id
		p_object_type,	-- object_type
		p_creation_date,	-- creation_date
		p_creation_user,	-- creation_user
		p_creation_ip,	-- creation_ip
		p_context_id	-- context_id
	);

	insert into im_component_plugins (
		plugin_id, plugin_name, package_name, sort_order, 
		view_name, page_url, location, 
		component_tcl, title_tcl
	) values (
		v_plugin_id, p_plugin_name, p_package_name, p_sort_order, 
		p_view_name, p_page_url, p_location, 
		p_component_tcl, p_title_tcl
	);

	return v_plugin_id;
end;' language 'plpgsql';


create or replace function im_component_plugin__new (
	integer, varchar, timestamptz, integer, varchar, integer, 
	varchar, varchar, varchar, varchar, varchar, integer, varchar
) returns integer as '
declare
	p_plugin_id	alias for $1;	-- default null
	p_object_type	alias for $2;	-- default ''acs_object''
	p_creation_date	alias for $3;	-- default now()
	p_creation_user	alias for $4;	-- default null
	p_creation_ip	alias for $5;	-- default null
	p_context_id	alias for $6;	-- default null
	p_plugin_name	alias for $7;
	p_package_name	alias for $8;
	p_location	alias for $9;
	p_page_url	alias for $10;
	p_view_name	alias for $11;
	p_sort_order	alias for $12;
	p_component_tcl	alias for $13;
	v_plugin_id	integer;
begin
	v_plugin_id := im_component_plugin__new (
		p_plugin_id, p_object_type, p_creation_date,
		p_creation_user, p_creation_ip, p_context_id,
		p_plugin_name, p_package_name,
		p_location, p_page_url,
		p_view_name, p_sort_order,
		p_component_tcl, null
	);
	return v_plugin_id;
end;' language 'plpgsql';


-------------------------------------------------------------
-- Insert a category for upgrade scripts - gracefully
-------------------------------------------------------------


CREATE OR REPLACE FUNCTION im_category_new (
	integer, varchar, varchar, varchar
) RETURNS integer as '
DECLARE
	p_category_id		alias for $1;
	p_category		alias for $2;
	p_category_type		alias for $3;
	p_description		alias for $4;

	v_count			integer;
BEGIN
	select	count(*) into v_count from im_categories
	where	category = p_category and category_type = p_category_type;
	IF v_count > 0 THEN return 0; END IF;

	insert into im_categories(category_id, category, category_type, category_description)
	values (p_category_id, p_category, p_category_type, p_description);

	RETURN 0;
end;' language 'plpgsql';


CREATE OR REPLACE FUNCTION im_category_new (
	integer, varchar, varchar
) RETURNS integer as '
DECLARE
	p_category_id	alias for $1;
	p_category		alias for $2;
	p_category_type	alias for $3;
	v_count		integer;
BEGIN
	select	count(*) into v_count from im_categories
	where	category = p_category and category_type = p_category_type;
	IF v_count > 0 THEN return 0; END IF;

	insert into im_categories(category_id, category, category_type)
	values (p_category_id, p_category, p_category_type);

	RETURN 0;
end;' language 'plpgsql';


CREATE OR REPLACE FUNCTION im_category_hierarchy_new (
	varchar, varchar, varchar
) RETURNS integer as '
DECLARE
	p_child			alias for $1;
	p_parent		alias for $2;
	p_cat_type		alias for $3;

	v_child_id		integer;
	v_parent_id		integer;
	v_count			integer;
BEGIN
	select	category_id into v_child_id from im_categories
	where	category = p_child and category_type = p_cat_type;
	IF v_child_id is null THEN RAISE NOTICE ''im_category_hierarchy_new: bad category 1: "%" '',p_child; END IF;

	select	category_id into v_parent_id from im_categories
	where	category = p_parent and category_type = p_cat_type;
	IF v_parent_id is null THEN RAISE NOTICE ''im_category_hierarchy_new: bad category 2: "%" '',p_parent; END IF;

	select	count(*) into v_count from im_category_hierarchy
	where	child_id = v_child_id and parent_id = v_parent_id;
	IF v_count > 0 THEN return 0; END IF;

	insert into im_category_hierarchy(child_id, parent_id)
	values (v_child_id, v_parent_id);

	RETURN 0;
end;' language 'plpgsql';



CREATE OR REPLACE FUNCTION im_category_hierarchy_new (
	integer, integer
) RETURNS integer as '
DECLARE
	p_child_id		alias for $1;
	p_parent_id		alias for $2;

	row			RECORD;
	v_count			integer;
BEGIN
	IF p_child_id is null THEN 
		RAISE NOTICE ''im_category_hierarchy_new: bad category 1: "%" '',p_child_id;
		return 0;
	END IF;

	IF p_parent_id is null THEN 
		RAISE NOTICE ''im_category_hierarchy_new: bad category 2: "%" '',p_parent_id; 
		return 0;
	END IF;
	IF p_child_id = p_parent_id THEN return 0; END IF;

	select	count(*) into v_count from im_category_hierarchy
	where	child_id = p_child_id and parent_id = p_parent_id;
	IF v_count = 0 THEN
		insert into im_category_hierarchy(child_id, parent_id)
		values (p_child_id, p_parent_id);
	END IF;

	-- Loop through the parents of the parent
	FOR row IN
		select	parent_id
		from	im_category_hierarchy
		where	child_id = p_parent_id
	LOOP
		PERFORM im_category_hierarchy_new (p_child_id, row.parent_id);
	END LOOP;

	RETURN 0;
end;' language 'plpgsql';


-----------------------------------------------------------------------
-- 
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- 
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- 
-----------------------------------------------------------------------

