# /packages/intranet-core/www/admin/profiles/index.tcl
#
# Copyright (C) 1998-2004 various parties
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
    Permissions for the subsite itself.
    
    @author Lars Pind (lars@collaboraid.biz)
    @author Frank Bergmann (frank.bergmann@project-open.com)
}

set page_title "Profiles"
set context [list "Permissions"]

set subsite_id [ad_conn subsite_id]
set context_bar [im_context_bar $page_title]
set url_stub [im_url_with_query]

# The list of Core privileges
set privs [im_core_privs]
# set privs { add_users }

# Flush the permission cache to make changes active.
# Putting this command here may cause too many flush
# actions to be performed (because it is activated
# when only viewing permission), but otherwise we would
# have to modify /permissions/perm-modify...
im_permission_flush