<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "/usr/share/emacs/DTDs/xql.dtd">


<queryset>
  <rdbms>
    <type>postgresql</type>
    <version>8.1</version>
  </rdbms>

  <fullquery name="column_list_sql">
    <querytext>
      select	w.deref_plpgsql_function,
      		aa.attribute_name
      from    	im_dynfield_widgets w,
      		im_dynfield_attributes a,
      		acs_attributes aa
      where   	a.widget_name = w.widget_name and
      		a.acs_attribute_id = aa.attribute_id and
      		aa.object_type = 'im_project'
      
    </querytext>
  </fullquery>


</queryset>

