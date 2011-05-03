-- upgrade-3.5.0.0.0-3.5.0.1.0.sql

SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-3.5.0.0.0-3.5.0.1.0.sql','');

SELECT im_lang_add_message('en_US','intranet-core','Show_more','Show more');
SELECT im_lang_add_message('en_US','intranet-core','DelDemo_Please_backup','Please Backup');
SELECT im_lang_add_message('en_US','bug-tracker','Related_Files','Related Files');
SELECT im_lang_add_message('en_US','calendar','Pers_Cal_Name','Personal Calendar Name');
SELECT im_lang_add_message('en_US','intranet-confdb','No_Conf_Items_Found','No Configuration Items Found');
SELECT im_lang_add_message('en_US','intranet-contacts','Contacts','Contacts');
SELECT im_lang_add_message('en_US','intranet-core','CHF','CHF');
SELECT im_lang_add_message('en_US','intranet-core','Associated_with_new_Object','Associated with new Object');
SELECT im_lang_add_message('en_US','intranet-core','Browser_Warning','Browser Warning');
SELECT im_lang_add_message('en_US','intranet-core','Browser_Warning_Msg','Your browser '%browser% %version_major%.x' may not render all pages correctly with this version of %po%.<br>We recommend you to upgrade your browser to a more recent version.');
SELECT im_lang_add_message('en_US','intranet-core','BtnSaveUpdate','Save/Update');
SELECT im_lang_add_message('en_US','intranet-core','Category_Types','Category Types');
SELECT im_lang_add_message('en_US','intranet-core','Cat_Type','Category Type');
SELECT im_lang_add_message('en_US','intranet-core','Company_Wiki_Component','Company Wiki');
SELECT im_lang_add_message('en_US','intranet-core','DelDemo_Delete_Individual_objects','Delete Individual Objects');
SELECT im_lang_add_message('en_US','intranet-core','DelDemo_Nuke_all_demo_data','Nuke All Demo Data');
SELECT im_lang_add_message('en_US','intranet-core','DelDemo_Nuke_Demo_Companies','Nuke Demo Companies');
SELECT im_lang_add_message('en_US','intranet-core','DelDemo_Nuke_Demo_Projects','Nuke Demo Projects');
SELECT im_lang_add_message('en_US','intranet-core','DelDemoNuke_Demo_Users2','Nuke Demo Users');
SELECT im_lang_add_message('en_US','intranet-core','Exchange_Rates_ASUS','Exchange Rates ASUS');
SELECT im_lang_add_message('en_US','intranet-core','Filter_Bugs','Filter Bugs');
SELECT im_lang_add_message('en_US','intranet-core','Filter_Categories','Filter Categories');
SELECT im_lang_add_message('en_US','intranet-core','Filter_Status','Filter Status');
SELECT im_lang_add_message('en_US','intranet-core','GBP','GBP');
SELECT im_lang_add_message('en_US','intranet-core','Importing_Master_Data_message','Please <a href=/intranet/admin/cleanup-demo/>remove</a> the Tigerpond demo data from the system. After that, you can start to enter your company data in the order users (employees, customers and freelancers), companies (customers and providers) and projects.');
SELECT im_lang_add_message('en_US','intranet-core','intranet-core','Project_Managers','Project Managers');
SELECT im_lang_add_message('en_US','intranet-core','intranet-core','Project_Type','Project Type');
SELECT im_lang_add_message('en_US','intranet-core','Invalid_Object','Invalid Object');
SELECT im_lang_add_message('en_US','intranet-core','Invoiced_Status','Invoice Status');
SELECT im_lang_add_message('en_US','intranet-core','LoadTotal','Load Total');
SELECT im_lang_add_message('en_US','intranet-core','Member_state_deleted','deleted');
SELECT im_lang_add_message('en_US','intranet-core','MS-Excel','MS-Excel');
SELECT im_lang_add_message('en_US','intranet-core','MS-PowerPoint','MS-PowerPoint');
SELECT im_lang_add_message('en_US','intranet-core','MS-Word','MS-Word');
SELECT im_lang_add_message('en_US','intranet-core','Not_all_results_have_been_shown','Not all results have been shown');
SELECT im_lang_add_message('en_US','intranet-core','Office_Wiki_Component','Office Wiki');
SELECT im_lang_add_message('en_US','intranet-core','One_Category_Type','One Category Type');
SELECT im_lang_add_message('en_US','intranet-core','Only_invoiced_hours','Only invoiced hours');
SELECT im_lang_add_message('en_US','intranet-core','Project_Gantt_Resource_Summary','Project Gantt Resource Summary');
SELECT im_lang_add_message('en_US','intranet-core','Project_Gantt_Scheduling_Summary','Project Gantt Scheduling Summary');
SELECT im_lang_add_message('en_US','intranet-core','Project_type_Program','Program');
SELECT im_lang_add_message('en_US','intranet-core','Related_Objects','Related Objects');
SELECT im_lang_add_message('en_US','intranet-core','Related_Objects_for_object','Related objects for object');
SELECT im_lang_add_message('en_US','intranet-core','Title','Title');
SELECT im_lang_add_message('en_US','intranet-core','User_Related_Objects','User Related Objects');
SELECT im_lang_add_message('en_US','intranet-core','WorkdaysTotal','Workdays Total');
SELECT im_lang_add_message('en_US','intranet-core','Workplace_move_Request','Workplace Move Request');
SELECT im_lang_add_message('en_US','intranet-cost','Employees','Employees');
SELECT im_lang_add_message('en_US','intranet-exchange-rate','Active_currencies','Active Currencies');
SELECT im_lang_add_message('en_US','intranet-exchange-rate','Admin_Links','Admin Links');
SELECT im_lang_add_message('en_US','intranet-exchange-rate','Button_Get_Exchange_Rates','Get Exchange Rates');
SELECT im_lang_add_message('en_US','intranet-exchange-rate','Filter_Rates','Filter Rates');
SELECT im_lang_add_message('en_US','intranet-exchange-rate','Get_exchange_rates_for_today','Get exchange rates for today');
SELECT im_lang_add_message('en_US','intranet-expenes','Unassigned','Unassigned');
SELECT im_lang_add_message('en_US','intranet-expenses','Assign_to_a_project','Assign to a project');
SELECT im_lang_add_message('en_US','intranet-expenses','Create_Bundle','Create Bundle');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Associate','Associate');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Contact_Email_Tel','Contact Email Tel');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Delete_Rel','Delete Rel');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Direction','Direction');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Incident Ticket_Management','Incident Ticket Management');
SELECT im_lang_add_message('en_US','intranet-helpdesk','lt_Workplace_move_Reques','Workplace Move Request');
SELECT im_lang_add_message('en_US','intranet-helpdesk','New_Change Ticket_Ticket','New Change Ticket');
SELECT im_lang_add_message('en_US','intranet-helpdesk','New_Incident Ticket_Ticket','New Incident Ticket');
SELECT im_lang_add_message('en_US','intranet-helpdesk','New_Problem Ticket_Ticket','New Problem Ticket');
SELECT im_lang_add_message('en_US','intranet-helpdesk','No_SLA_associated_with_you','No Service Level Agreement (SLA) for you');
SELECT im_lang_add_message('en_US','intranet-helpdesk','No_SLAs_for_customer','No Service Level Agreement (SLA) for customer');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Object_Name','Object Name');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Object_Type','Object Type');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Problem Ticket_Management','Problem Ticket Management');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Relationship_Type','Relationship Type');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Rel_im_biz_object_member','Object Member');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Rel_im_company_employee_rel','Employee Rel');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Rel_im_key_account_rel','Key Account Rel');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Ticket_type_Workplace_move_Request','Workplace Move Request');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Waiting_for_Other','Waiting for Other');
SELECT im_lang_add_message('en_US','intranet-hr','lt_Vacation_Balance_From','Vacation Balance From');
SELECT im_lang_add_message('en_US','intranet-hr','lt_Vacation_Days_per_Yea','Vacation Days per Year');
SELECT im_lang_add_message('en_US','intranet-invoices','Canned_Note','Canned Note');
SELECT im_lang_add_message('en_US','intranet-invoices','Preview_using_template','Preview Using Template');
SELECT im_lang_add_message('en_US','intranet-notes','Delete','Delete');
SELECT im_lang_add_message('en_US','intranet-notes','Filter_Notes','Filter Notes');
SELECT im_lang_add_message('en_US','intranet-notes','Note_CreationUser','Creation User');
SELECT im_lang_add_message('en_US','intranet-notes','Note_Date','Date');
SELECT im_lang_add_message('en_US','intranet-notes','Note_Note','Note');
SELECT im_lang_add_message('en_US','intranet-notes','Note_Object','Object');
SELECT im_lang_add_message('en_US','intranet-notes','Notes','Notes');
SELECT im_lang_add_message('en_US','intranet-notes','Notes_Items','Items');
SELECT im_lang_add_message('en_US','intranet-notes','Remove_checked_items','Remove Checked Items');
SELECT im_lang_add_message('en_US','intranet-reporting-indicators','More_dots','...');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Widget_Max','Indicator Widget May');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Widget_Min','Indicator Widget Min');
SELECT im_lang_add_message('en_US','intranet-reporting','Recent_Registrations','Recent Registrations');
SELECT im_lang_add_message('en_US','intranet-reporting','Reports_Object_Type','Object Type');
SELECT im_lang_add_message('en_US','intranet-reporting','Show_all_project_tasks','Show all project tasks');
SELECT im_lang_add_message('en_US','intranet-timesheet2','DaysPlanned','Days Planned');
SELECT im_lang_add_message('en_US','intranet-timesheet2','for_username','for username');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Logging_hours_has_been_closed','Logging hours has been closed');
SELECT im_lang_add_message('en_US','intranet-timesheet2','OtherAbsences','Other Absences');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','CC','CC');
SELECT im_lang_add_message('en_US','intranet-timesheet2','TotalAbsences','Total Absences');
SELECT im_lang_add_message('en_US','intranet-wiki','Office_Wiki','Office Wiki');
SELECT im_lang_add_message('en_US','intrant-ganttproject','No_resource_assignments_found','No resource assignments found');

