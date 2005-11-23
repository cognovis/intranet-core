
-- -----------------------------------------------------
-- Add template_p field to indicate templates
-- This field is not being used yet, but good for future
-- versions (3.1)

alter table im_projects add
        template_p              char(1)
                                constraint im_project_template_p
                                check (requires_report_p in ('t','f'))
;

-- add the default 't' value
alter table im_projects 
alter column template_p 
set default 't'
;



-- -----------------------------------------------------
-- Add privileges for budget and budget_hours
--
select acs_privilege__create_privilege('add_budget','Add Budget','Add Budget');
select acs_privilege__add_child('admin', 'add_budget');
select acs_privilege__create_privilege('view_budget','View Budget','View Budget');
select acs_privilege__add_child('admin', 'view_budget');

select acs_privilege__create_privilege('add_budget_hours','Add Budget Hours','Add Budget Hours');
select acs_privilege__add_child('admin', 'add_budget_hours');
select acs_privilege__create_privilege('view_budget_hours','View Budget Hours','View Budget Hours');
select acs_privilege__add_child('admin', 'view_budget_hours');


-- Set preliminary privileges to setup the 
-- permission matrix

select im_priv_create('view_budget','Accounting');
select im_priv_create('view_budget','P/O Admins');
select im_priv_create('view_budget','Project Managers');
select im_priv_create('view_budget','Senior Managers');

select im_priv_create('add_budget','Accounting');
select im_priv_create('add_budget','P/O Admins');
select im_priv_create('add_budget','Senior Managers');


select im_priv_create('view_budget_hours','Employees');
select im_priv_create('view_budget_hours','Accounting');
select im_priv_create('view_budget_hours','P/O Admins');
select im_priv_create('view_budget_hours','Project Managers');
select im_priv_create('view_budget_hours','Senior Managers');

select im_priv_create('add_budget_hours','Accounting');
select im_priv_create('add_budget_hours','P/O Admins');
select im_priv_create('add_budget_hours','Senior Managers');

