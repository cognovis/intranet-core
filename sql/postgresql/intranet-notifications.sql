-- /packages/intranet-core/sql/oracle/intranet-views.sql
--
-- Copyright (c) 2007 ]project-open[
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



-- Determine the default locale for the user


-- added
select define_function_args('acs_lang_get_locale_for_user','user_id');

--
-- procedure acs_lang_get_locale_for_user/1
--
CREATE OR REPLACE FUNCTION acs_lang_get_locale_for_user(
   p_user_id integer
) RETURNS text AS $$
DECLARE

	v_workflow_key		varchar(100);
	v_transition_key	varchar(100);
	v_acs_lang_package_id	integer;
	v_locale		varchar(10);
BEGIN
	-- Get the users local from preferences
	select	locale into v_locale
	from	user_preferences
	where	user_id = p_user_id;

	-- Get users locale from global default
	IF v_locale is null THEN
		select	package_id
		into	v_acs_lang_package_id
		from	apm_packages
		where	package_key = 'acs-lang';

		v_locale := apm__get_value (v_acs_lang_package_id, 'SiteWideLocale');
	END IF;

	-- Partial locale - lookup complete one
	IF length(v_locale) = 2 THEN
		select	locale into v_locale
		from	ad_locales
		where	language = v_locale
			and enabled_p = 't'
			and (default_p = 't'
			   or (select count(*) from ad_locales where language = v_locale) = 1
			);
	END IF;

	-- Default: English
	IF v_locale is null THEN
		v_locale := 'en_US';
	END IF;

	return v_locale;
END;
$$ LANGUAGE plpgsql;


-- Determine the message string for (locale, package_key, message_key):


-- added
select define_function_args('acs_lang_lookup_message','locale,package_key,message_key');

--
-- procedure acs_lang_lookup_message/3
--
CREATE OR REPLACE FUNCTION acs_lang_lookup_message(
   p_locale text,
   p_package_key text,
   p_message_key text
) RETURNS text AS $$
DECLARE
	v_message		text;
	v_locale		text;
	v_acs_lang_package_id	integer;
BEGIN
	-- --------------------------------------------
	-- Check full locale
	select	message into v_message
	from	lang_messages
	where	(message_key = p_message_key OR message_key = replace(p_message_key, ' ', '_'))
		and package_key = p_package_key
		and locale = p_locale
	LIMIT 1;
	IF v_message is not null THEN return v_message; END IF;

	-- --------------------------------------------
	-- Partial locale - lookup complete one
	v_locale := substring(p_locale from 1 for 2);

	select	locale into v_locale
	from	ad_locales
	where	language = v_locale
		and enabled_p = 't'
		and (default_p = 't' or
		(select count(*) from ad_locales where language = v_locale) = 1);

	select	message into v_message
	from	lang_messages
	where	(message_key = p_message_key OR message_key = replace(p_message_key, ' ', '_'))
		and package_key = p_package_key
		and locale = v_locale
	LIMIT 1;
	IF v_message is not null THEN return v_message; END IF;

	-- --------------------------------------------
	-- Try System Locale
	select	package_id into	v_acs_lang_package_id
	from	apm_packages
	where	package_key = 'acs-lang';
	v_locale := apm__get_value (v_acs_lang_package_id, 'SiteWideLocale');

	select	message into v_message
	from	lang_messages
	where	(message_key = p_message_key OR message_key = replace(p_message_key, ' ', '_'))
		and package_key = p_package_key
		and locale = v_locale
	LIMIT 1;
	IF v_message is not null THEN return v_message; END IF;

	-- --------------------------------------------
	-- Try with English...
	v_locale := 'en_US';
	select	message into v_message
	from	lang_messages
	where	(message_key = p_message_key OR message_key = replace(p_message_key, ' ', '_'))
		and package_key = p_package_key
		and locale = v_locale
	LIMIT 1;
	IF v_message is not null THEN return v_message; END IF;

	-- --------------------------------------------
	-- Nothing found...
	v_message := 'MISSING ' || p_locale || ' TRANSLATION for ' || p_package_key || '.' || p_message_key;
	return v_message;	

END;
$$ language 'plpgsql';


