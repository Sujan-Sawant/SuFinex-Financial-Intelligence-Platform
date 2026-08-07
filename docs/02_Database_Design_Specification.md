# Database Design Specification (DDS)

## Project Name
SuFinex Financial Intelligence Platform

## Version
1.0

## Prepared By
Sujan Sawant

## Date
07 August 2026

---

# 1. Overview

The Database Design Specification (DDS) defines the logical database structure of the SuFinex Financial Intelligence Platform.

SuFinex is an AI-powered Financial Intelligence Platform that enables banks, fintech companies, and payment providers to upload financial transaction data for fraud detection, customer risk assessment, business analytics, and AI-driven insights.

The database is designed using a modular and scalable architecture that supports Machine Learning, SQL Analytics, REST APIs, and Interactive Dashboards.

---

# 2. Database Design Principles

The database has been designed with the following principles:

- Multi-tenant architecture using Institution as the top-level entity.
- Transaction-centric design where Transactions act as the core business entity.
- Normalized structure to reduce data redundancy.
- Scalable schema for future enhancements.
- Easy integration with Machine Learning pipelines.
- Optimized for SQL analytics and Power BI reporting.

---

# 3. Naming Conventions

## Primary Key Format

| Table | Format |
|---------|---------|
| Institution | INST000001 |
| Customer | CUST000001 |
| Account | ACC000001 |
| Card | CARD000001 |
| Merchant | MER000001 |
| Transaction | TXN000000001 |
| Loan | LOAN000001 |
| Device | DEV000001 |
| Location | LOC000001 |
| Fraud Prediction | FRD000001 |
| Risk Score | RSK000001 |
| Churn Prediction | CHN000001 |
| Support Ticket | SUP000001 |

---

# 4. Database Architecture

The database is organized into four logical domains.

## Institution Domain

- Institution

## Customer Domain

- Customer
- Account
- Card
- Credit Profile
- Loan
- Support Ticket

## Transaction Domain

- Transaction
- Merchant
- Payment Method
- Device
- Location

## Intelligence Domain

- Fraud Prediction
- Risk Score
- Churn Prediction
- Fraud Investigation

---

# 5. Table Specifications

---

## 5.1 Institution

### Purpose

Stores information about client organizations that use the SuFinex Financial Intelligence Platform.

Examples include banks, fintech companies, and payment gateways.

### Primary Key

institution_id

### Related Tables

- Customer
- Account
- Transaction
- Merchant
- Loan
- Support Ticket

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| institution_id | VARCHAR | Unique institution identifier |
| institution_name | VARCHAR | Organization name |
| institution_type | VARCHAR | Bank, FinTech, Payment Gateway |
| registration_number | VARCHAR | Business registration number |
| headquarters_city | VARCHAR | Headquarters city |
| headquarters_state | VARCHAR | Headquarters state |
| headquarters_country | VARCHAR | Headquarters country |
| contact_email | VARCHAR | Official contact email |
| contact_phone | VARCHAR | Contact number |
| onboarding_date | DATE | Institution onboarding date |
| subscription_plan | VARCHAR | Basic, Professional, Enterprise |
| status | VARCHAR | Active, Inactive, Suspended |

### Notes

The Institution table enables a multi-tenant architecture where data belonging to different organizations remains logically separated.

---

## 5.2 Customer

### Purpose

Stores customer profile information received from client institutions.

Each customer belongs to exactly one institution and may own multiple accounts, cards, and loans.

### Primary Key

customer_id

### Foreign Key

institution_id

### Related Tables

- Account
- Card
- Credit Profile
- Loan
- Risk Score
- Churn Prediction
- Support Ticket

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| customer_id | VARCHAR | Unique customer identifier |
| institution_id | VARCHAR | Institution reference |
| first_name | VARCHAR | Customer first name |
| last_name | VARCHAR | Customer last name |
| gender | VARCHAR | Gender |
| date_of_birth | DATE | Date of birth |
| email | VARCHAR | Email address |
| phone_number | VARCHAR | Contact number |
| occupation | VARCHAR | Occupation |
| annual_income | DECIMAL | Annual income |
| customer_since | DATE | Customer onboarding date |
| customer_status | VARCHAR | Active, Dormant, Closed |

### Notes

Customer information serves as the foundation for customer analytics, fraud detection, and risk scoring.

---

# 6. Relationship Summary

| Parent Table | Child Table | Relationship |
|---------------|-------------|--------------|
| Institution | Customer | One-to-Many |
| Customer | Account | One-to-Many |
| Account | Card | One-to-Many |
| Customer | Loan | One-to-Many |
| Customer | Credit Profile | One-to-One |
| Account | Transaction | One-to-Many |
| Merchant | Transaction | One-to-Many |
| Payment Method | Transaction | One-to-Many |
| Device | Transaction | One-to-Many |
| Location | Transaction | One-to-Many |
| Transaction | Fraud Prediction | One-to-One |
| Fraud Prediction | Fraud Investigation | One-to-Many |
| Customer | Risk Score | One-to-One |
| Customer | Churn Prediction | One-to-One |
| Customer | Support Ticket | One-to-Many |

---

# 7. Future Enhancements

Future versions of the database may include:

- User Authentication
- Role-Based Access Control (RBAC)
- API Request Logs
- Audit Logs
- Model Versioning
- Real-Time Event Streaming
- Cloud Data Warehouse Integration

---

## 5.3 Account

### Purpose

Stores bank account information for customers. A customer can own one or more accounts, and each account belongs to a single institution.

### Primary Key

account_id

### Foreign Key

- customer_id
- institution_id

### Related Tables

- Customer
- Card
- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| account_id | VARCHAR | Unique account identifier |
| customer_id | VARCHAR | Customer reference |
| institution_id | VARCHAR | Institution reference |
| account_number | VARCHAR | Bank account number |
| account_type | VARCHAR | Savings, Current, Salary, Business |
| account_status | VARCHAR | Active, Dormant, Closed |
| account_open_date | DATE | Account opening date |
| available_balance | DECIMAL | Current available balance |

### Notes

Each account belongs to one customer and serves as the source for financial transactions.

---

## 5.4 Card

### Purpose

Stores debit and credit card information linked to customer accounts.

### Primary Key

card_id

### Foreign Key

- account_id
- customer_id

### Related Tables

- Account
- Customer
- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| card_id | VARCHAR | Unique card identifier |
| account_id | VARCHAR | Linked account |
| customer_id | VARCHAR | Card owner |
| card_type | VARCHAR | Debit, Credit |
| network | VARCHAR | Visa, MasterCard, RuPay |
| issue_date | DATE | Card issue date |
| expiry_date | DATE | Card expiry date |
| card_status | VARCHAR | Active, Blocked, Expired |

### Notes

Cards are used as one of the payment instruments for financial transactions.

---

## 5.5 Credit Profile

### Purpose

Maintains customer credit information used for credit risk analysis and loan evaluation.

### Primary Key

credit_profile_id

### Foreign Key

customer_id

### Related Tables

- Customer
- Risk Score
- Loan

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| credit_profile_id | VARCHAR | Unique credit profile identifier |
| customer_id | VARCHAR | Customer reference |
| credit_score | INTEGER | Credit score |
| credit_utilization | DECIMAL | Credit utilization percentage |
| total_credit_limit | DECIMAL | Total available credit |
| outstanding_balance | DECIMAL | Outstanding credit amount |
| delinquency_count | INTEGER | Number of missed payments |
| last_updated | DATE | Profile update date |

### Notes

This table supports customer risk assessment and lending analytics.

---

## 5.6 Loan

### Purpose

Stores loan details associated with customers for financial risk analysis.

### Primary Key

loan_id

### Foreign Key

- customer_id
- institution_id

### Related Tables

- Customer
- Credit Profile

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| loan_id | VARCHAR | Unique loan identifier |
| customer_id | VARCHAR | Customer reference |
| institution_id | VARCHAR | Institution reference |
| loan_type | VARCHAR | Home, Personal, Vehicle, Education |
| loan_amount | DECIMAL | Approved loan amount |
| outstanding_amount | DECIMAL | Remaining loan balance |
| interest_rate | DECIMAL | Annual interest rate |
| loan_status | VARCHAR | Active, Closed, Defaulted |
| start_date | DATE | Loan start date |
| end_date | DATE | Loan maturity date |

### Notes

Loan information is used to enhance customer risk profiling and financial analytics.

---

## 5.7 Support Ticket

### Purpose

Stores customer service requests and operational issues raised by institutions.

### Primary Key

ticket_id

### Foreign Key

- customer_id
- institution_id

### Related Tables

- Customer

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| ticket_id | VARCHAR | Unique support ticket identifier |
| customer_id | VARCHAR | Customer reference |
| institution_id | VARCHAR | Institution reference |
| issue_category | VARCHAR | Payment, Account, Card, Fraud, Loan |
| priority | VARCHAR | Low, Medium, High, Critical |
| status | VARCHAR | Open, In Progress, Resolved, Closed |
| created_date | DATE | Ticket creation date |
| resolved_date | DATE | Ticket resolution date |

### Notes

Support tickets help monitor customer issues and improve operational efficiency.

---

## 5.8 Merchant

### Purpose

Stores merchant information for businesses receiving payments from customers.

### Primary Key

merchant_id

### Foreign Key

institution_id

### Related Tables

- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| merchant_id | VARCHAR | Unique merchant identifier |
| institution_id | VARCHAR | Institution reference |
| merchant_name | VARCHAR | Merchant name |
| merchant_category | VARCHAR | Retail, Grocery, Food, Travel, Healthcare |
| city | VARCHAR | Merchant city |
| state | VARCHAR | Merchant state |
| country | VARCHAR | Merchant country |
| merchant_status | VARCHAR | Active, Inactive |

### Notes

Merchant information enables merchant performance analysis and fraud monitoring.

---

## 5.9 Payment Method

### Purpose

Stores the payment method used for each financial transaction.

### Primary Key

payment_method_id

### Related Tables

- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| payment_method_id | VARCHAR | Unique payment method identifier |
| payment_method | VARCHAR | UPI, Debit Card, Credit Card, Wallet, NEFT, RTGS, IMPS |
| payment_channel | VARCHAR | Online, POS, Mobile App |
| status | VARCHAR | Active, Inactive |

### Notes

Used to analyze customer payment preferences and transaction trends.

---

## 5.10 Device

### Purpose

Stores device information used to perform financial transactions.

### Primary Key

device_id

### Related Tables

- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| device_id | VARCHAR | Unique device identifier |
| device_type | VARCHAR | Mobile, Desktop, POS |
| operating_system | VARCHAR | Android, iOS, Windows, Linux |
| browser | VARCHAR | Chrome, Safari, Edge, Firefox |
| device_status | VARCHAR | Active, Blocked |

### Notes

Device information is valuable for fraud detection and behavioral analytics.

---

## 5.11 Location

### Purpose

Stores geographical information associated with customer transactions.

### Primary Key

location_id

### Related Tables

- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| location_id | VARCHAR | Unique location identifier |
| city | VARCHAR | Transaction city |
| state | VARCHAR | Transaction state |
| country | VARCHAR | Transaction country |
| latitude | DECIMAL | Latitude coordinate |
| longitude | DECIMAL | Longitude coordinate |

### Notes

Location data supports fraud detection, geo-analysis, and business reporting.

## 5.12 Transaction

### Purpose

Stores every financial transaction received from client institutions. This is the central fact table of the SuFinex Financial Intelligence Platform and serves as the primary source for analytics, fraud detection, customer risk assessment, and business intelligence.

### Primary Key

transaction_id

### Foreign Keys

- institution_id
- account_id
- customer_id
- merchant_id
- payment_method_id
- device_id
- location_id

### Related Tables

- Institution
- Customer
- Account
- Merchant
- Payment Method
- Device
- Location
- Fraud Prediction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| transaction_id | VARCHAR | Unique transaction identifier |
| institution_id | VARCHAR | Institution reference |
| customer_id | VARCHAR | Customer reference |
| account_id | VARCHAR | Account reference |
| merchant_id | VARCHAR | Merchant reference |
| payment_method_id | VARCHAR | Payment method reference |
| device_id | VARCHAR | Device reference |
| location_id | VARCHAR | Transaction location reference |
| transaction_date | DATE | Transaction date |
| transaction_time | TIME | Transaction time |
| transaction_amount | DECIMAL | Transaction amount |
| currency | VARCHAR | Transaction currency |
| transaction_type | VARCHAR | Purchase, Transfer, Withdrawal, Deposit, Bill Payment |
| transaction_status | VARCHAR | Success, Failed, Pending, Reversed |
| transaction_channel | VARCHAR | Mobile App, Internet Banking, ATM, POS |
| merchant_reference | VARCHAR | Merchant transaction reference |
| remarks | VARCHAR | Optional transaction remarks |

### Notes

The Transaction table is the core business table of the platform. It connects customer, account, merchant, payment method, device, and location information, enabling AI models, SQL analytics, APIs, and dashboards to generate business insights.

## 5.13 Fraud Prediction

### Purpose

Stores fraud prediction results generated by the machine learning model for each transaction.

### Primary Key

fraud_prediction_id

### Foreign Key

- transaction_id

### Related Tables

- Transaction
- Fraud Investigation

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| fraud_prediction_id | VARCHAR | Unique prediction identifier |
| transaction_id | VARCHAR | Transaction reference |
| fraud_probability | DECIMAL | Probability of fraud |
| prediction | VARCHAR | Fraud / Genuine |
| model_version | VARCHAR | Model version used |
| prediction_timestamp | TIMESTAMP | Prediction time |

### Notes

Stores AI-generated fraud predictions for monitoring and investigation.

---

## 5.14 Risk Score

### Purpose

Stores customer risk scores generated using transaction history and customer behavior.

### Primary Key

risk_score_id

### Foreign Key

- customer_id

### Related Tables

- Customer
- Credit Profile

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| risk_score_id | VARCHAR | Unique risk score identifier |
| customer_id | VARCHAR | Customer reference |
| risk_score | DECIMAL | Overall customer risk score |
| risk_level | VARCHAR | Low, Medium, High |
| last_updated | TIMESTAMP | Last score update |

### Notes

Supports customer segmentation and financial risk assessment.

---

## 5.15 Churn Prediction

### Purpose

Stores customer churn predictions generated by machine learning models.

### Primary Key

churn_prediction_id

### Foreign Key

- customer_id

### Related Tables

- Customer

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| churn_prediction_id | VARCHAR | Unique prediction identifier |
| customer_id | VARCHAR | Customer reference |
| churn_probability | DECIMAL | Probability of churn |
| prediction | VARCHAR | Likely to Churn / Retained |
| prediction_date | DATE | Prediction date |

### Notes

Used to identify customers at risk of leaving and support customer retention strategies.

---

## 5.16 Fraud Investigation

### Purpose

Stores investigation records for transactions flagged as potentially fraudulent.

### Primary Key

investigation_id

### Foreign Key

- fraud_prediction_id
- transaction_id

### Related Tables

- Fraud Prediction
- Transaction

### Key Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| investigation_id | VARCHAR | Unique investigation identifier |
| fraud_prediction_id | VARCHAR | Fraud prediction reference |
| transaction_id | VARCHAR | Transaction reference |
| investigation_status | VARCHAR | Open, Under Review, Closed |
| investigation_result | VARCHAR | Fraud Confirmed, Genuine Transaction |
| investigation_date | DATE | Investigation completion date |
| investigator_notes | VARCHAR | Investigation remarks |

### Notes

Tracks the outcome of fraud investigations and supports fraud operations.


----End of Document---
