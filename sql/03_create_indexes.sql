-- ============================================================
-- SuFinex Financial Intelligence Platform
-- Phase: Database Indexes
-- ============================================================


-- ============================================================
-- Customer
-- ============================================================

CREATE INDEX idx_customer_institution
ON customer(institution_id);


-- ============================================================
-- Account
-- ============================================================

CREATE INDEX idx_account_customer
ON account(customer_id);

CREATE INDEX idx_account_institution
ON account(institution_id);


-- ============================================================
-- Card
-- ============================================================

CREATE INDEX idx_card_customer
ON card(customer_id);

CREATE INDEX idx_card_account
ON card(account_id);


-- ============================================================
-- Credit Profile
-- ============================================================

CREATE INDEX idx_credit_profile_customer
ON credit_profile(customer_id);


-- ============================================================
-- Loan
-- ============================================================

CREATE INDEX idx_loan_customer
ON loan(customer_id);

CREATE INDEX idx_loan_institution
ON loan(institution_id);


-- ============================================================
-- Merchant
-- ============================================================

CREATE INDEX idx_merchant_institution
ON merchant(institution_id);


-- ============================================================
-- Support Tickets
-- ============================================================

CREATE INDEX idx_support_ticket_customer
ON support_ticket(customer_id);

CREATE INDEX idx_support_ticket_institution
ON support_ticket(institution_id);


-- ============================================================
-- Transactions
-- ============================================================

CREATE INDEX idx_transactions_customer
ON transactions(customer_id);

CREATE INDEX idx_transactions_account
ON transactions(account_id);

CREATE INDEX idx_transactions_merchant
ON transactions(merchant_id);

CREATE INDEX idx_transactions_payment_method
ON transactions(payment_method_id);

CREATE INDEX idx_transactions_device
ON transactions(device_id);

CREATE INDEX idx_transactions_location
ON transactions(location_id);

CREATE INDEX idx_transactions_timestamp
ON transactions(transaction_timestamp);

CREATE INDEX idx_transactions_status
ON transactions(transaction_status);


-- ============================================================
-- Fraud Prediction
-- ============================================================

CREATE INDEX idx_fraud_prediction_transaction
ON fraud_prediction(transaction_id);

CREATE INDEX idx_fraud_prediction_risk_level
ON fraud_prediction(risk_level);

CREATE INDEX idx_fraud_prediction_timestamp
ON fraud_prediction(prediction_timestamp);


-- ============================================================
-- Risk Score
-- ============================================================

CREATE INDEX idx_risk_score_customer
ON risk_score(customer_id);

CREATE INDEX idx_risk_score_category
ON risk_score(risk_category);

CREATE INDEX idx_risk_score_timestamp
ON risk_score(score_timestamp);


-- ============================================================
-- Churn Prediction
-- ============================================================

CREATE INDEX idx_churn_prediction_customer
ON churn_prediction(customer_id);

CREATE INDEX idx_churn_prediction_risk
ON churn_prediction(churn_risk_level);

CREATE INDEX idx_churn_prediction_timestamp
ON churn_prediction(prediction_timestamp);


-- ============================================================
-- Fraud Investigation
-- ============================================================

CREATE INDEX idx_investigation_transaction
ON fraud_investigation(transaction_id);

CREATE INDEX idx_investigation_prediction
ON fraud_investigation(fraud_prediction_id);

CREATE INDEX idx_investigation_status
ON fraud_investigation(investigation_status);

CREATE INDEX idx_investigation_priority
ON fraud_investigation(investigation_priority);
