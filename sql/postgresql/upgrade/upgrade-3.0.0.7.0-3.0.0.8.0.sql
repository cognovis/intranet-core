
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

