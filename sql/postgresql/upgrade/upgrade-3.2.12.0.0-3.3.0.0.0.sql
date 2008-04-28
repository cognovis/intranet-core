-- upgrade-3.2.12.0.0-3.3.0.0.0.sql

\i upgrade-3.0.0.0.first.sql


-------------------------------------------------------------
-- Audit for im_projects
--
-- The table and audit trigger definition will in future be
-- defined by the intranet-dynfield module to take care of
-- dynamic extensions of data types

create table im_projects_audit (
        modifying_action		varchar(20),
        last_modified			timestamptz,
        last_modifying_user		integer,
	last_modifying_ip		varchar(20),

	project_id			integer,
	project_name			varchar(1000),
	project_nr			varchar(100),
	project_path			varchar(100),
	parent_id			integer,
	company_id			integer,
	project_type_id			integer,
	project_status_id		integer,
	description			varchar(4000),
	billing_type_id			integer,
	note				varchar(4000),
	project_lead_id			integer,
	supervisor_id			integer,
	project_budget			float,
	corporate_sponsor		integer,
	percent_completed		float,
	on_track_status_id		integer,
	project_budget_currency		character(3),
	project_budget_hours		float,
	end_date			timestamptz,
	start_date			timestamptz,
	company_contact_id		integer,
	company_project_nr		varchar(50),
	final_company			varchar(50)
);

create index im_projects_audit_project_id_idx on im_projects_audit(project_id);


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

