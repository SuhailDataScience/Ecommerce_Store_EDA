# 🛒 E-Commerce Store — SQL EDA Project

A complete **Exploratory Data Analysis (EDA)** of a Brazilian e-commerce dataset using MySQL. The project covers database design, data modelling, and business-focused SQL analytics across 8 interrelated tables with ~99K orders.

---

## 🗄️ Database Schema

The relational schema consists of **8 tables** with proper primary/foreign key constraints.

```
customers ──< orders ──< order_items >── products
                  │
                  ├──< order_payments
                  └──< order_reviews

sellers ──< order_items
geolocation (reference table)
```

| Table | Rows | Description |
|---|---|---|
| `customers` | 99,441 | Customer demographics & location |
| `geolocation` | 1,000,163 | Zip code to lat/lng mapping |
| `orders` | 99,441 | Order lifecycle & timestamps |
| `order_items` | 112,650 | Line items with price & freight |
| `order_payments` | 103,886 | Payment method & installments |
| `order_reviews` | 104,719 | Review scores & comments |
| `products` | 32,951 | Product specs & category |
| `sellers` | 3,095 | Seller location info |

---

## 🔍 Analysis Performed

### 1. 🏆 Top 10 Best-Selling Product Categories
Identifies categories by total sales revenue and order volume for delivered orders.

### 2. 📅 Monthly Order & Revenue Trend
Breaks down total orders and revenue month-by-month to reveal seasonality and growth patterns.

### 3. 💰 Average Order Value by Category
Compares average spend per order across all product categories.

### 4. 📊 Order Status Distribution
Calculates the percentage share of each order status (delivered, cancelled, shipped, etc.).

### 5. 💳 Most Popular Payment Methods
Ranks payment types by total transaction count and total value spent.

### 6. 🧍 Customer Lifetime Value (CLV)
Computes total spend, order frequency, average order value, and customer lifespan for every customer.

### 7. ❌ Products with Highest Cancellation Rate
Identifies product categories with the most cancelled orders.

### 8. 📈 Monthly Revenue Trend with Cumulative Revenue
Uses a window function (`SUM() OVER`) to track running cumulative revenue alongside monthly figures.

### 9. ⭐ Average Product Rating by Category
Aggregates review scores per product category to surface quality signals.

### 10. 🎯 Customer Segmentation (RFM Analysis)
Segments customers into **Diamond / Gold / Silver / Bronze** tiers using Recency, Frequency, and Monetary (RFM) metrics.

---

## 🛠️ Tech Stack

- **Database**: MySQL 8.0+
- **Language**: SQL (DDL + DML + Window Functions + CTEs)
- **Concepts Used**: Joins, Subqueries, CTEs, Aggregate Functions, Window Functions, Date Functions, CASE statements

---

## 💡 Key Insights 

- The majority of orders (~97%) have a **"delivered"** status, indicating strong fulfilment.
- **Credit card** is the dominant payment method, accounting for the largest share of total spend.
- RFM segmentation reveals a large **Bronze** base with opportunity to convert to Gold/Diamond tiers.
- A handful of product categories drive a disproportionate share of total revenue.
- Monthly revenue shows an overall upward trend with clear seasonal peaks.

---

## 👤 Author

**Suhail**
- GitHub: https://github.com/SuhailDataScience

