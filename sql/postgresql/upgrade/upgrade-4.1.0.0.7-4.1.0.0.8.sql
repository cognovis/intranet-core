-- upgrade-4.1.0.0.7-4.1.0.0.8.sql
SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-4.1.0.0.7-4.1.0.0.8.sql','');

-------------------------------------------------------------
-- Compatibility with PG > 8.2  IS NOT NULL / != NULL 

create or replace function im_priv_create (varchar, varchar)
returns integer as '
DECLARE
        p_priv_name             alias for $1;
        p_profile_name          alias for $2;

        v_profile_id            integer;
        v_object_id             integer;
        v_count                 integer;
BEGIN
        -- Get the group_id from group_name
        select group_id into v_profile_id from groups
        where group_name = p_profile_name;

        -- Get the Main Site id, used as the global identified for permissions
        select package_id into v_object_id from apm_packages
        where package_key=''acs-subsite'';

        select count(*) into v_count from acs_permissions
        where object_id = v_object_id and grantee_id = v_profile_id and privilege = p_priv_name;

        IF v_profile_id IS NOT NULL AND 0 = v_count THEN
                PERFORM acs_permission__grant_permission(v_object_id, v_profile_id, p_priv_name);
        END IF;

        return 0;
end;' language 'plpgsql';


