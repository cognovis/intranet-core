ad_page_contract {
    The display for the project base data 
    @author iuri sampaio (iuri.sampaio@gmail.com)
    @author malte sussdorff (malte.sussdorff@cognovis.de)
    @date 2010-10-07

} 

# ---------------------------------------------------------------------
# Get Everything about the project
# ---------------------------------------------------------------------
 
set user_id [ad_conn user_id] 
im_dynfield::object_array -array_name project -object_id $project_id
set object_type_id $project(object_type_id)
set project_type [im_category_from_id $project(project_type_id)]
set project_status [im_category_from_id $project(project_status_id)]
set parent_id $project(parent_id_orig)

# Get the parent project's name
if {"" == $parent_id} { set parent_id 0 }
im_security_alert_check_integer -location "intranet-core/lib/project-base-data: parent_id" -value $parent_id

# get the current users permissions for this project
im_project_permissions $user_id $project_id view read write admin
set edit_project_base_data_p [im_permission $user_id edit_project_basedata]

# ---------------------------------------------------------------------
# Get Everything about the project
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# Add DynField Columns to the display
set old_section ""

set default_layout_p [db_string select_layout "select 0 from im_dynfield_layout where page_url = '/intranet/projects/index' limit 1" -default 1]

if {$default_layout_p} {
    set layout_where "and la.page_url = (select page_url from im_dynfield_layout_pages where object_type = 'im_project' and default_p ='t')"
} else {
    set layout_where "and la.page_url = '/intranet/projects/index'"
}
 

db_multirow -extend {attrib_var value} project_info dynfield_attribs_sql "
      select
      		aa.pretty_name,
      		aa.attribute_name,
            tam.section_heading,
            w.widget, w.widget_name
      from
      		im_dynfield_widgets w,
      		acs_attributes aa,
            im_dynfield_type_attribute_map tam,
      		im_dynfield_attributes da, 
            im_dynfield_layout la
      where
            da.widget_name = w.widget_name and
            da.acs_attribute_id = aa.attribute_id and
            da.attribute_id = tam.attribute_id and
            tam.object_type_id = :object_type_id and
            la.attribute_id = da.attribute_id and
            acs_permission__permission_p(da.attribute_id,:user_id,'read') = 't' and
            tam.display_mode in ('edit','display')
            $layout_where
      order by la.pos_y
" {
    set heading ""    
    if {![info exists section_heading]} {
        set section_heading ""
    }

    if {$old_section != $section_heading} {
        set heading $section_heading
        set old_section $section_heading
    }   
   
    # Set the value
    if {[info exists project($attribute_name)]} {
	    set value $project($attribute_name)
    } else {
	    set value ""
    }

    if {"" != [string trim $value]} {
        # Set the field name
        set pretty_name_key "intranet-core.[lang::util::suggest_key $attribute_name]"
        set pretty_name [lang::message::lookup "" $pretty_name_key $pretty_name]

        switch $widget {
            richtext {
    	        regsub -all {\"} $value {'} value
                if { [ad_html_text_convertable_p -from "[lindex $value 1]" -to "text/html"] } {
                    set value [template::util::richtext::get_property html_value "[set $attribute_name]"]
                }
            }
            project_parent_options {
    	        set parent_project_id $project(parent_id_orig)
                set project_url [export_vars -base "/intranet/projects/view" -url {{project_id $parent_project_id}}]
    	        set value "<a href='$project_url'>$value</a>"
            }
            customers {
    	        set company_url [export_vars -base "/intranet/companies/view" -url {{company_id $project(company_id_orig)}}]
                set value "<a href='$company_url'>$value</a>"
            }
            project_managers {
                set value [im_render_user_id $project(project_lead_id_orig) $value $user_id $project_id]
            }
            category_project_on_track_status {
                set im_project_on_track_bb [im_project_on_track_bb $project(on_track_status_id)]
            }
        }
    } else {
        continue
    } 	
}

# -----------------------------------
# Notification Subscription Button
# -----------------------------------

# Provide the subscribe / unsubscribe option
set notification_type_id [notification::type::get_type_id -short_name "project_notif"]
set notification_request_id [notification::request::get_request_id \
				 -type_id $notification_type_id \
				 -object_id $project_id \
				 -user_id $user_id]
set notification_return_url [im_url_with_query]

if { $notification_request_id ne "" } {
    set notification_url [notification::display::unsubscribe_url -request_id $notification_request_id -url $notification_return_url]
    set notification_message [_ notifications.lt_Ubsubscribe_Notification_ [list pretty_name "$project(project_name)"]]
    set notification_button [_ notifications.Unsubscribe]
} else {
    set notification_delivery_method_id  [notification::get_delivery_method_id -name "email"]
    set notification_interval_id [notification::get_interval_id -name "instant"]
    set notification_url [export_vars -base "/notifications/request-new?" {
	{object_id $project_id} 
	{type_id $notification_type_id}
	{delivery_method_id $notification_delivery_method_id}
	{interval_id $notification_interval_id}
	{"form\:id" "subscribe"}
	{formbutton\:ok "OK"}
	{return_url $notification_return_url}
    }]
    set notification_message [_ notifications.lt_Request_Notification_ [list pretty_name "$project(project_name)"]]
    set notification_button [_ notifications.Request_Notification]
}
