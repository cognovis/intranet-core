-- 
-- 
-- 
-- Copyright (c) 2013, cognovís GmbH, Hamburg, Germany
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- @author Malte Sussdorff (malte.sussdorff@cognovis.de)
-- @creation-date 2013-01-18
-- @cvs-id $Id$
--

SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-4.0.3.0.9-4.0.3.0.10.sql','');

-- Update Views with a label column
alter table im_views add column view_label varchar(1000);

update im_views set view_label = replace(view_name,'_',' ');

-- Add a new DynView Type for the invoice list page.
SELECT im_category_new ('1451', 'List - Project', 'Intranet DynView Type');

-- Update the existing list type
update im_views set view_type_id = 1451 where view_name = 'project_list';
update im_views set view_label = 'Project List' where view_name = 'project_list';

-- Add project revenue view
--
delete from im_view_columns where view_id = 1020;
delete from im_views where view_id = 1020;
--

insert into im_views (view_id, view_name, view_label, view_type_id)
values (1020, 'project_revenue', 'Project Revenue', 1451);

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for,variable_name,datatype) values (102001,1020,NULL,'#intranet-core.Project_nr#',
'"<A HREF=/intranet/projects/view?project_id=$project_id>$project_nr</A>"',
'','',5,'','project_nr','string');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for,variable_name,datatype) values (102002,1020,NULL,'#intranet-core.Project_Name#',
'"<A HREF=/intranet/projects/view?project_id=$project_id>$project_name</A>"',
'','',10,'','project_name','string');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for,variable_name,datatype) values (102003,1020,NULL,'#intranet-core.Client#',
'"<A HREF=/intranet/companies/view?company_id=$company_id>$company_name</A>"',
'','',15,'','company_name','string');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for,variable_name,datatype) values (102004,1020,NULL,'#intranet-core.Project_Manager#',
'"<A HREF=/intranet/users/view?user_id=$project_lead_id>$lead_name</A>"',
'','',20,'','lead_name','string');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_from, extra_where, sort_order, visible_for,variable_name,datatype) values (102005,1020,NULL,'#intranet-core.Client# #intranet-core.Invoice#',
'"$invoice_amount_formatted"',
'invoice_amount, to_char(invoice_amount,:cur_format) as invoice_amount_formatted','(select sum(amount) as invoice_amount, object_id_one from acs_rels r, im_costs where object_id_two = cost_id and cost_type_id = 3700 group by object_id_one) invoice','invoice.object_id_one = p.project_id',25,'','invoice_amount','currency');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_from, extra_where, sort_order, visible_for,variable_name,datatype) values (102006,1020,NULL,'#intranet-core.Provider# #intranet-core.Invoice#',
'"$provider_amount_formatted"',
'provider_amount, to_char(provider_amount,:cur_format) as provider_amount_formatted','im_projects p3 left outer join (select sum(amount) as provider_amount, object_id_one from acs_rels r, im_costs where object_id_two = cost_id and cost_type_id = 3704 group by object_id_one) bill on bill.object_id_one = p3.project_id','p3.project_id = p.project_id',30,'','invoice_amount','currency');

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_from, extra_where, sort_order, visible_for,variable_name,datatype) values (102007,1020,NULL,'#intranet-timesheet2.Hours#',
'"$hours"','hours','im_projects p2 left outer join (select sum(hours) as hours, project_id from im_hours group by project_id) h on h.project_id = p2.project_id','p2.project_id = p.project_id',35,'','hours','float');


