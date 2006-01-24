
-- Add a privilege to allow all users to edit projects
--
select acs_privilege__create_privilege('edit_projects_all','Edit All Projects','Edit All Projects');
select acs_privilege__add_child('admin', 'edit_projects_all');

