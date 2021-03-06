<% set page_title "V[string range [im_core_version] 0 5]" %>
<%= [im_header -loginpage $page_title] %>
<%= [im_navbar -loginpage "home"] %>


<%= 
    # Gather some information about the current system
    set ip_address "undefined"
    catch {set ip_address [exec /bin/bash -c "/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print \$1}'"]} ip_address

    set total_memory "undefined"
    catch {set total_memory [expr [exec /bin/bash -c "grep MemTotal /proc/meminfo | awk '{print \$2}'"] / 1024]} total_memory

    set url "<a href=\"http://$ip_address/\" target=_new>http://$ip_address/</a>\n"

    set debug ""
    set result ""
    set header_vars [ns_conn headers]
    for { set i 0 } { $i < [ns_set size $header_vars] } { incr i } {
	set key [ns_set key $header_vars $i]
	set val [ns_set value $header_vars $i]

	append debug "<tr><td>$key</td><td>$val</td></tr>\n"

	if {"Cookie" == $key} { continue }
	if {"Connection" == $key} { continue }
	if {"Cache-Control" == $key} { continue }
	if {"User-Agent" == $key} { continue }
	if {[regexp {^Accept} $key match]} { continue }
	append result "<tr><td>$key</td><td>$val</td></tr>\n"
    }
%>


<div id="slave">
<div id="fullwidth-list-no-side-bar" class="fullwidth-list-no-side-bar" style="visibility: visible;">

<table cellSpacing=2 cellPadding=2 width="100%" border=0>
<tr valign=top>

    <td valign=top width="50%">
        <table cellSpacing=1 cellPadding=1 border=0 width="100%">
        <tr>
          <td colspan=4 class=tableheader align=center><b>]po[ Demo Accounts</b></td>
        </tr>
        <tr>
          <td class="tableheader" align=center>Username</td>
          <td class="tableheader" align=center>Email</td>
          <td class="tableheader" align=center>Password</td>
        </tr>
        <multiple name=users>
          <if @users.rownum@ odd>
            <tr class="list-plain">
          </if> <else>
            <tr class="list-plain">
          </else>

          <td class="list-narrow">
                @users.user_name@
          </td>
          <td class="list-narrow">
                @users.email@
          </td>
          <td class="list-narrow">
                @users.demo_password@
          </td>
        </multiple>
        </table>

        <br>

	</td>
	<td valign=top width="50%">
	<table cellSpacing=1 cellPadding=1 border=0>
		<tr>
		<td class=tableheader><b>Intranet Login</b></td></tr>
		</tr>
		<tr>
		<td class=tablebody>
			<include src="/packages/acs-subsite/lib/login" return_url="@return_url;noquote@" no_frame_p="1" authority_id="@authority_id@" username="@username;noquote@" email="@email;noquote@" &="__adp_properties">
		</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!-- 
<table cellSpacing=0 cellPadding=5 width="100%" border=0>
  <tr><td>
	<br><br><br>
    Comments? Contact: 
    <A href="mailto:support@project-open.com">support@project-open.com</A>
  </td></tr>
</table>
--> 

</div>
</div>

<%= [im_footer] %>
