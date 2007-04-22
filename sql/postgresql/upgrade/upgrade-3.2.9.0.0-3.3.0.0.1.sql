-- These are a couple of statements to clean up the existing PO database

-- Disabled for PO ?
delete from acs_reference_repositories where table_name = 'LANGUAGE_CODES';

create function inline_0() returns integer as '
declare
    rec        acs_reference_repositories%ROWTYPE;
begin
    for rec in select * from acs_reference_repositories where upper(table_name) like ''COUNTR%'' loop
         perform acs_reference__delete(rec.repository_id);
    end loop;
    return 0;
end;' language 'plpgsql';

select inline_0();
drop function inline_0();

drop table country_names cascade;

select acs_object_type__drop_type('acs_named_object','t');
drop table acs_named_objects cascade;
select acs_sc_contract__delete('AcsObject');
select acs_sc_msg_type__delete('AcsObject.PageUrl.InputType');
select acs_sc_msg_type__delete('AcsObject.PageUrl.OutputType');
select acs_sc_operation__delete('PageUrl','t') ;

-- This is for PO only

select acs_object_type__drop_type('postal_address','t') from dual;
drop table postal_addresses;
drop table postal_types;

