-- upgrade-3.4.1.0.3-3.4.1.0.4.sql

SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-3.4.1.0.3-3.4.1.0.4.sql','');

SELECT im_lang_add_message('en_US','acs-workflow','Task_not_found','Task not found');
SELECT im_lang_add_message('en_US','acs-workflow','Task_not_found_message','This error can occur if a system administrator has deleted a workflow.<br>This situation should not occur during normal operations.<p>Please contact your System Administrator');
SELECT im_lang_add_message('en_US','intranet-audit','Earned_Value','Earned Value');
SELECT im_lang_add_message('en_US','intranet-core','Accounting_Contact','Accounting Contact');
SELECT im_lang_add_message('en_US','intranet-core','accounting_contact_id','Accounting Contact');
SELECT im_lang_add_message('en_US','intranet-core','Add_Portlet','Add Portlet');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Edit','Edit');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Name','Name');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Other','Other');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_ProjectNr','Project Nr');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Proof','Proof');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Source','Source');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Target','Target');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Trans','Trans');
SELECT im_lang_add_message('en_US','intranet-core','Ad_hoc_Units','Units');
SELECT im_lang_add_message('en_US','intranet-core','Airfare','Airfare');
SELECT im_lang_add_message('en_US','intranet-core','all','All');
SELECT im_lang_add_message('en_US','intranet-core','Armenia','Armenia');
SELECT im_lang_add_message('en_US','intranet-core','ARS','ARS');
SELECT im_lang_add_message('en_US','intranet-core','Assigning','Assigning');
SELECT im_lang_add_message('en_US','intranet-core','Audit_Trail_Absences','Audit Trail Absences');
SELECT im_lang_add_message('en_US','intranet-core','Audit_Trail_Offices','Audit Trail Offices');
SELECT im_lang_add_message('en_US','intranet-core','Audit_Trail_TS_Tasks','Audit Trail Timesheet Tasks');
SELECT im_lang_add_message('en_US','intranet-core','AvailableDays','Available Days');
SELECT im_lang_add_message('en_US','intranet-core','BT_Fix_for_Version','Fix for Version');
SELECT im_lang_add_message('en_US','intranet-core','BT_Found_in_Version','Found in Version');
SELECT im_lang_add_message('en_US','intranet-core','BT_Product','Product');
SELECT im_lang_add_message('en_US','intranet-core','Business_Sector','Business Sector');
SELECT im_lang_add_message('en_US','intranet-core','business_sector_id','Business Sector');
SELECT im_lang_add_message('en_US','intranet-core','Cant_reproduce','Can not reproduce');
SELECT im_lang_add_message('en_US','intranet-core','CapacityPlanning','Capacity Planning');
SELECT im_lang_add_message('en_US','intranet-core','Cayman_Islands','Cayman Islands');
SELECT im_lang_add_message('en_US','intranet-core','Companies_Filestorage_Component','Company Filestorage Component');
SELECT im_lang_add_message('en_US','intranet-core','Companies_Forum_Component','Company Forum Component');
SELECT im_lang_add_message('en_US','intranet-core','Company_Cost_Component','Company Cost Component');
SELECT im_lang_add_message('en_US','intranet-core','company_group_id','Company Group');
SELECT im_lang_add_message('en_US','intranet-core','company_name','Company Name');
SELECT im_lang_add_message('en_US','intranet-core','Company_Offices','Company Offices');
SELECT im_lang_add_message('en_US','intranet-core','company_path','Company path');
SELECT im_lang_add_message('en_US','intranet-core','Company_Project_Nr_Help','The customer''s reference to this project. This number will appear in invoices of this project.');
SELECT im_lang_add_message('en_US','intranet-core','company_status_id','Company Status');
SELECT im_lang_add_message('en_US','intranet-core','Company_Timesheet_Prices','Company Timesheet Prices');
SELECT im_lang_add_message('en_US','intranet-core','company_type_id','Company Type');
SELECT im_lang_add_message('en_US','intranet-core','Configuring_po','Configuring ]po[');
SELECT im_lang_add_message('en_US','intranet-core','confirm_date','Confirm Date');
SELECT im_lang_add_message('en_US','intranet-core','Confirm_Date','Confirm Date');
SELECT im_lang_add_message('en_US','intranet-core','Construction','Construction');
SELECT im_lang_add_message('en_US','intranet-core','Copies','Copies');
SELECT im_lang_add_message('en_US','intranet-core','Customer_Management','Customer Management');
SELECT im_lang_add_message('en_US','intranet-core','default_payment_days','Default Payment Days');
SELECT im_lang_add_message('en_US','intranet-core','Default_Payment_Days','Default Payment Days');
SELECT im_lang_add_message('en_US','intranet-core','Default_PO_Template','Default Template');
SELECT im_lang_add_message('en_US','intranet-core','default_vat','Default VAT');
SELECT im_lang_add_message('en_US','intranet-core','Default_VAT','Default VAT');
SELECT im_lang_add_message('en_US','intranet-core','Department','Department');
SELECT im_lang_add_message('en_US','intranet-core','Duplicate','Duplicate');
SELECT im_lang_add_message('en_US','intranet-core','Earned_Value','Earned Value');
SELECT im_lang_add_message('en_US','intranet-core','Engineering','Engineering');
SELECT im_lang_add_message('en_US','intranet-core','Executing','Executing');
SELECT im_lang_add_message('en_US','intranet-core','Export_Customer_Invoices_CSV','Export Customer Financial Documents CSV');
SELECT im_lang_add_message('en_US','intranet-core','Export_Provider_Invoices_CSV','Export Provider Financial Documents CSV');
SELECT im_lang_add_message('en_US','intranet-core','File','File');
SELECT im_lang_add_message('en_US','intranet-core','Filestorage','Filestorage');
SELECT im_lang_add_message('en_US','intranet-core','Financial_Consulting','Financial Controlling');
SELECT im_lang_add_message('en_US','intranet-core','Financial_Management','Financial Management');
SELECT im_lang_add_message('en_US','intranet-core','Fuel','Fuel');
SELECT im_lang_add_message('en_US','intranet-core','General_Consulting','General Consulting');
SELECT im_lang_add_message('en_US','intranet-core','Group','Group');
SELECT im_lang_add_message('en_US','intranet-core','Home_State','Home State');
SELECT im_lang_add_message('en_US','intranet-core','Hotel','Hotel');
SELECT im_lang_add_message('en_US','intranet-core','In_review','In Review');
SELECT im_lang_add_message('en_US','intranet-core','InterCo_Invoice','InterCo Invoice');
SELECT im_lang_add_message('en_US','intranet-core','InterCo_Quote','IterCo Quote');
SELECT im_lang_add_message('en_US','intranet-core','Project_Managers','Project Managers');
SELECT im_lang_add_message('en_US','intranet-core','Project_Type','Project Type');
SELECT im_lang_add_message('en_US','intranet-core','Invalid','Invalid');
SELECT im_lang_add_message('en_US','intranet-core','Invalid_Since','Invalid Since');
SELECT im_lang_add_message('en_US','intranet-core','Invoicing','Invoicing');
SELECT im_lang_add_message('en_US','intranet-core','Journal','Journal');
SELECT im_lang_add_message('en_US','intranet-core','Km_own_car','Km. own car');
SELECT im_lang_add_message('en_US','intranet-core','Knowledge_Management','Knowledge Management');
SELECT im_lang_add_message('en_US','intranet-core','Korea_Republic_Of','Kora, Republic of');
SELECT im_lang_add_message('en_US','intranet-core','Last_3_Weeks','Last 3 Weeks');
SELECT im_lang_add_message('en_US','intranet-core','Legal','Legal');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Input_Device','Input Device');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Network_Devi','Network Device');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Printer_Driv','Printer Driver');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Software_Pac','Software Package');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Sound_Device','Sound Device');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Storage_Devi','Storage Device');
SELECT im_lang_add_message('en_US','intranet-core','lt_Computer_Video_Device','Video Device');
SELECT im_lang_add_message('en_US','intranet-core','lt_Customer_Satisfaction','Customer Satisfaction');
SELECT im_lang_add_message('en_US','intranet-core','lt_Default_Delivery_Note','Default Delivery Note');
SELECT im_lang_add_message('en_US','intranet-core','lt_Default_Invoice_Templ','Default Invoice Template');
SELECT im_lang_add_message('en_US','intranet-core','lt_Default_Payment_Metho','Default Payment Method');
SELECT im_lang_add_message('en_US','intranet-core','lt_Default_Provider_Bill','Default Provider Bill');
SELECT im_lang_add_message('en_US','intranet-core','lt_Desired_Customer_End_','Desired Customer End Date');
SELECT im_lang_add_message('en_US','intranet-core','lt_Freelance_Bank_Accoun','Freelance Bank Account');
SELECT im_lang_add_message('en_US','intranet-core','lt_Human_Resources_Manag','Human Resources Manager');
SELECT im_lang_add_message('en_US','intranet-core','lt_OCS_Software_Componen','OCS Software Component');
SELECT im_lang_add_message('en_US','intranet-core','Mail_Import','Mail Import');
SELECT im_lang_add_message('en_US','intranet-core','main_office_id','Main Office');
SELECT im_lang_add_message('en_US','intranet-core','Meals','Meals');
SELECT im_lang_add_message('en_US','intranet-core','Modifying','Modifying');
SELECT im_lang_add_message('en_US','intranet-core','Nagios_Alert','Nagios Alert');
SELECT im_lang_add_message('en_US','intranet-core','Nepal','Nepal');
SELECT im_lang_add_message('en_US','intranet-core','Netherlands_Antilles','Netherlands Antilles');
SELECT im_lang_add_message('en_US','intranet-core','New_Customer_Invoice_from_scratch','New Customer Invoice From Scratch');
SELECT im_lang_add_message('en_US','intranet-core','New_Customer_Invoice_from_Timesheet_Tasks','New Customer Invoice From Timesheet Tasks');
SELECT im_lang_add_message('en_US','intranet-core','New_Provider_Bill_from_scratch','New Provider Bill From Scratch');
SELECT im_lang_add_message('en_US','intranet-core','New_Purchase_Order_from_scratch','New Purchase Order From Scratch');
SELECT im_lang_add_message('en_US','intranet-core','New_Quote_from_scratch','New Quote From Scratch');
SELECT im_lang_add_message('en_US','intranet-core','New_Quote_from_Timesheet_Tasks','New Quote From Timesheet Tasks');
SELECT im_lang_add_message('en_US','intranet-core','Next_3_months','Next 3 Months');
SELECT im_lang_add_message('en_US','intranet-core','Next_3_Weeks','Next 3 Weeks');
SELECT im_lang_add_message('en_US','intranet-core','Office_Material','Office Material');
SELECT im_lang_add_message('en_US','intranet-core','Outdated','Outdated');
SELECT im_lang_add_message('en_US','intranet-core','Package_Not_Available','Package Not Available');
SELECT im_lang_add_message('en_US','intranet-core','Panama','Panama');
SELECT im_lang_add_message('en_US','intranet-core','Parking','Parking');
SELECT im_lang_add_message('en_US','intranet-core','Permission_Request','Permission Request');
SELECT im_lang_add_message('en_US','intranet-core','PlannedTotal','Planned Total');
SELECT im_lang_add_message('en_US','intranet-core','presales_value','Presales Value');
SELECT im_lang_add_message('en_US','intranet-core','Primary_Contact','Primary Contact');
SELECT im_lang_add_message('en_US','intranet-core','primary_contact_id','Primary Contact');
SELECT im_lang_add_message('en_US','intranet-core','Process','Process');
SELECT im_lang_add_message('en_US','intranet-core','Profit_amp_Loss','Profit & Loss');
SELECT im_lang_add_message('en_US','intranet-core','program_id','Program');
SELECT im_lang_add_message('en_US','intranet-core','Project_Reports','Project Reports');
SELECT im_lang_add_message('en_US','intranet-core','Project_Request','Project Request');
SELECT im_lang_add_message('en_US','intranet-core','Provider_Receipt','Provider Receipt');
SELECT im_lang_add_message('en_US','intranet-core','Release_Item','Release Item');
SELECT im_lang_add_message('en_US','intranet-core','Re-Open','Re-Open');
SELECT im_lang_add_message('en_US','intranet-core','Reset_Portlets','Reset Portlets');
SELECT im_lang_add_message('en_US','intranet-core','Resolved','Resolved');
SELECT im_lang_add_message('en_US','intranet-core','Resource_Planning','Resource Planning');
SELECT im_lang_add_message('en_US','intranet-core','Senior_Manager','Senior Manager');
SELECT im_lang_add_message('en_US','intranet-core','Senior_managers','Senior Managers');
SELECT im_lang_add_message('en_US','intranet-core','SLA_Request','SLA Request');
SELECT im_lang_add_message('en_US','intranet-core','Specs','Specs');
SELECT im_lang_add_message('en_US','intranet-core','Super_Project','Super Project');
SELECT im_lang_add_message('en_US','intranet-core','System_Usage','System Usage');
SELECT im_lang_add_message('en_US','intranet-core','Task_Dependencies','Task Dependencies');
SELECT im_lang_add_message('en_US','intranet-core','Task_Resources','Task Resources');
SELECT im_lang_add_message('en_US','intranet-core','Taxi','Taxi');
SELECT im_lang_add_message('en_US','intranet-core','Telephone','Telephone');
SELECT im_lang_add_message('en_US','intranet-core','Timesheet_Management','Timesheet Management');
SELECT im_lang_add_message('en_US','intranet-core','Timesheet_Task','Timesheet Task');
SELECT im_lang_add_message('en_US','intranet-core','Tolls','Tolls');
SELECT im_lang_add_message('en_US','intranet-core','Trados_7x','Tradox 7.x');
SELECT im_lang_add_message('en_US','intranet-core','Train','Train');
SELECT im_lang_add_message('en_US','intranet-core','Training_Request','Training Request');
SELECT im_lang_add_message('en_US','intranet-core','Wont_fix','Won''t fix');
SELECT im_lang_add_message('en_US','intranet-core','Workload','Workload');
SELECT im_lang_add_message('en_US','intranet-core','Workplace_Move_Request','Workplace Move Request');
SELECT im_lang_add_message('en_US','intranet-core','Work_State','Work State');
SELECT im_lang_add_message('en_US','intranet-core','Year','Year');
SELECT im_lang_add_message('en_US','intranet-cost','Amount_without_VAT','Amount without VAT');
SELECT im_lang_add_message('en_US','intranet-cost','Manager','Manager');
SELECT im_lang_add_message('en_US','intranet-expenses','Company_Visa_1','Company Visa 1');
SELECT im_lang_add_message('en_US','intranet-expenses','Company_Visa_2','Company Visa 2');
SELECT im_lang_add_message('en_US','intranet-expenses','Expense_Bundle','Expense Bundle');
SELECT im_lang_add_message('en_US','intranet-expenses','Included_Expenses','Included Expenses');
SELECT im_lang_add_message('en_US','intranet-expenses','Modify_Included_Expenses','Modify Included Expenses');
SELECT im_lang_add_message('en_US','intranet-expenses','Negative_amount_not_allowed','Negative amounts not allowed');
SELECT im_lang_add_message('en_US','intranet-expenses','No','No');
SELECT im_lang_add_message('en_US','intranet-expenses','--_Select_--','-- Select --');
SELECT im_lang_add_message('en_US','intranet-expenses','Yes','Yes');
SELECT im_lang_add_message('en_US','intranet-filestorage','Upload_ZIP','Upload ZIP');
SELECT im_lang_add_message('en_US','intranet-forum','Name','Name');
SELECT im_lang_add_message('en_US','intranet-forum','Needs_Clarify','Needs Clarification');
SELECT im_lang_add_message('en_US','intranet-forum','New_topic_in_object','New Topic');
SELECT im_lang_add_message('en_US','intranet-forum','Reply_to_topic','Reply to topic');
SELECT im_lang_add_message('en_US','intranet-forum','Select_users_to_notify','Select users to notify');
SELECT im_lang_add_message('en_US','intranet-forum','Send_Email','Send Email');
SELECT im_lang_add_message('en_US','intranet-forum','Send_Forum_Notifications','Send Forum Notifications');
SELECT im_lang_add_message('en_US','intranet-forum','Very_Urgent','Very Urgent');
SELECT im_lang_add_message('en_US','intranet-freelance-rfqs','Freelance_RFQ','Freelance RFQ');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Delete_and_Reassign','Delete and Reassign');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Delete_Gantt_Tasks','Delete Gantt Tasks');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Delete_selected_tasks','Delete selected tasks');
SELECT im_lang_add_message('en_US','intranet-ganttproject','GanttProject','GanttProject');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Import_Gantt_Tasks','Import Gantt Tasks');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Please_Note','Please Note');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Reassign_Resources_To','Reassign Resources To');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Resource_Title','Resource Title');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Software','Software');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Task_Name','Task Name');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Task_Nr','Task Nr');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Upload','Upload');
SELECT im_lang_add_message('en_US','intranet-ganttproject','Upload_GanttProject_or_OpenProj_File','Upload GanttProject or OpenProj File');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Action_Forbidden','Action Forbidden');
SELECT im_lang_add_message('en_US','intranet-helpdesk','A_SLA_is_required','A SLA is required');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Change Ticket_Management','Change Ticket Management');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Comment','Comment');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Deleted_by_user','Deleted by user');
SELECT im_lang_add_message('en_US','intranet-helpdesk','No_Ticket_Found','No Ticket Found');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Please_Select_Ticket_Properties','Please Select Ticket Properties');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Request_SLA','Request SLA');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Submit','Submit');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Ticket_Journal','Ticket Journal');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Ticket_Timesheet','Ticket Timesheet');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Ticket_Workflow','Ticket Workflow');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Workflow_Finished','Workflow Finished');
SELECT im_lang_add_message('en_US','intranet-helpdesk','Your_Company','Your Company');
SELECT im_lang_add_message('en_US','intranet-hr','Vacation_Balance','Vacation Balance');
SELECT im_lang_add_message('en_US','intranet-hr','Vacation_Days_Per_Year','Vacation Days Per Year');
SELECT im_lang_add_message('en_US','intranet-invoices','Customer_Documents','Customer Financial Documents');
SELECT im_lang_add_message('en_US','intranet-invoices','Customer_Invoice','Customer Invoice');
SELECT im_lang_add_message('en_US','intranet-invoices','General_Manager','General Manager');
SELECT im_lang_add_message('en_US','intranet-invoices','Provider_Bill','Provider Bill');
SELECT im_lang_add_message('en_US','intranet-invoices','Purchase_Order','Purchase Order');
SELECT im_lang_add_message('en_US','intranet-invoices','Quote','Quote');
SELECT im_lang_add_message('en_US','intranet-invoices','Send_document_as_PDF_attachment','Send document as PDF attachment');
SELECT im_lang_add_message('en_US','intranet-invoices','Show_Included_Timesheet_Hours','Show included timesheet hours');
SELECT im_lang_add_message('en_US','intranet-milestone','Customer','Customer');
SELECT im_lang_add_message('en_US','intranet-milestone','Project_Manager','Project Manager');
SELECT im_lang_add_message('en_US','intranet-reporting-dashboard','Click_for_help','Click for help');
SELECT im_lang_add_message('en_US','intranet-reporting-dashboard','Dashboard','Dashboard');
SELECT im_lang_add_message('en_US','intranet-reporting','Description','Descriptioin');
SELECT im_lang_add_message('en_US','intranet-reporting','Financial_Cube','Financial Cube');
SELECT im_lang_add_message('en_US','intranet-reporting','Financial_Cube_for','Financial Cube for');
SELECT im_lang_add_message('en_US','intranet-reporting','Format','Format');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Code','Indicator Code');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_High_Critical','High Critical');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_High_Warning','High Warning');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Low_Critical','Low Critical');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Low_Warning','Low Warning');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Name','Indicator Name');
SELECT im_lang_add_message('en_US','intranet-reporting','Indicator_Section','Indicator Section');
SELECT im_lang_add_message('en_US','intranet-reporting','New_Indicator','New Indicator');
SELECT im_lang_add_message('en_US','intranet-reporting','Number_Format','Number Format');
SELECT im_lang_add_message('en_US','intranet-reporting','Object_Audi_Cube','Object Audit Cube');
SELECT im_lang_add_message('en_US','intranet-reporting','Program_and_Portfolio','Program and Portfolio');
SELECT im_lang_add_message('en_US','intranet-reporting','Program_Earned_Value_Analysis','Earned Value Analysis');
SELECT im_lang_add_message('en_US','intranet-reporting','Program_EVA','EVA');
SELECT im_lang_add_message('en_US','intranet-reporting','Project_Management','Project Management');
SELECT im_lang_add_message('en_US','intranet-reporting','Report_Options','Report Options');
SELECT im_lang_add_message('en_US','intranet-reporting','REST_Category_Type','REST Category Type');
SELECT im_lang_add_message('en_US','intranet-reporting','REST_My_Hours','REST My Hours');
SELECT im_lang_add_message('en_US','intranet-reporting','REST_My_Timesheet_Projects','REST My Timesheet Projects');
SELECT im_lang_add_message('en_US','intranet-reporting','Timesheet_Cube','Timesheet Cube');
SELECT im_lang_add_message('en_US','intranet-simple-survey','One_Response','One Response');
SELECT im_lang_add_message('en_US','intranet-simple-survey','Project_Reports','Project Reports');
SELECT im_lang_add_message('en_US','intranet-simple-survey','Survey','Survey');
SELECT im_lang_add_message('en_US','intranet-simple-survey','Week','Week');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Absence_absence_type','Absence Type');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Absence_Duplicate_Start','Duplicate Start');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Absences_for_user','Absences for user');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Apr','Apr');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Capacity','Capacity');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Color_codes','Color Codes');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Day_of_week_Sat','Sat');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Day_of_week_Sun','Sun');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Jul','Jul');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Log_hours_for_the_week','Log hours for the week');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Only_positive_numbers_allowed','Only positive numbers allowed');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Reassign_logged_hours','Reassign logged hours');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','Bll','Bll');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','Lg','Lg');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','Pln','Pln');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','These_tasks_depend_on','These tasks depend on ');
SELECT im_lang_add_message('en_US','intranet-timesheet2-tasks','This_task_depends_on','This task depends on');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Time_Period','Time Period');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Training','Training');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Vacation_Balance','Vacation Balance');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Vacation_Balance_From_Last_Year','Vacation Balance From Last Year');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Vacation_Days_per_Year','Vacation Days Per Year');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Vacation_Left_for_Period','Vacation Left For Period');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Vacation_Taken_This_Year','Vacation Taken This Year');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Valid_for_Group','Valid For Group');
SELECT im_lang_add_message('en_US','intranet-timesheet2','Workdays','Workdays');
SELECT im_lang_add_message('en_US','intranet-trans-invoices','File_Type','File Type');
SELECT im_lang_add_message('en_US','intranet-translation','Create_Language_Subprojects','Create Subprojects For Each Language');
SELECT im_lang_add_message('en_US','intranet-translation','File_is_being_edited_by_other','The file is being edited by another person');
SELECT im_lang_add_message('en_US','intranet-translation','File_is_ready_to_be_edited_by_other','The file is ready to be edited by another person');
SELECT im_lang_add_message('en_US','intranet-translation','File_is_ready_to_be_proofed_by_other','The file is ready to be proofed by another person');
SELECT im_lang_add_message('en_US','intranet-translation','Please_download_the_edited_file','Please download the edited file');
SELECT im_lang_add_message('en_US','intranet-translation','Please_download_the_source_file','Please download the source file');
SELECT im_lang_add_message('en_US','intranet-translation','Please_download_the_translated_file','Please download the translated file');
SELECT im_lang_add_message('en_US','intranet-translation','Please_upload_the_edited_file','Please upload the edited file');
SELECT im_lang_add_message('en_US','intranet-translation','Please_upload_the_proofed_file','Please upload the proofed file');
SELECT im_lang_add_message('en_US','intranet-translation','Please_upload_the_translated_file','Please upload the translated file');
SELECT im_lang_add_message('en_US','intranet-translation','Submit_Changes','Submit Changes');
SELECT im_lang_add_message('en_US','intranet-translation','The_file_is_ready_to_be_trans_by_other','The file is ready to be translated by another person');
SELECT im_lang_add_message('en_US','intranet-translation','The_file_is_trans_by_another_person','The file is being translated by another person');
SELECT im_lang_add_message('en_US','intranet-translation','You_are_allowed_to_upload_again','You are allowed to upload the file again');
SELECT im_lang_add_message('en_US','intranet-translation','You_are_the_admin','You are the System Administrator...');
SELECT im_lang_add_message('en_US','intranet-translation','You_can_upload_again_while_proof_reader_hasnt_started','You are allowed to upload the file again while the Proof Reader has not started editing yet');
SELECT im_lang_add_message('en_US','intranet-trans-quality','Trans_Quality','Translation Quality');
SELECT im_lang_add_message('en_US','intranet-workflow','Action_Canceled','Action Canceled');
SELECT im_lang_add_message('en_US','intranet-workflow','Action_Performed','Action Performed');
SELECT im_lang_add_message('en_US','intranet-workflow','Back_to_last_page','Back to last page');
SELECT im_lang_add_message('en_US','intranet-workflow','Cancel_Button','Cancel');
SELECT im_lang_add_message('en_US','intranet-workflow','Confirm_Button','Confirm');
SELECT im_lang_add_message('en_US','intranet-workflow','Resource_Assignment','Resource Assignment');
SELECT im_lang_add_message('en_US','intrant-ganttproject','No_resource_assignments_found','No resource assignments found');

