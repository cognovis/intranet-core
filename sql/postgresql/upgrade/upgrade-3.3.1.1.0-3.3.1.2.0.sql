-- upgrade-3.3.1.1.0-3.3.1.2.0.sql

CREATE OR REPLACE FUNCTION im_category_new (
        integer, varchar, varchar
) RETURNS integer as '
DECLARE
        p_category_id           alias for $1;
        p_category              alias for $2;
        p_category_type         alias for $3;
        v_count                 integer;
BEGIN
        select  count(*) into v_count
        from    im_categories
        where   category = p_category and
                category_type = p_category_type;

        IF v_count > 0 THEN return 0; END IF;

        insert into im_categories(category_id, category, category_type)
        values (p_category_id, p_category, p_category_type);

        RETURN 0;
end;' language 'plpgsql';

