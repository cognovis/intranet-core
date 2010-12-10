-- upgrade-3.4.9.9.9-3.5.0.0.0.sql

SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-3.4.9.9.9-3.5.0.0.0.sql','');


-- Fix names of object types
update acs_object_types
set pretty_name = 'Key Account Rel' 
where object_type = 'im_key_account_rel';

update acs_object_types
set pretty_name = 'Company Employee Rel' 
where object_type = 'im_company_employee_rel';


