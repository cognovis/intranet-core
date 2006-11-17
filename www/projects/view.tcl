# /packages/intranet-core/projects/view.tcl
#
# Copyright (C) 1998-2004 various parties
# The software is based on ArsDigita ACS 3.4
#
# This program is free software. You can redistribute it
# and/or modify it under the terms of the GNU General
# Public License as published by the Free Software Foundation;
# either version 2 of the License, or (at your option)
# any later version. This program is distributed in the
# hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

ad_page_contract {
    View all the info about a specific project.

    @param project_id the group id
    @param orderby the display order
    @param show_all_comments whether to show all comments

    @author mbryzek@arsdigita.com
    @author Frank Bergmann (frank.bergmann@project-open.com)
} {
    { project_id:integer 0}
    { object_id:integer 0}
    { orderby "subproject_name"}
    { show_all_comments 0}
    { forum_order_by "" }
    { view_name "standard"}
    { subproject_status_id "" }
}

# ---------------------------------------------------------------------
# Defaults & Security
# ---------------------------------------------------------------------

set user_id [ad_maybe_redirect_for_registration]
set return_url [im_url_with_query]
set current_url [ns_conn url]
set clone_url "/intranet/projects/clone"

set bgcolor(0) " class=roweven"
set bgcolor(1) " class=rowodd"

if {0 == $project_id} {set project_id $object_id}
if {0 == $project_id} {
    ad_return_complaint 1 "<li>[_ intranet-core.lt_You_need_to_specify_a] "
    return
}

set subproject_filtering_enabled_p [ad_parameter -package_id [im_package_core_id] SubprojectStatusFilteringEnabledP "" 0]
set subproject_filtering_default_status_id [ad_parameter -package_id [im_package_core_id] SubprojectStatusFilteringDefaultStatus "" ""]

if {$subproject_filtering_enabled_p} {
    if {"" == $subproject_status_id} { set subproject_status_id $subproject_filtering_default_status_id }
}

# ---------------------------------------------------------------------
# Get Everything about the project
# ---------------------------------------------------------------------


set query "
select
	p.*,
	c.company_name,
	c.company_path,
	to_char(p.end_date, 'HH24:MI') as end_date_time,
	to_char(p.start_date, 'YYYY-MM-DD') as start_date_formatted,
	to_char(p.end_date, 'YYYY-MM-DD') as end_date_formatted,
	to_char(p.percent_completed, '999990.9%') as percent_completed_formatted,
	im_category_from_id(p.project_type_id) as project_type, 
	im_category_from_id(p.project_status_id) as project_status,
	c.primary_contact_id as company_contact_id,
	im_name_from_user_id(c.primary_contact_id) as company_contact,
	im_email_from_user_id(c.primary_contact_id) as company_contact_email,
	im_name_from_user_id(p.project_lead_id) as project_lead,
	im_name_from_user_id(p.supervisor_id) as supervisor,
	im_name_from_user_id(c.manager_id) as manager
from
	im_projects p, 
	im_companies c

where 
	p.project_id=:project_id
	and p.company_id = c.company_id
"

if { ![db_0or1row projects_info_query $query] } {
    ad_return_complaint 1 "[_ intranet-core.lt_Cant_find_the_project]"
    return
}

set parent_name [db_string parent_name "select project_name from im_projects where project_id = :parent_id" -default ""]


# ---------------------------------------------------------------------
# Redirect to timesheet if this is timesheet
# ---------------------------------------------------------------------

# Redirect if this is a timesheet task (subtype of project)
if {$project_type_id == [im_project_type_task]} {
    ad_returnredirect [export_vars -base "/intranet-timesheet2-tasks/new" {{task_id $project_id}}]

}

# ---------------------------------------------------------------------
# Check permissions
# ---------------------------------------------------------------------

# get the current users permissions for this project
im_project_permissions $user_id $project_id view read write admin

# Compatibility with old components...
set current_user_id $user_id
set user_admin_p $admin

if {![db_string ex "select count(*) from im_projects where project_id=:project_id"]} {
    ad_return_complaint 1 "<li>Project doesn't exist"
    return
}

if {!$read} {
    ad_return_complaint 1 "<li>[_ intranet-core.lt_You_have_insufficient_6]"
    return
}

# ---------------------------------------------------------------------
# Set the context bar as a function on whether this is a subproject or not:
# ---------------------------------------------------------------------

set page_title "$project_nr - $project_name"
set context_bar [im_context_bar [list /intranet/projects/ "[_ intranet-core.Projects]"] $page_title]

if { [empty_string_p $parent_id] } {
    set context_bar [im_context_bar [list /intranet/projects/ "[_ intranet-core.Projects]"] "[_ intranet-core.One_project]"]
    set include_subproject_p 1
} else {
    set context_bar [im_context_bar [list /intranet/projects/ "[_ intranet-core.Projects]"] [list "/intranet/projects/view?project_id=$parent_id" "[_ intranet-core.One_project]"] "[_ intranet-core.One_subproject]"]
    set include_subproject_p 0
}

# Fraber: 051125: There is no "view_projects" privilege...
# Don't show subproject nor a link to the "projects" page to freelancers
#if {![im_permission $user_id view_projects]} {
#    set context_bar [im_context_bar "[_ intranet-core.One_project]"]
#    set include_subproject_p 0
#}


# VAW Special: Dont show dates to non-employees
# ToDo: Replace with DynField dynamic field perms
set user_can_see_start_end_date_p [expr [im_user_is_employee_p $current_user_id] || [im_user_is_customer_p $current_user_id]]


# ---------------------------------------------------------------------
# Project Base Data
# ---------------------------------------------------------------------

set project_base_data_html "
			<table border=0>
			  <tr> 
			    <td colspan=2 class=rowtitle align=center>
			      [_ intranet-core.Project_Base_Data]
			    </td>
			  </tr>
			  <tr> 
			    <td>[_ intranet-core.Project_name]</td>
			    <td>$project_name</td>
			  </tr>"

if { ![empty_string_p $parent_id] } { 
    append project_base_data_html "
			  <tr> 
			    <td>[_ intranet-core.Parent_Project]</td>
			    <td>
			      <a href=/intranet/projects/view?project_id=$parent_id>$parent_name</a>
			    </td>
			  </tr>"
}

append project_base_data_html "
			  <tr> 
			    <td>[_ intranet-core.Project]</td>
			    <td>$project_path</td>
			  </tr>
[im_company_link_tr $user_id $company_id $company_name "[_ intranet-core.Client]"]
			  <tr> 
			    <td>[_ intranet-core.Project_Manager]</td>
			    <td>
[im_render_user_id $project_lead_id $project_lead $user_id $project_id]
			    </td>
			  </tr>
			  <tr> 
			    <td>[_ intranet-core.Project_Type]</td>
			    <td>$project_type</td>
			  </tr>
			  <tr> 
			    <td>[_ intranet-core.Project_Status]</td>
			    <td>$project_status</td>
			  </tr>\n"

# VAW Special: Freelancers shouldnt see star and end date
# ToDo: Replace this hard coded condition with DynField
# permissions per field.
if { $user_can_see_start_end_date_p && ![empty_string_p $start_date] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Start_Date]</td>
			    <td>$start_date_formatted</td>
			  </tr>"
}

if { $user_can_see_start_end_date_p && ![empty_string_p $end_date] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Delivery_Date]</td>
			    <td>$end_date_formatted $end_date_time</td>
			  </tr>"
}

append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.On_Track_Status]</td>
			    <td>[in_project_on_track_bb $on_track_status_id]</td>
			  </tr>"


if { ![empty_string_p $percent_completed] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Percent_Completed]</td>
			    <td>$percent_completed_formatted</td>
			  </tr>"
}

if { ![empty_string_p $project_budget_hours] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Project_Budget_Hours]</td>
			    <td>$project_budget_hours</td>
			  </tr>"
}

if {[im_permission $current_user_id view_budget]} {
    if { ![empty_string_p $project_budget] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Project_Budget]</td>
			    <td>$project_budget $project_budget_currency</td>
			  </tr>"
    }
}



if { ![empty_string_p $company_project_nr] } { 
    append project_base_data_html "
			  <tr>
			    <td>[lang::message::lookup "" intranet-core.Company_Project_Nr "Customer Project Nr"]</td>
			    <td>$company_project_nr</td>
			  </tr>"
}


if { ![empty_string_p $description] } { append project_base_data_html "
			  <tr>
			    <td>[_ intranet-core.Description]</td>
			    <td width=250>$description</td>
			  </tr>"
}

if {$write} {
	append project_base_data_html "
			  <tr> 
			    <td>&nbsp; </td>
			    <td> 
			      <form action=/intranet/projects/new method=POST>
				  [export_form_vars project_id return_url]
				  <input type=submit value=\"[_ intranet-core.Edit]\" name=submit3>
			      </form>
			    </td>
			  </tr>"
}
append project_base_data_html "    </table>
			<br>
"


# ---------------------------------------------------------------------
# Admin Box
# ---------------------------------------------------------------------

set admin_html_content ""
if {$admin} {
    append admin_html_content "<li><A href=\"/intranet/projects/new?parent_id=$project_id\">[_ intranet-core.Create_a_Subproject]</A>\n"
}

set exec_pr_help [lang::message::lookup "" intranet-core.Execution_Project_Help "An 'Execution Project' is a copy of the current project, but without any references to the project's customers. This options allows you to delegate the management of an 'Execution Project' to freelance project managers etc."]

set clone_pr_help [lang::message::lookup "" intranet-core.Clone_Project_Help "A 'Clone' is an exact copy of your project. You can use this function to standardize repeating projects."]

set clone_project_enabled_p [ad_parameter -package_id [im_package_core_id] EnableCloneProjectLinkP "" 0]
set execution_project_enabled_p [ad_parameter -package_id [im_package_core_id] EnableExecutionProjectLinkP "" 0]

if {$clone_project_enabled_p && [im_permission $current_user_id add_projects]} {
    append admin_html_content "
    <li><A href=\"[export_vars -base $clone_url { { parent_project_id $project_id } }]\">[lang::message::lookup "" intranet-core.Clone_Project "Clone this project"]</A>[im_gif -translate_p 0 help $clone_pr_help]\n"
}

if {$execution_project_enabled_p && [im_permission $current_user_id add_projects]} {
    append admin_html_content "
    <li><A href=\"[export_vars -base $clone_url { {parent_project_id $project_id} {company_id [im_company_internal]} { clone_postfix "Execution Project"} }]\">[lang::message::lookup "" intranet-core.Execution_Project "Create an 'Execution Project'"]
</A>[im_gif -translate_p 0 help $exec_pr_help]\n"
}

set admin_html ""
if {"" != $admin_html_content} {
    set admin_html [im_table_with_title "[_ intranet-core.Admin_Project]" $admin_html_content]
}


# ---------------------------------------------------------------------
# Project Hierarchy
# ---------------------------------------------------------------------

# Determine the Top superproject of the current
# project.
set super_project_id $project_id
set loop 1
set ctr 0
while {$loop} {
    set loop 0
    set parent_id [db_string parent_id "select parent_id from im_projects where project_id=:super_project_id"]

    if {"" != $parent_id} {
	set super_project_id $parent_id
	set loop 1
    }

    # Check for recursive loop
    if {$ctr > 20} {
	set loop 0
    }
    incr ctr
}


# Check permissions for showing subprojects
set perm_sql "
	(select	p.*
	from	im_projects p,
		acs_rels r
	where	r.object_id_one = p.project_id
		and r.object_id_two = :user_id
	)
"
if {[im_permission $user_id "view_projects_all"]} { set perm_sql "im_projects" }


set project_url "/intranet/projects/view"
set space "&nbsp; &nbsp; &nbsp; "


set subproject_status_sql ""
if {"" != $subproject_status_id && 0 != $subproject_status_id} {
    set subproject_status_sql "
        and children.project_status_id in (
		select	child_id
		from	im_category_hierarchy
		where	parent_id = :subproject_status_id
	    UNION
		select	:subproject_status_id as child_id
	)
    "
}

db_multirow -extend {subproject_indent subproject_url subproject_bold_p} subprojects project_hierarchy {} {
    
    set subproject_url [export_vars -base $project_url {{project_id $subproject_id}}]
    set subproject_indent ""
    for {set i 0} {$i < $subproject_level} {incr i} { append subproject_indent $space }
    set subproject_bold_p [expr $project_id == $subproject_id]

}


# ---------------------------------------------------------------------
# Projects Submenu
# ---------------------------------------------------------------------

# Setup the subnavbar
set bind_vars [ns_set create]
ns_set put $bind_vars project_id $project_id

set parent_menu_id [db_string parent_menu "select menu_id from im_menus where label='project'" -default 0]

ns_log Notice "/project/view: end of view.tcl"
