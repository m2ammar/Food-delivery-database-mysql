# 🍔 Food Delivery Database — MySQL

A relational database modeled after real-world food delivery platforms like Foodpanda, built using MySQL. Designed to simulate core business operations including order management, payments, rider assignments, and customer reviews.

## 📦 Database Schema

The database consists of 9 tables:

| Table | Description |
|---|---|
| `customers` | Registered app users |
| `restaurants` | Listed restaurants with cuisine and location |
| `menu_categories` | Food categories per restaurant |
| `menu_items` | Individual items with prices |
| `riders` | Delivery riders and vehicle types |
| `orders` | Customer orders with status tracking |
| `order_items` | Line items within each order |
| `payments` | Payment method and status per order |
| `reviews` | Customer ratings for restaurants and riders |

## 🔗 Key Relationships
- Each order belongs to a customer, restaurant and rider
- Menu items belong to categories which belong to restaurants
- Payments and reviews are linked one-to-one with orders

## 📊 Queries Included
- View all open restaurants
- Orders with customer and restaurant details
- Total spending per customer
- Most popular restaurants by order count
- Average restaurant ratings
- Full order details with rider assignments (LEFT JOIN)
- Customers with more than one order (Subquery)
- Total revenue per restaurant
- All pending/undelivered orders

## 🛠 Tools Used
- MySQL 8.0
- MySQL Workbench

## 📍 Context
Built as a portfolio project during my BScs Data Science studies at KSBL, Karachi.

# Muhammad Ammar
