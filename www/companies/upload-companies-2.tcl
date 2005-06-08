# /packages/intranet-core/www/companies/upload-companies-2.tcl
#
# Copyright (C) 1998-2004 various parties
# The code is based on ArsDigita ACS 3.4
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
    /intranet/companies/upload-contacts-2.tcl
    Read a .csv-file with header titles exactly matching
    the data model and insert the data into "users" and
    "acs_rels".

    @author various@arsdigita.com
    @author frank.bergmann@project-open.com
} {
    return_url
    upload_file
    company_type_id:integer
}

set current_user_id [ad_maybe_redirect_for_registration]
set page_title "Upload Companies CSV"
set page_body "<ul>"
set context_bar [im_context_bar [list "/intranet/cusomers/" "Companies"] $page_title]


# Get the file from the user.
# number_of_bytes is the upper-limit
set max_n_bytes [ad_parameter -package_id [im_package_filestorage_id] MaxNumberOfBytes "" 0]
set tmp_filename [ns_queryget upload_file.tmpfile]
if { $max_n_bytes && ([file size $tmp_filename] > $max_n_bytes) } {
    ad_return_complaint 1 "Your file is larger than the maximum permissible upload size:  [util_commify_number $max_n_bytes] bytes"
    return
}

# strip off the C:\directories... crud and just get the file name
if ![regexp {([^//\\]+)$} $upload_file match company_filename] {
    # couldn't find a match
    set company_filename $upload_file
}

if {[regexp {\.\.} $company_filename]} {
    set error "Filename contains forbidden characters"
    ad_returnredirect "/error.tcl?[export_url_vars error]"
}

if {![file readable $tmp_filename]} {
    set err_msg "Unable to read the file '$tmp_filename'. 
Please check the file permissions or contact your system administrator.\n"
    append page_body "\n$err_msg\n"
    doc_return  200 text/html [im_return_template]
    return
}

set csv_files_content [fileutil::cat $tmp_filename]
set csv_files [split $csv_files_content "\n"]
set csv_files_len [llength $csv_files]



set separator ";"
ns_log Notice "upload-companies-2: trying with separator=$separator"
# Split the header into its fields
set csv_header [string trim [lindex $csv_files 0]]
set csv_header_fields [im_csv_split $csv_header $separator]
set csv_header_len [llength $csv_header_fields]
if {1 == $csv_header_len} {
    # Probably got the wrong separator
    set separator ","
    ns_log Notice "upload-companies-2: changing to separator=$separator"
    set csv_header_fields [im_csv_split $csv_header $separator]
    set csv_header_len [llength $csv_header_fields]
}

for {set i 1} {$i < $csv_files_len} {incr i} {
    set csv_line [string trim [lindex $csv_files $i]]
    set csv_line_fields [im_csv_split $csv_line $separator]

    if {"" == $csv_line} {
	ns_log Notice "upload-companies-2: skipping empty line"
	continue
    }
    

    # Preset values, defined by CSV sheet:
    set user_id ""
    set email ""
    set password ""
    set last_name ""
    set registration_date ""
    set registration_ip ""
    set user_state ""
    set company_name ""
    set title ""
    set first_name ""
    set middle_name ""
    set last_name ""
    set suffix ""
    set company ""
    set department ""
    set job_title ""
    set business_street ""
    set business_street_2 ""
    set business_street_3 ""
    set business_city ""
    set business_state ""
    set business_postal_code ""
    set business_country ""
    set assistants_phone ""
    set business_fax ""
    set business_phone ""
    set business_phone_2 ""
    set callback ""
    set car_phone ""
    set company_main_phone ""
    set home_fax ""
    set home_phone ""
    set home_phone_2 ""
    set isdn ""
    set mobile_phone ""
    set other_fax ""
    set other_phone ""
    set pager ""
    set primary_phone ""
    set radio_phone ""
    set tty_tdd_phone ""
    set telex ""
    set account ""
    set anniversary ""
    set assistants_name ""
    set billing_information ""
    set birthday ""
    set categories ""
    set children ""
    set directory_server ""
    set e_mail_address ""
    set e_mail_display_name ""
    set e_mail_2_address ""
    set e_mail_2_display_name ""
    set e_mail_3_address ""
    set e_mail_3_display_name ""
    set gender ""
    set government_id_number ""
    set hobby ""
    set initials ""
    set internet_free_busy ""
    set keywords ""
    set language ""
    set location ""
    set managers_name ""
    set mileage ""
    set notes ""
    set office_location ""
    set organizational_id_number ""
    set po_box ""
    set priority ""
    set private ""
    set profession ""
    set referred_by ""
    set sensitivity ""
    set spouse ""
    set user_1 ""
    set user_2 ""
    set user_3 ""
    set user_4 ""
    set web_page ""

    # -------------------------------------------------------
    # Extract variables from the CSV file
    #

    set var_name_list [list]
    for {set j 0} {$j < $csv_header_len} {incr j} {

	set var_name [string trim [lindex $csv_header_fields $j]]
	if {"" == $var_name} {
	    # No variable name - probably an empty column
	    continue
	}

	set var_name [string tolower $var_name]
	set var_name [string map -nocase {" " "_" "'" "" "/" "_" "-" "_"} $var_name]
	lappend var_name_list $var_name
	ns_log notice "upload-companies-2: varname([lindex $csv_header_fields $j]) = $var_name"

	set var_value [string trim [lindex $csv_line_fields $j]]
	if {[string equal "NULL" $var_value]} { set var_value ""}
	
	set cmd "set $var_name \"$var_value\""
	ns_log Notice "upload-companies-2: cmd=$cmd"
	set result [eval $cmd]
    }

    # Set company name and path.
    # The path has anything strange replaced by "_".
    set company_name $company
    set company_path [im_mangle_user_group_name $company_name]

    set business_country_code [db_string country_code "select iso from country_codes where lower(country_name) = lower(:business_country)" -default ""]
    if {"" == $business_country_code} {
	append page_body "<li>Didn't find '$business_country' in the country database. Please enter manually.\n"
    }

    set office_name "$company_name [_ intranet-core.Main_Office]"
    set office_path "$company_path"

    # Check if the company already exists
    set found_n [db_string company_count "select count(*) from im_companies where lower(company_name) = lower(:company_name)"]

    # -------------------------------------------------------
    # Two or more companies with the same name
    # => Skip it completely
    if {$found_n > 1} {
	append page_body "<li>'$company_name': Skipping, we have found already $found_n companies with this name. Please check and change the names.\n"
	continue
    }

    # -------------------------------------------------------
    # Create a new company if necessary
    #
    if {0 == $found_n} {

	set company_id [im_new_object_id]
	

	# First create a new main_office:
	set main_office_id [office::new \
		-office_name	$office_name \
		-company_id     $company_id \
		-office_type_id [im_office_type_main] \
		-office_status_id [im_office_status_active] \
		-office_path	$office_path]

	# Now create the company with the new main_office:
	set company_id [company::new \
		-company_id $company_id \
		-company_name	$company_name \
		-company_path	$company_path \
		-main_office_id	$main_office_id \
		-company_type_id $company_type_id \
		-company_status_id [im_company_status_active]]	
    } else {

	db_1row company_info "
		select company_id, main_office_id
		from im_companies
		where lower(company_name) = lower(:company_name)
	"
    }

    # -----------------------------------------------------------------
    # Update the Office
    # -----------------------------------------------------------------

    set update_sql "
    update im_offices set
	office_name = :office_name,
	phone = :business_phone,
	fax = :business_fax,
	address_line1 = trim(:business_street),
	address_line2 = trim(:business_street_2 || ' ' || :business_street_3),
	address_city = :business_city,
	address_postal_code = :business_postal_code,
	address_country_code = :business_country_code
    where
	office_id = :main_office_id
"
    db_dml update_offices $update_sql

    # -------------------------------------------------------
    # Deal with the users's company
    #
    set user_id 0
    set users_n [db_string person_count "select count(*) from persons where lower(first_names) = lower(:first_name) and lower(last_name) = lower(:last_name)"]
    if {0 != $users_n} {

        set user_id [db_string person_select "select person_id from persons where lower(first_names) = lower(:first_name) and lower(last_name) = lower(:last_name)" -default 0]
        set relationship_count [db_string relationship_count "select count(*) from acs_rels where object_id_one = :company_id and object_id_two = :user_id"]
        if {0 == $relationship_count} {
    	append page_body "<li>'$first_name $last_name': Adding as member to '$company'\n"
        im_biz_object_add_role $user_id $company_id [im_biz_object_role_full_member]
        } else {
    	append page_body "<li>'$first_name $last_name': Is already a member of company '$company'\n"
        }

    } else {
    
        append page_body "<li>The user '$first_name $last_name' doesn't exist in our database. <br>
        Please use the 'Import Users CSV' link in the users page to upload a list of users.\n"
        
    }

    # -----------------------------------------------------------------
    # Update the Company
    # -----------------------------------------------------------------

    # get everything about the company
    db_1row company_info "
    	select * 
    	from im_companies 
    	where company_id = :company_id
    "

    if {$primary_contact_id == "" && $user_id != 0} {
    	db_dml update_company_prim_contact "
    		update im_companies
    		set primary_contact_id = :user_id
    		where company_id = :company_id
    	"
    }

    if {$accounting_contact_id == "" && $user_id != 0} {
    	db_dml update_company_acc_contact "
    		update im_companies
    		set accounting_contact_id = :user_id
    		where company_id = :company_id
    	"
    }

}

append page_body "\n</ul><p>\n<A HREF=$return_url>Return to Project Page</A>\n"
doc_return  200 text/html [im_return_template]
