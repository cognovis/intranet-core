# /packages/intranet-core/www/master.tcl

if { ![info exists header_stuff] } { set header_stuff {} }
if { ![info exists title] } { set title {} }
if { ![info exists main_navbar_label] } { set main_navbar_label {} }
if { ![info exists sub_navbar] } { set sub_navbar {} }
if { ![info exists left_navbar] } { set left_navbar {} }
if { ![info exists show_left_navbar_p] } { set show_left_navbar_p 1 }
if { ![info exists show_context_help_p] } { set show_context_help_p 0 }

# ns_log Notice "master: show_left_navbar_p=$show_left_navbar_p"
# ns_log Notice "master: header_stuff=$header_stuff"

set show_navbar_p [parameter::get_from_package_key -package_key "intranet-core" -parameter "ShowLeftFunctionalMenupP" -default 0]

# Don't show navbar if explicitely disabled and for anonymous user (while logging in)
if {!$show_navbar_p && "" == [string trim $left_navbar]} { set show_left_navbar_p 0 }
if {0 == [ad_get_user_id]} { set show_left_navbar_p 0 }

# ----------------------------------------------------
# Admin Navbar
#
# Logic to show an Admin Navbar for OpenACS pages
# These pages don't explicitely set the Admin navbar.
# We want to show the Admin Navbar to create a unified
# feeling for SysAdmins.
#
if {"" == $sub_navbar} {
    # Get the current URL, split into pieces and remove first empty piece.
    set url [ns_conn url]
    set url_pieces [split $url "/"]
    set url_pieces [lrange $url_pieces 1 end]
    set url0 [lindex $url_pieces 0]
    set url1 [lindex $url_pieces 1]

    set label ""
    switch $url0 {

	acs-admin { 
	    switch $url1 {
		cache		{ set label "openacs_cache" }
		auth		{ set label "openacs_auth" }
		developer	{ set label "openacs_developer" }
		default		{ set label "openacs_developer" }
	    }
	}
	acs-lang { 
	    switch $url1 {
		default		{ set label "openacs_l10n" }
	    }
	}
	admin { 
	    switch $url1 {
		site-map	{ set label "openacs_sitemap" }
		default		{ set label "" }
	    }
	}
	api-doc			{ set label "openacs_api_doc" }
	ds { 
	    switch $url1 {
		shell		{ set label "openacs_shell" }
		default		{ set label "openacs_ds" }
	    }
	}
	intranet-exchange-rate	{ set label "admin_exchange_rates" }
	intranet-material	{ set label "material" }
	intranet-simple-survey	{ 
	    switch $url1 {
		admin		{ set label "admin_survsimp" }
		default		{ set label "" }
	    }
	}
	xowiki - documentation { 
	    set show_left_navbar_p 0
	}
    }

    if {"" != $label} {
	# Show a help link in the search bar
	set show_context_help_p 1
	set admin_navbar_label ""
	set parent_menu_id [im_menu_id_from_label "admin"]
	set sub_navbar [im_sub_navbar $parent_menu_id "" $title "pagedesriptionbar" $label]
    }
}

# OpenACS Feedback bar
if {[catch {
    set feedback_behaviour_key [im_feedback_set_user_messages]
    util_get_user_messages -multirow user_messages
} err_msg]} {
    global errorInfo
    ns_log Error "Error in master.tcl - im_feedback_set_user_messages failed with the following message: $err_msg \n $errorInfo "
    set feedback_behaviour_key 1
    set err_user_feedback "There was a problem retrieving user messages. This is probably a minor issue and can be disregarded. Please consult the error.log file for additional information. If this message persists, please logout and login again."
    set err_user_feedback [lang::message::lookup "" intranet-core.ErrorRetrievingUserMessage $err_user_feedback]
    template::multirow create user_messages message
    template::multirow append user_messages $err_user_feedback
}

# Feedback badge / used for demo servers
set show_feedback_p [parameter::get -package_id [apm_package_id_from_key intranet-core] -parameter "ShowFeedbackButton" -default 0]
if { $show_feedback_p } {
    template::head::add_css -href "/intranet/style/feedbackBadge.css" -media "screen" -order 1
    template::head::add_javascript -src "/intranet/js/jquery.feedbackBadge.min.js" -order 1
}
set feedback_url "<a href=\"[export_vars -base "/intranet/report-bug-on-page" {{page_url [im_url_with_query]}}]\" title='Give us feedback' id='feedback-badge-right' target='new'>"
append feedback_url "<span>[lang::message::lookup "" intranet-core.Feedback "Feedback"]</span></a>"
