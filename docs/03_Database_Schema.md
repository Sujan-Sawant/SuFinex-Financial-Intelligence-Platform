# Database Schema

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

The SuFinex Financial Intelligence Platform uses PostgreSQL as its relational database management system.

The database is designed to support multi-tenant financial institutions by storing customer, account, transaction, merchant, and AI-generated intelligence data in a structured and scalable architecture.

The schema follows normalization principles to minimize data redundancy while maintaining efficient query performance for analytics and machine learning workloads.

---

# 2. Database Information

| Property | Value |
|----------|-------|
| Database Name | sufinex |
| Database Type | PostgreSQL |
| Schema | public |
| Architecture | Multi-Tenant |
| Primary Business Entity | Institution |
| Core Fact Table | Transactions |

---

# 3. Table Creation Order

To maintain referential integrity, tables should be created in the following order:

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
13. Fraud Prediction
14. Risk Score
15. Churn Prediction
16. Fraud Investigation

---

# 4. Relationship Summary

The database consists of sixteen relational tables connected through primary and foreign keys.

Key relationships include:

- One Institution can have multiple Customers.
- One Customer can own multiple Accounts.
- One Account can have multiple Cards.
- One Customer can have one Credit Profile.
- One Customer can have multiple Loans.
- One Institution can have multiple Merchants.
- One Transaction belongs to one Customer, Account, Merchant, Payment Method, Device, and Location.
- One Transaction can generate one Fraud Prediction.
- One Customer can have multiple Risk Score records.
- One Customer can have multiple Churn Prediction records.
- Fraud Investigation records are linked to Fraud Predictions and Transactions.

---
-- ER Diagram craeted using dbdiagram.io  https://dbdiagram.io/d/SuFinex-Financial-Intelligence-Platform-6a76132a829f06bdc8a8a3ac
