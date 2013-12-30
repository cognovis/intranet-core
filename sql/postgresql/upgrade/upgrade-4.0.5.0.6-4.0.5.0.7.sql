-- upgrade-4.0.5.0.6-4.0.5.0.7.sql
SELECT acs_log__debug('/packages/intranet-core/sql/postgresql/upgrade/upgrade-4.0.5.0.6-4.0.5.0.7.sql','');

delete from im_view_columns where column_name = '"Member State"' and view_id = 11;

