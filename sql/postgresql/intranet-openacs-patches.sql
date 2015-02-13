-- /packages/intranet/sql/postgres/intranet-openacs-patches.sql
--
-- Copyright (c) 1999-2008 various parties
-- The code is based on ArsDigita ACS 3.4
--
-- This program is free software. You can redistribute it
-- and/or modify it under the terms of the GNU General
-- Public License as published by the Free Software Foundation;
-- either version 2 of the License, or (at your option)
-- any later version. This program is distributed in the
-- hope that it will be useful, but WITHOUT ANY WARRANTY;
-- without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU General Public License for more details.
--
-- @author      frank.bergmann@project-open.com

-----------------------------------------------------
-- Set Parameters

-- reset the SystemCSS parameter to NULL
-- in order to enable the V3.4 GUI

update apm_parameter_values set
	attr_value = NULL
where parameter_id in (
		select	parameter_id
		from	apm_parameters
		where	package_key = 'intranet-core' 
			and parameter_name = 'SystemCSS'
);




-----------------------------------------------------



-- added
select define_function_args('acs_privilege__create_privilege','privilege,pretty_name;null,pretty_plural;null');

--
-- procedure acs_privilege__create_privilege/3
--
CREATE OR REPLACE FUNCTION acs_privilege__create_privilege(
   create_privilege__privilege varchar,
   create_privilege__pretty_name varchar,  -- default null
   create_privilege__pretty_plural varchar -- default null

) RETURNS integer AS $$
DECLARE
	v_count					integer;
BEGIN
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
END;
$$ LANGUAGE plpgsql;




-- added
select define_function_args('acs_privilege__add_child','privilege,child_privilege');

--
-- procedure acs_privilege__add_child/2
--
CREATE OR REPLACE FUNCTION acs_privilege__add_child(
   add_child__privilege varchar,
   add_child__child_privilege varchar
) RETURNS integer AS $$
DECLARE
	v_count				integer;
BEGIN
	SELECT count(*) into v_count from acs_privilege_hierarchy
	WHERE privilege = add_child__privilege and child_privilege = add_child__child_privilege;
	IF v_count > 0 THEN return 0; END IF;

	insert into acs_privilege_hierarchy (privilege, child_privilege)
	values (add_child__privilege, add_child__child_privilege);

	return 0; 
END;
$$ LANGUAGE plpgsql;




create or replace function ad_group_member_p(integer, integer) returns character AS '
declare
	p_user_id		alias for $1;
	p_group_id		alias for $2;

	ad_group_member_count	integer;
begin
	select count(*)	into ad_group_member_count
	from	acs_rels r,
		membership_rels mr
	where
		r.rel_id = mr.rel_id
		and object_id_one = p_group_id
		and object_id_two = p_user_id
		and mr.member_state = 'approved'
	;

	if ad_group_member_count = 0 then
		return 'f';
	else
		return 't';
	end if;
END;
$$ LANGUAGE plpgsql;



-------------------------------------------------------------
-- Portrait Fields
--


--
-- procedure inline_0/0
--
CREATE OR REPLACE FUNCTION inline_0(

) RETURNS integer AS $$
DECLARE
        v_count                 integer;
BEGIN
        select  count(*) into v_count from user_tab_columns
        where   lower(table_name) = 'persons' and lower(column_name) = 'portrait_checkdate';
        if v_count = 1 then return 0; end if;

	alter table persons add portrait_checkdate date;
	alter table persons add portrait_file varchar(400);

        return 0;
END;
$$ LANGUAGE plpgsql;
select inline_0 ();
drop function inline_0 ();


-- Extend the OpenACS type system 


--
-- procedure inline_0/0
--
CREATE OR REPLACE FUNCTION inline_0(

) RETURNS integer AS $$
DECLARE
        v_count                 integer;
BEGIN
	select count(*) into v_count from user_tab_columns
	where lower(table_name) = 'acs_object_types' and lower(column_name) = 'status_column';
	IF v_count > 0 THEN return 0; END IF;

	alter table acs_object_types
	add status_column character varying(30);
	
	alter table acs_object_types
	add type_column character varying(30);
	
	alter table acs_object_types
	add status_type_table character varying(30);

	return 0;
END;
$$ LANGUAGE plpgsql;
select inline_0();
drop function inline_0();



-- Add a "skin" field to users table


--
-- procedure inline_0/0
--
CREATE OR REPLACE FUNCTION inline_0(

) RETURNS integer AS $$
DECLARE
        v_count                 integer;
BEGIN
	select count(*) into v_count from user_tab_columns
	where	lower(table_name) = 'users' and lower(column_name) = 'skin';
	IF v_count > 0 THEN return 0; END IF;

	alter table users add skin int not null default 0;

	return 0;
END;
$$ LANGUAGE plpgsql;
select inline_0();
drop function inline_0();


