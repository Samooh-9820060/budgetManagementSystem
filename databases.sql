/*
Database Name: budgetManagementDB
User Name: budgetManager
Password: user@123
*/

--CREATE TRANSACTION TYPES TABLE
CREATE TABLE TRANSACTION_TYPES (
    type_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    type_name VARCHAR(100)
);

--CREATE THEMES TABLE
CREATE TABLE THEMES (
    theme_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    theme_name VARCHAR(100)
);

--CREATE CURRENCIES TABLE
CREATE TABLE CURRENCIES (
    currency_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    currency_name VARCHAR(100),
    currency_symbol_code VARCHAR(100),
    conversion_rate_to_usd INT,
    description LONG VARCHAR,
    is_active BOOLEAN
);

--CREATE COUNTRIES TABLE
CREATE TABLE COUNTRIES (
    country_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    country_code VARCHAR(100),
    country_name VARCHAR(100),
    country_phone_code VARCHAR(100),
    time_zone VARCHAR(100),
    currency_id INT,
    currency_code VARCHAR(100),
    FOREIGN KEY (currency_id) REFERENCES CURRENCIES (currency_id)
);

--CREATE RECURRING FREQUENCY TABLE
CREATE TABLE RECURRING_FREQUENCIES (
    recurring_frequency_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    frequency_name VARCHAR(100),
    frequency_code VARCHAR(100),
    description LONG VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status BOOLEAN,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    interval INT
);

--CREATE USERS TABLE 
CREATE TABLE USERS (
    user_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    password LONG VARCHAR,
    created_date TIMESTAMP,
    status BOOLEAN,
    last_access TIMESTAMP,
    date_of_birth TIMESTAMP,
    phone_number INT,
    country_id INT,
    city VARCHAR(100),
    address VARCHAR(100),
    gender VARCHAR(100),
    security_question VARCHAR(200),
    security_answer VARCHAR(200),
    two_factor_authentication BOOLEAN,
    credit_score INT,
    FOREIGN KEY (country_id) REFERENCES COUNTRIES(country_id)  
);

--CREATE CATEGORIES TABLE
CREATE TABLE CATEGORIES (
    category_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT NOT NULL,
    category_name VARCHAR(100),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status BOOLEAN,
    deleted_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)  
);

--CREATE BUDGET TABLE
CREATE TABLE BUDGETS (
    budget_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    category_id INT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    recurring_id INT,
    notes LONG VARCHAR,
    user_id INT,
    last_modified_date TIMESTAMP,
    is_active BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES CATEGORIES (category_id),
    FOREIGN KEY (user_id) REFERENCES USERS (user_id),
    FOREIGN KEY (recurring_id) REFERENCES RECURRING_FREQUENCIES (recurring_frequency_id)
);

--CREATE ACCOUNTS TABLE
CREATE TABLE ACCOUNTS (
    account_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    account_name VARCHAR(100),
    account_type VARCHAR(100),
    account_number INT,
    bank_name VARCHAR(100),
    current_balance INT,
    opening_date TIMESTAMP,
    closing_date TIMESTAMP,
    status BOOLEAN,
    notes LONG VARCHAR,
    currency_id INT,
    last_transaction_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS (user_id),
    FOREIGN KEY (currency_id) REFERENCES CURRENCIES (currency_id)
);

--CREATE BILLS TABLE
CREATE TABLE BILLS (
    bill_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT NOT NULL,
    account_id INT NOT NULL,
    category_id INT NOT NULL,
    bill_name VARCHAR(100),
    description LONG VARCHAR,
    amount INT,
    payment_date TIMESTAMP,
    due_date TIMESTAMP,
    payment_status BOOLEAN,
    recurring_frequency_id INT NOT NULL,
    date_created TIMESTAMP,
    date_modified TIMESTAMP,
    notes LONG VARCHAR,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (account_id) REFERENCES ACCOUNTS(account_id),
    FOREIGN KEY (recurring_frequency_id) REFERENCES RECURRING_FREQUENCIES(recurring_frequency_id)
);

--CREATE SETTINGS TABLE
CREATE TABLE SETTINGS (
    settings_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    default_currency_id INT,
    date_format VARCHAR(100),
    email_notifications BOOLEAN,
    SMS_notifications BOOLEAN,
    theme_id INT,
    updated_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (default_currency_id) REFERENCES CURRENCIES(currency_id),
    FOREIGN KEY (theme_id) REFERENCES THEMES (theme_id)
);

--CREATE TRANSACTIONS TABLE
CREATE TABLE TRANSACTIONS (
    transaction_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    transaction_date TIMESTAMP,
    account_id INT,
    category_id INT,
    bill_id INT,
    amount INT,
    type_id INT,
    description LONG VARCHAR,
    recurring_id INT,
    created_date TIMESTAMP,
    updated_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS (user_id),
    FOREIGN KEY (account_id) REFERENCES ACCOUNTS (account_id),
    FOREIGN KEY (category_id) REFERENCES CATEGORIES (category_id),
    FOREIGN KEY (bill_id) REFERENCES BILLS (bill_id),
    FOREIGN KEY (type_id) REFERENCES TRANSACTION_TYPES (type_id),
    FOREIGN KEY (recurring_id) REFERENCES RECURRING_FREQUENCIES (recurring_frequency_id)
);

--CREATE SAVINGS TABLE 
CREATE TABLE SAVINGS (
    savings_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    name VARCHAR(100),
    amount INT,
    target_amount INT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    notes LONG VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    savings_status VARCHAR(100),
    category_id INT,
    recurring_id INT,
    account_id INT,
    budget_id INT,
    is_active BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (category_id) REFERENCES CATEGORIES(category_id),
    FOREIGN KEY (recurring_id) REFERENCES RECURRING_FREQUENCIES(recurring_frequency_id),
    FOREIGN KEY (account_id) REFERENCES ACCOUNTS(account_id),
    FOREIGN KEY (budget_id) REFERENCES BUDGETS(budget_id)
);

--CREATE REPORT TYPES TABLE
CREATE TABLE REPORT_TYPES (
    report_type_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    report_name VARCHAR(100),
    description LONG VARCHAR,
    created_date TIMESTAMP,
    modified_date TIMESTAMP,
    is_active BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES USERS (user_id)
);

--CREATE REPORTS TABLE
CREATE TABLE REPORTS (
    report_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    user_id INT,
    report_type_id INT,
    generated_date TIMESTAMP,
    file_type VARCHAR(100),
    report_start_date TIMESTAMP,
    report_end_date TIMESTAMP,
    description LONG VARCHAR,
    status BOOLEAN,
    error_message LONG VARCHAR,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (report_type_id) REFERENCES REPORT_TYPES(report_type_id)
);