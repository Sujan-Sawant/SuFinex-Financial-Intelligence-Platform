# Synthetic Data Strategy

## 1. Purpose

SuFinex is designed as an AI-powered Financial Intelligence Platform for banks, fintechs, and payment companies.

Since real financial transaction data is sensitive and cannot be used for this project, SuFinex will use **synthetically generated data** that simulates realistic financial behavior.

The objective is to create data that is suitable for:

- Transaction analysis
- Fraud detection
- Customer risk scoring
- Churn prediction
- Financial intelligence
- Fraud investigation
- Analytics and reporting

---

## 2. Data Generation Approach

Synthetic data will be generated programmatically using Python and stored in PostgreSQL.

### Technology

- Python
- Faker
- NumPy
- Pandas
- PostgreSQL

### Data Flow

Python Data Generator  
↓  
Synthetic Financial Data  
↓  
PostgreSQL  
↓  
SuFinex Intelligence Layer  
↓  
Analytics & AI Models

---

## 3. Generation Principles

The data will not be completely random.

Synthetic records will maintain:

- Valid primary and foreign key relationships
- Realistic customer behavior
- Realistic transaction amounts
- Consistent dates and timestamps
- Valid financial ranges
- Realistic payment behavior
- Different customer activity patterns
- Normal and abnormal transaction behavior

The objective is to make the dataset behave similarly to a simplified real-world financial environment.

---

## 4. Data Generation Order

Data will be generated according to table dependencies:

1. Institution
2. Customer
3. Account
4. Card
5. Credit Profile
6. Loan
7. Merchant
8. Payment Method
9. Device
10. Location
11. Support Ticket
12. Transactions
13. Fraud Predictions
14. Risk Scores
15. Churn Predictions
16. Fraud Investigations

This order ensures that required foreign-key relationships can be maintained.

---

## 5. Behavioral Patterns

The synthetic dataset will include different customer and transaction behaviors.

Examples include:

- Low, medium, and high transaction activity
- Different spending patterns
- Different account balances
- Different credit profiles
- Regular and irregular transaction timing
- Domestic and location-based transactions
- Normal payment behavior
- Unusual transaction behavior

Fraud-related records will be generated using behavioral signals rather than purely random labels.

---

## 6. Fraud Simulation

The dataset will contain both legitimate and suspicious transactions.

Potential fraud signals may include:

- Unusually high transaction amount
- Rapid successive transactions
- Unusual transaction location
- New or unfamiliar device
- Unusual transaction timing
- High transaction frequency
- Unusual merchant activity
- Multiple risk indicators occurring together

These signals will later support the development and evaluation of SuFinex fraud intelligence capabilities.

---
