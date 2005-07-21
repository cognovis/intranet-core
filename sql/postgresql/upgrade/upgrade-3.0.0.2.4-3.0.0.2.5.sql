

-- Replace the "start_date" and "end_date" columns
-- in im_projects by timestamptz type
--
BEGIN;
ALTER TABLE im_projects ADD COLUMN end_date_new timestamptz;
UPDATE im_projects SET end_date_new = CAST(end_date AS timestamptz);
ALTER TABLE im_projects DROP COLUMN end_date;
ALTER TABLE im_projects ADD COLUMN end_date timestamptz;
UPDATE im_projects SET end_date = end_date_new;
ALTER TABLE im_projects DROP COLUMN end_date_new;
COMMIT;



BEGIN;
ALTER TABLE im_projects ADD COLUMN start_date_new timestamptz;
UPDATE im_projects SET start_date_new = CAST(start_date AS timestamptz);
ALTER TABLE im_projects DROP COLUMN start_date;
ALTER TABLE im_projects ADD COLUMN start_date timestamptz;
UPDATE im_projects SET start_date = start_date_new;
ALTER TABLE im_projects DROP COLUMN start_date_new;
COMMIT;


