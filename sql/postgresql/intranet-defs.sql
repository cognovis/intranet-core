-- /packages/intranet/sql/postgres/intranet-defs.sql
--
-- Copyright (C) 1999-2004 various parties
-- The code is based on ArsDigita ACS 3.4
--
-- This program is free software. You can redistribute it
-- and/or modify it under the terms of the GNU General
-- Public License as published by the Free Software Foundation;
-- either version 2 of the License, or (at your option)
-- any later version. This program is distributed in the
-- hope that it will be useful, but WITHOUT ANY WARRANTY;
-- without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU General Public License for more details.
--
-- @author      frank.bergmann@project-open.com


-- Populate all the status/type/url with the different types of 
-- data we are collecting



-- added
select define_function_args('im_first_letter_default_to_a','string');

--
-- procedure im_first_letter_default_to_a/1
--
CREATE OR REPLACE FUNCTION im_first_letter_default_to_a(
   p_string varchar
) RETURNS char AS $$
DECLARE
	v_initial	char(1);
BEGIN
	v_initial := substr(upper(p_string),1,1);

	IF v_initial IN (
		'A','B','C','D','E','F','G','H','I','J','K','L','M',
		'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	) THEN
		RETURN v_initial;
	END IF;
	
	RETURN 'A';
END;
$$ LANGUAGE plpgsql;



-- -----------------------------------------------------------
-- We base our financial information, allocations, etc. around
-- a fundamental unit or block.
-- im_start_blocks record the dates these blocks will start for 
-- this system.

create table im_start_weeks (
	start_block		date not null
				constraint im_start_weeks_pk
				primary key,
				-- We might want to tag a larger unit
				-- For example, if start_block is the first
				-- Sunday of a week, those tagged with
				-- start_of_larger_unit_p might tag
				-- the first Sunday of a month
	start_of_larger_unit_p	char(1) default 'f'
				constraint im_start_weeks_larger_ck
				check (start_of_larger_unit_p in ('t','f')),
	note			text
);

create table im_start_months (
	start_block		date not null
				constraint im_start_months_pk
				primary key,
				-- We might want to tag a larger unit
				-- For example, if start_block is the first
				-- Sunday of a week, those tagged with
				-- start_of_larger_unit_p might tag
				-- the first Sunday of a month
	start_of_larger_unit_p	char(1) default 'f'
				constraint im_start_months_larger_ck
				check (start_of_larger_unit_p in ('t','f')),
	note			text
);



-- Populate im_start_weeks. Start with Sunday, 
-- Jan 7th 1996 and end after inserting 1000 weeks. Note 
-- that 1000 is a completely arbitrary number. 


--
-- procedure inline_0/0
--
CREATE OR REPLACE FUNCTION inline_0(

) RETURNS integer AS $$
DECLARE
	v_max 			integer;
	v_i				integer;
	v_first_block_of_month	integer;
	v_next_start_week		date;
BEGIN
	v_max := 1000;

	FOR v_i IN 0..v_max-1 LOOP
		-- for convenience, select out the next start block to insert into a variable
		select '1996-01-07'::date + v_i*7 
		into v_next_start_week 
		from dual;
	
		insert into im_start_weeks (
			start_block
		) values (
			v_next_start_week::date
		);
	
		-- set the start_of_larger_unit_p flag if this is the first
		-- start block of the month
		update im_start_weeks
		set start_of_larger_unit_p='t'
		where start_block = v_next_start_week::date
		and not exists (
			select 1 
				from im_start_weeks
				where to_char(start_block,'YYYY-MM') = 
				to_char(v_next_start_week,'YYYY-MM')
				and start_of_larger_unit_p='t'
		);
	END LOOP;
	return 0;
END;
$$ LANGUAGE plpgsql;
select inline_0 ();
drop function inline_0 ();



-- Populate im_start_months. Start with im_start_weeks
-- dates and check for the beginning of a new month.


--
-- procedure inline_0/0
--
CREATE OR REPLACE FUNCTION inline_0(

) RETURNS integer AS $$
DECLARE
	row RECORD;
BEGIN
	for row in
		select distinct
			to_char(start_block, 'YYYY-MM') || '-01' as first_day_in_month
		from im_start_weeks
	loop
		insert into im_start_months (
			start_block
		) values (
			to_date(row.first_day_in_month,'YYYY-MM-DD')
		);
	end loop;
	return 0;
END;
$$ LANGUAGE plpgsql;
select inline_0 ();
drop function inline_0 ();



-- create function to add_months
CREATE OR REPLACE FUNCTION add_months(
       p_date_in date, 		-- date_id
       p_months int4		-- months to add
) RETURNS date AS $$
DECLARE
	v_date_out	date;
BEGIN
	select p_date_in + "interval"( p_months || ' months') into v_date_out;
	return v_date_out;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION last_day(
       p_date_in date		-- date_id
) RETURNS date AS $$
DECLARE
	v_date_out	date;
BEGIN
	select to_date(date_trunc('month',add_months(p_date_in,1))::text, 'YYYY-MM-DD'::text) - 1 into v_date_out;
	return v_date_out;
END;
$$ LANGUAGE plpgsql;

-- select last_day(to_date('2012-01-20', 'yyyy-mm-dd'));





-- added
select define_function_args('trunc','date_in,field');

--
-- procedure trunc/2
--
CREATE OR REPLACE FUNCTION trunc(
   p_date_in date, -- date_in
   p_field varchar -- field

) RETURNS date AS $$
DECLARE 

	v_date_out	date;
BEGIN
	select date_trunc("p_field",p_date_in) into v_date_out;
	return v_date_out;
END;
$$ LANGUAGE plpgsql;



-- added
select define_function_args('next_day','date_in,day');

--
-- procedure next_day/2
--
CREATE OR REPLACE FUNCTION next_day(
   p_date_in date, -- date_in
   p_day varchar   -- day

) RETURNS date AS $$
DECLARE

	v_date_out	date;
	value_to_add integer;
	
BEGIN
	if lower(p_day) = 'sunday' or lower(p_day) = 'sun' then 
	value_to_add := 0;
	else
		if lower(p_day) = 'monday' or lower(p_day) = 'mon' then 
			value_to_add := 1;
		else
		if lower(p_day) = 'tuesday' or lower(p_day) = 'tue' then 
			value_to_add := 2;
		else
		if lower(p_day) = 'wednesday' or lower(p_day) = 'wed' then 
			value_to_add := 3;
		else
		if lower(p_day) = 'thursday' or lower(p_day) = 'thu' then 
		value_to_add := 4;
		else
		if lower(p_day) = 'friday' or lower(p_day) = 'fri' then 
			value_to_add := 5;
		else
			if lower(p_day) = 'saturday' or lower(p_day) = 'sat' then 
			value_to_add := 6;
			end if;
		end if;
		end if;
		end if;
		end if;
		end if;
	end if;

	select p_date_in - date_part('dow', p_date_in)::int + value_to_add into v_date_out;
	return v_date_out;
END;
$$ LANGUAGE plpgsql;



-------------------------------------------------------------
-- Function used to enumerate days between stat_date and end_date
-------------------------------------------------------------




-- added
select define_function_args('im_day_enumerator','start_date,end_date');

--
-- procedure im_day_enumerator/2
--
CREATE OR REPLACE FUNCTION im_day_enumerator(
   p_start_date date,
   p_end_date date
) RETURNS setof date AS $$
DECLARE
	v_date			date;
BEGIN
	v_date := p_start_date;
	WHILE (v_date < p_end_date) LOOP
		RETURN NEXT v_date;
		v_date := v_date + 1;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;




-- added
select define_function_args('im_day_enumerator_weekdays','start_date,end_date');

--
-- procedure im_day_enumerator_weekdays/2
--
CREATE OR REPLACE FUNCTION im_day_enumerator_weekdays(
   p_start_date date,
   p_end_date date
) RETURNS setof date AS $$
DECLARE
	v_date			date;
	v_weekday		integer;
BEGIN
	v_date := p_start_date;
	WHILE (v_date < p_end_date) LOOP

		v_weekday := to_char(v_date, 'D');
		IF v_weekday != 1 AND v_weekday != 7 THEN
			RETURN NEXT v_date;
		END IF;
		v_date := v_date + 1;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------
-- Generic function to convert a "reference" into something
-- printable or searchable...
-------------------------------------------------------------



-- added

--
-- procedure im_name_from_id/1
--
CREATE OR REPLACE FUNCTION im_name_from_id(
   v_integer integer
) RETURNS varchar AS $$
DECLARE
	v_result	varchar;
BEGIN
	-- Try with category - probably the fastest
	select category into v_result from im_categories
	where category_id = v_integer;

	IF v_result is not null THEN return v_result; END IF;

	-- Try with ACS_OBJECT
	select acs_object__name(v_integer)
	into v_result;

	return v_result;
END;
$$ LANGUAGE plpgsql;





--
-- procedure im_name_from_id/1
--
CREATE OR REPLACE FUNCTION im_name_from_id(
   v_result varchar
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result;
END;
$$ LANGUAGE plpgsql;




--
-- procedure im_name_from_id/1
--
CREATE OR REPLACE FUNCTION im_name_from_id(
   v_result numeric
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result::varchar;
END;
$$ LANGUAGE plpgsql;




--
-- procedure im_name_from_id/1
--
CREATE OR REPLACE FUNCTION im_name_from_id(
   v_result double precision
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result::varchar;
END;
$$ LANGUAGE plpgsql;





-- added
select define_function_args('im_name_from_id','v_timestamp');

--
-- procedure im_name_from_id/1
--
CREATE OR REPLACE FUNCTION im_name_from_id(
   v_timestamp timestamptz
) RETURNS varchar AS $$
DECLARE
BEGIN
	return to_char(v_timestamp, 'YYYY-MM-DD');
END;
$$ LANGUAGE plpgsql;





-- added
select define_function_args('im_integer_from_id','v_result');

--
-- procedure im_integer_from_id/1
--
CREATE OR REPLACE FUNCTION im_integer_from_id(
   v_result integer
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result::varchar;
END;
$$ LANGUAGE plpgsql;





--
-- procedure im_integer_from_id/1
--
CREATE OR REPLACE FUNCTION im_integer_from_id(
   v_result varchar
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result;
END;
$$ LANGUAGE plpgsql;






--
-- procedure im_integer_from_id/1
--
CREATE OR REPLACE FUNCTION im_integer_from_id(
   v_result numeric
) RETURNS varchar AS $$
DECLARE
BEGIN
	return v_result::varchar;
END;
$$ LANGUAGE plpgsql;



-- ------------------------------------------------------------------
-- Special dereferencing function for green-yellow-red traffic light
-- ------------------------------------------------------------------

-- Return a suitable GIF for traffic light status display


-- added
select define_function_args('im_traffic_light_from_id','status_id');

--
-- procedure im_traffic_light_from_id/1
--
CREATE OR REPLACE FUNCTION im_traffic_light_from_id(
   p_status_id integer
) RETURNS varchar AS $$
DECLARE

	v_category	varchar;
	v_gif		varchar;
BEGIN
	select	c.category, c.aux_string1
	into	v_category, v_gif
	from	im_categories c
	where	category_id = p_status_id;

	-- Take the GIF specified in the category
	IF v_gif is null OR v_gif = '' THEN 
		-- No GIF specified - take the default one...
		v_gif := '/intranet/images/navbar_default/bb_'||lower(v_category)|| '.gif';
	END IF;

	return '<img src="' || v_gif || '" border=0 title="" alt="">';
END;
$$ LANGUAGE plpgsql;




-- !!! FixMe: Move these update scripts to the respective modules
update acs_object_types set 
	status_type_table = 'im_freelance_rfqs', 
	status_column = 'rfq_status_id', 
	type_column = 'rfq_type_id' 
where object_type = 'im_freelance_rfq';

update acs_object_types set 
	status_type_table = 'im_freelance_rfq_answers', 
	status_column = 'answer_status_id', 
	type_column = 'answer_type_id' 
where object_type = 'im_freelance_rfq_answer';


update acs_object_types set 
	status_type_table = 'im_notes', 
	status_column = 'note_status_id', 
	type_column = 'note_type_id' 
where object_type = 'im_note';




-- ------------------------------------------------------------------
-- Add a new message key to the localization system with default
-- translation.
-- ------------------------------------------------------------------




-- added
select define_function_args('im_lang_add_message','locale,package_key,message_key,message');

--
-- procedure im_lang_add_message/4
--
CREATE OR REPLACE FUNCTION im_lang_add_message(
   p_locale text,
   p_package_key text,
   p_message_key text,
   p_message text
) RETURNS integer AS $$
DECLARE

	v_count		integer;
BEGIN
	-- Do not insert strings for packages that do not exist
	--
	select	count(*) into v_count from apm_packages
	where	package_key = p_package_key;
	IF 0 = v_count THEN return 0; END IF;

	-- Make sure there is an entry in lang_message_keys
	--
	select	count(*) into v_count from lang_message_keys
	where	package_key = p_package_key and message_key = p_message_key;
	IF 0 = v_count THEN
		insert into lang_message_keys (
			message_key, package_key
		) values (
			p_message_key, p_package_key
		);
	END IF;

	-- Create the translation entry
	--
	select	count(*) into v_count from lang_messages
	where	locale = p_locale and package_key = p_package_key and message_key = p_message_key;
	IF 0 = v_count THEN
		insert into lang_messages (
			message_key, package_key, locale, message, sync_time, upgrade_status
		) values (
			p_message_key, p_package_key, p_locale, p_message, now(), 'added'
		);
	END IF;

	return 1;
END;
$$ language 'plpgsql';



-- ------------------------------------------------------------------                                                                            
-- Special dereferencing function for links                                                                                                      
-- ------------------------------------------------------------------                                                                            



-- added
select define_function_args('im_link_from_id','object_id');

--
-- procedure im_link_from_id/1
--
CREATE OR REPLACE FUNCTION im_link_from_id(
   p_object_id integer
) RETURNS varchar AS $$
DECLARE
        v_name          varchar;
        v_url           varchar;
BEGIN
        select  im_name_from_id (p_object_id)
        into    v_name;

        select url into v_url
        from im_biz_object_urls ibou, acs_objects ao
        where ibou.object_type = ao.object_type
        and ao.object_id = p_object_id;

        return '<a href=' || v_url || p_object_id || '>' || v_name || '</a>';
END;
$$ LANGUAGE plpgsql;



