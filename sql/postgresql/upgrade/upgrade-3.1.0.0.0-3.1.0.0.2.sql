

-- -----------------------------------------------------
-- default_vat instead of vat

alter table im_companies add default_vat numeric(12,1);
alter table im_companies alter column default_vat set default 0;
update im_companies set default_vat = vat;
alter table im_companies drop column vat;


-- -----------------------------------------------------
-- default_invoice_template_id instead of invoice_template_id

alter table im_companies add
        default_invoice_template_id integer
        constraint im_companies_def_invoice_template_fk
        references im_categories;

update im_companies set default_invoice_template_id = invoice_template_id;
alter table im_companies drop column invoice_template_id;


-- -----------------------------------------------------
-- Default payment method
alter table im_companies add
        default_payment_method_id       integer
        constraint im_companies_def_invoice_payment_fk
        references im_categories;

update im_companies set default_payment_method_id = payment_method_id;
alter table im_companies drop column payment_method_id;


-- -----------------------------------------------------
-- Default payment days

alter table im_companies add
        default_payment_days            integer;

update im_companies set default_payment_days = payment_days;
alter table im_companies drop column payment_days;

