-- ============================================================
-- SuFinex Financial Intelligence Platform
-- Phase: Database Table Creation
-- ============================================================


-- ============================================================
-- 1. Institution
-- ============================================================

CREATE TABLE institution (
    institution_id VARCHAR(20) PRIMARY KEY,
    institution_name VARCHAR(150) NOT NULL,
    institution_type VARCHAR(50),
    country VARCHAR(100),
    status VARCHAR(30) NOT NULL DEFAULT 'Active'
);


-- ============================================================
-- 2. Customer
-- ============================================================

CREATE TABLE customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    institution_id VARCHAR(20) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    customer_since DATE,
    customer_status VARCHAR(30) NOT NULL DEFAULT 'Active',

    CONSTRAINT fk_customer_institution
        FOREIGN KEY (institution_id)
        REFERENCES institution(institution_id)
);


-- ============================================================
-- 3. Account
-- ============================================================

CREATE TABLE account (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    institution_id VARCHAR(20) NOT NULL,
    account_type VARCHAR(50),
    account_status VARCHAR(30) NOT NULL DEFAULT 'Active',
    opening_date DATE,
    current_balance DECIMAL(18,2) DEFAULT 0,

    CONSTRAINT fk_account_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_account_institution
        FOREIGN KEY (institution_id)
        REFERENCES institution(institution_id),

    CONSTRAINT chk_account_balance
        CHECK (current_balance >= 0)
);


-- ============================================================
-- 4. Card
-- ============================================================

CREATE TABLE card (
    card_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    account_id VARCHAR(20) NOT NULL,
    card_type VARCHAR(30),
    card_network VARCHAR(30),
    card_status VARCHAR(30) NOT NULL DEFAULT 'Active',
    issue_date DATE,
    expiry_date DATE,

    CONSTRAINT fk_card_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_card_account
        FOREIGN KEY (account_id)
        REFERENCES account(account_id),

    CONSTRAINT chk_card_dates
        CHECK (
            expiry_date IS NULL
            OR issue_date IS NULL
            OR expiry_date >= issue_date
        )
);


-- ============================================================
-- 5. Credit Profile
-- ============================================================

CREATE TABLE credit_profile (
    credit_profile_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    credit_score INTEGER,
    credit_utilization DECIMAL(5,2),
    total_credit_limit DECIMAL(18,2),
    outstanding_balance DECIMAL(18,2),
    delinquency_count INTEGER DEFAULT 0,
    last_updated DATE,

    CONSTRAINT fk_credit_profile_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT uq_credit_profile_customer
        UNIQUE (customer_id),

    CONSTRAINT chk_credit_score
        CHECK (
            credit_score IS NULL
            OR credit_score BETWEEN 300 AND 900
        ),

    CONSTRAINT chk_credit_utilization
        CHECK (
            credit_utilization IS NULL
            OR credit_utilization >= 0
        ),

    CONSTRAINT chk_delinquency_count
        CHECK (delinquency_count >= 0)
);


-- ============================================================
-- 6. Loan
-- ============================================================

CREATE TABLE loan (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    institution_id VARCHAR(20) NOT NULL,
    loan_type VARCHAR(50),
    loan_amount DECIMAL(18,2),
    outstanding_amount DECIMAL(18,2),
    interest_rate DECIMAL(6,2),
    loan_status VARCHAR(30) NOT NULL DEFAULT 'Active',
    start_date DATE,
    end_date DATE,

    CONSTRAINT fk_loan_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_loan_institution
        FOREIGN KEY (institution_id)
        REFERENCES institution(institution_id),

    CONSTRAINT chk_loan_amount
        CHECK (loan_amount IS NULL OR loan_amount >= 0),

    CONSTRAINT chk_outstanding_amount
        CHECK (outstanding_amount IS NULL OR outstanding_amount >= 0)
);


-- ============================================================
-- 7. Merchant
-- ============================================================

CREATE TABLE merchant (
    merchant_id VARCHAR(20) PRIMARY KEY,
    institution_id VARCHAR(20) NOT NULL,
    merchant_name VARCHAR(150) NOT NULL,
    merchant_category VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    merchant_status VARCHAR(30) NOT NULL DEFAULT 'Active',

    CONSTRAINT fk_merchant_institution
        FOREIGN KEY (institution_id)
        REFERENCES institution(institution_id)
);


-- ============================================================
-- 8. Payment Method
-- ============================================================

CREATE TABLE payment_method (
    payment_method_id VARCHAR(20) PRIMARY KEY,
    payment_method VARCHAR(50) NOT NULL,
    payment_channel VARCHAR(50),
    status VARCHAR(30) NOT NULL DEFAULT 'Active'
);


-- ============================================================
-- 9. Device
-- ============================================================

CREATE TABLE device (
    device_id VARCHAR(20) PRIMARY KEY,
    device_type VARCHAR(50),
    operating_system VARCHAR(50),
    browser VARCHAR(50),
    device_status VARCHAR(30) NOT NULL DEFAULT 'Active'
);


-- ============================================================
-- 10. Location
-- ============================================================

CREATE TABLE location (
    location_id VARCHAR(20) PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),

    CONSTRAINT chk_latitude
        CHECK (latitude IS NULL OR latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_longitude
        CHECK (longitude IS NULL OR longitude BETWEEN -180 AND 180)
);


-- ============================================================
-- 11. Support Ticket
-- ============================================================

CREATE TABLE support_ticket (
    ticket_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    institution_id VARCHAR(20) NOT NULL,
    issue_category VARCHAR(100),
    priority VARCHAR(30),
    status VARCHAR(30) NOT NULL DEFAULT 'Open',
    created_date DATE NOT NULL DEFAULT CURRENT_DATE,
    resolved_date DATE,

    CONSTRAINT fk_support_ticket_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_support_ticket_institution
        FOREIGN KEY (institution_id)
        REFERENCES institution(institution_id),

    CONSTRAINT chk_ticket_dates
        CHECK (
            resolved_date IS NULL
            OR resolved_date >= created_date
        )
);


-- ============================================================
-- 12. Transactions
-- ============================================================

CREATE TABLE transactions (
    transaction_id VARCHAR(30) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    account_id VARCHAR(20) NOT NULL,
    merchant_id VARCHAR(20),
    payment_method_id VARCHAR(20),
    device_id VARCHAR(20),
    location_id VARCHAR(20),

    amount DECIMAL(18,2) NOT NULL,
    transaction_timestamp TIMESTAMP NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    transaction_status VARCHAR(30) NOT NULL DEFAULT 'Completed',
    currency VARCHAR(10) NOT NULL DEFAULT 'INR',
    description VARCHAR(255),

    CONSTRAINT fk_transaction_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_transaction_account
        FOREIGN KEY (account_id)
        REFERENCES account(account_id),

    CONSTRAINT fk_transaction_merchant
        FOREIGN KEY (merchant_id)
        REFERENCES merchant(merchant_id),

    CONSTRAINT fk_transaction_payment_method
        FOREIGN KEY (payment_method_id)
        REFERENCES payment_method(payment_method_id),

    CONSTRAINT fk_transaction_device
        FOREIGN KEY (device_id)
        REFERENCES device(device_id),

    CONSTRAINT fk_transaction_location
        FOREIGN KEY (location_id)
        REFERENCES location(location_id),

    CONSTRAINT chk_transaction_amount
        CHECK (amount > 0)
);


-- ============================================================
-- 13. Fraud Prediction
-- ============================================================

CREATE TABLE fraud_prediction (
    fraud_prediction_id VARCHAR(20) PRIMARY KEY,
    transaction_id VARCHAR(30) NOT NULL,
    fraud_prediction VARCHAR(20) NOT NULL,
    fraud_probability DECIMAL(6,5) NOT NULL,
    risk_level VARCHAR(20),
    model_name VARCHAR(100),
    model_version VARCHAR(30),
    prediction_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_fraud_prediction_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT chk_fraud_probability
        CHECK (fraud_probability BETWEEN 0 AND 1),

    CONSTRAINT chk_fraud_prediction
        CHECK (
            fraud_prediction IN ('Fraud', 'Legitimate')
        )
);


-- ============================================================
-- 14. Risk Score
-- ============================================================

CREATE TABLE risk_score (
    risk_score_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    risk_score DECIMAL(6,2) NOT NULL,
    risk_category VARCHAR(20) NOT NULL,
    model_name VARCHAR(100),
    model_version VARCHAR(30),
    score_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_risk_score_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT chk_risk_score
        CHECK (risk_score BETWEEN 0 AND 100),

    CONSTRAINT chk_risk_category
        CHECK (
            risk_category IN ('Low', 'Medium', 'High', 'Critical')
        )
);


-- ============================================================
-- 15. Churn Prediction
-- ============================================================

CREATE TABLE churn_prediction (
    churn_prediction_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    churn_prediction VARCHAR(20) NOT NULL,
    churn_probability DECIMAL(6,5) NOT NULL,
    churn_risk_level VARCHAR(20),
    model_name VARCHAR(100),
    model_version VARCHAR(30),
    prediction_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_churn_prediction_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT chk_churn_probability
        CHECK (churn_probability BETWEEN 0 AND 1),

    CONSTRAINT chk_churn_prediction
        CHECK (
            churn_prediction IN ('Churn', 'Not Churn')
        )
);


-- ============================================================
-- 16. Fraud Investigation
-- ============================================================

CREATE TABLE fraud_investigation (
    investigation_id VARCHAR(20) PRIMARY KEY,
    transaction_id VARCHAR(30) NOT NULL,
    fraud_prediction_id VARCHAR(20),
    investigation_status VARCHAR(30) NOT NULL DEFAULT 'Open',
    investigation_priority VARCHAR(20),
    investigator_name VARCHAR(100),
    investigation_notes TEXT,
    investigation_result VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,

    CONSTRAINT fk_investigation_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT fk_investigation_prediction
        FOREIGN KEY (fraud_prediction_id)
        REFERENCES fraud_prediction(fraud_prediction_id),

    CONSTRAINT chk_investigation_status
        CHECK (
            investigation_status
            IN ('Open', 'In Progress', 'Resolved', 'Closed')
        ),

    CONSTRAINT chk_investigation_priority
        CHECK (
            investigation_priority IS NULL
            OR investigation_priority IN ('Low', 'Medium', 'High', 'Critical')
        ),

    CONSTRAINT chk_investigation_dates
        CHECK (
            resolved_at IS NULL
            OR resolved_at >= created_at
        )
);
