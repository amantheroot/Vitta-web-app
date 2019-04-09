DROP DATABASE IF EXISTS vitta;

CREATE DATABASE IF NOT EXISTS vitta;

USE vitta;

-- TABLES
CREATE TABLE companies (
  company_name VARCHAR(30) NOT NULL,
  company_address VARCHAR(300) NOT NULL,
  company_phone VARCHAR(10) NOT NULL,
  company_branch_code VARCHAR(6) NOT NULL,
  company_fax_no VARCHAR(6) NULL,
  company_website VARCHAR(100) NULL,
  company_email VARCHAR(100) NULL,
  company_country VARCHAR(100) NULL,
  company_state VARCHAR(100) NULL,
  company_business_type VARCHAR(100) NULL,
  company_selection VARCHAR(100) NULL,
  company_working_style VARCHAR(100) NULL,
  company_gstin CHAR(15) NULL,
  company_vat_no VARCHAR(10) NULL,
  company_dl_no VARCHAR(20) NULL,
  company_mfg_lic_no VARCHAR(10) NULL,
  company_lst_no VARCHAR(10) NULL,
  company_service_tax VARCHAR(20) NULL,
  company_food_lic_no VARCHAR(10) NULL,
  company_jurisdiction VARCHAR(30) NULL,
  company_tax_structure ENUM('Product Wise', 'Bill Wise') NULL,
  company_data_type INT NOT NULL,
  company_financial_year_start DATE NOT NULL,
  company_financial_year_end DATE NOT NULL,
  company_data_dir VARCHAR(100) NOT NULL,
  company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (company_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE customers (
  customer_name VARCHAR(30) NOT NULL,
  customer_address VARCHAR(300) NOT NULL,
  customer_phone VARCHAR(10) NOT NULL,
  customer_gstin CHAR(15) NOT NULL,
  customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (customer_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE suppliers (
  supplier_name VARCHAR(30) NOT NULL,
  supplier_address VARCHAR(300) NOT NULL,
  supplier_phone VARCHAR(10) NOT NULL,
  supplier_gstin CHAR(15) NOT NULL,
  supplier_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (supplier_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE products (
  product_status ENUM('CONTINUE', 'CLOSE') NOT NULL,
  product_type ENUM('NORMAL', 'PROHIBITED') NOT NULL,
  product_hide BOOLEAN NOT NULL,
  product_item VARCHAR(30) NOT NULL,
  product_barcode VARCHAR(10) NOT NULL,
  product_generate ENUM('DEFAULT', 'CREATE') NOT NULL,
  product_unit CHAR(3) NOT NULL,
  product_decimal BOOLEAN NOT NULL,
  product_fast_search CHAR(14) NULL,
  product_color_type VARCHAR(15) NOT NULL,
  product_item_type VARCHAR(15) NOT NULL,
  product_rack_no VARCHAR(10) NULL,
  product_company BOOLEAN NOT NULL,
  product_group BOOLEAN NOT NULL,
  product_category BOOLEAN NOT NULL,
  product_local ENUM('Taxable', 'Exempted', 'Tax Paid') NOT NULL,
  product_central ENUM('Taxable', 'Exempted') NOT NULL,
  product_mrp FLOAT NOT NULL,
  product_rate_a FLOAT NOT NULL,
  product_conv_box FLOAT NOT NULL,
  product_min_qty INT UNSIGNED NOT NULL,
  product_item_disc_1 FLOAT NOT NULL,
  product_special_disc FLOAT NOT NULL,
  product_max_disc FLOAT NOT NULL,
  product_min_margin FLOAT NOT NULL,
  product_vat_perc FLOAT NOT NULL,
  product_excise FLOAT NOT NULL,
  product_p_rate FLOAT NOT NULL,
  product_rate_b FLOAT NOT NULL,
  product_default_sale FLOAT NOT NULL,
  product_max_qty INT UNSIGNED NOT NULL,
  product_disc_2 FLOAT NOT NULL,
  product_on_qty INT UNSIGNED NOT NULL,
  product_purc_disc FLOAT NOT NULL,
  product_disc_less FLOAT NOT NULL,
  product_cost FLOAT NOT NULL,
  product_rate_c FLOAT NOT NULL,
  product_negative BOOLEAN NOT NULL,
  product_reorder_qty INT UNSIGNED NOT NULL,
  product_days INT UNSIGNED NOT NULL,
  product_disc ENUM('Applicable', 'No Discount') NOT NULL,
  product_f6_rate BOOLEAN NOT NULL,
  product_mfr_f3_list VARCHAR(15) NULL,
  company_id INT UNSIGNED NOT NULL,
  supplier_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (product_id),
  FOREIGN KEY (company_id) REFERENCES companies(company_id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE stocks (
  product_id INT UNSIGNED NOT NULL,
  product_qty INT UNSIGNED NOT NULL,
  stock_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (stock_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE orders (
  customer_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  product_qty_sold INT UNSIGNED NOT NULL,
  product_price FLOAT UNSIGNED NOT NULL,
  product_tax FLOAT UNSIGNED NOT NULL,
  order_time TIMESTAMP NOT NULL,
  order_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
