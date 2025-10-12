# 🗂️ **Data Catalog — Gold Layer**

---

## 🧩 **1. `gold.dim_customer`**

**📝 Purpose:** *Stores customer details enriched with demographic and geographic data.*

| **Column Name** | **Data Type** | **Description** |
|------------------|---------------|-----------------|
| `customer_key` | `INT` | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id` | `INT` | Unique numerical identifier assigned to each customer. |
| `customer_number` | `NVARCHAR(50)` | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| `first_name` | `NVARCHAR(50)` | The customer’s first name, as recorded in the system. |
| `last_name` | `NVARCHAR(50)` | The customer’s last name or family name. |
| `gender` | `NVARCHAR(50)` | The customer’s gender (e.g., *Male*, *Female*, *n/a*). |
| `country` | `NVARCHAR(50)` | The country of residence for the customer (e.g., *Australia*). |
| `marital_status` | `NVARCHAR(50)` | The marital status of the customer (e.g., *Married*, *Single*). |
| `birthday` | `DATE` | The customer’s date of birth (`YYYY-MM-DD`). |
| `create_date` | `DATE` | The date and time when the customer record was created in the system. |

---

## 📦 **2. `gold.dim_products`**

**📝 Purpose:** *Contains detailed information about products, including category, pricing, and lifecycle metadata.*

| **Column Name** | **Data Type** | **Description** |
|------------------|---------------|-----------------|
| `product_key` | `INT` | Surrogate key uniquely identifying each product record in the dimension table. |
| `product_id` | `INT` | Unique numerical identifier assigned to each product. |
| `product_number` | `NVARCHAR(50)` | Alphanumeric identifier representing the product, used for referencing. |
| `product_name` | `NVARCHAR(100)` | The official name of the product. |
| `category_id` | `INT` | Identifier linking the product to its category. |
| `category` | `NVARCHAR(50)` | The product’s category (e.g., *Electronics*). |
| `subcategory` | `NVARCHAR(50)` | The product’s subcategory (e.g., *Mobile Phones*). |
| `maintenance` | `NVARCHAR(50)` | Indicates product maintenance type or cycle. |
| `cost` | `DECIMAL(10,2)` | The cost of the product. |
| `product_line` | `NVARCHAR(50)` | Product line or family name. |
| `start_date` | `DATE` | The date when the product was first introduced or made available. |

---

## 💰 **3. `gold.fact_sales`**

**📝 Purpose:** *Fact table that records all sales transactions, linking customers, products, and sales metrics.*

| **Column Name** | **Data Type** | **Description** |
|------------------|---------------|-----------------|
| `order_number` | `NVARCHAR(50)` | Unique identifier for each sales order. |
| `product_id` | `INT` | Foreign key referencing the sold product. |
| `customer_id` | `INT` | Foreign key referencing the customer who made the purchase. |
| `order_date` | `DATE` | The date when the order was placed. |
| `shipping_date` | `DATE` | The date when the order was shipped. |
| `due_date` | `DATE` | The expected or actual payment due date. |
| `sales_amount` | `DECIMAL(10,2)` | Total sales amount for the transaction. |
| `quantity` | `INT` | Number of items sold. |
| `price` | `DECIMAL(10,2)` | Price per item at the time of sale. |

---

### ⚙️ **Notes**

* All views belong to the **Gold Layer**, representing the **cleaned, standardized, and analytics-ready** datasets.  
* Data is aggregated and enriched from **Silver Layer** sources via transformation pipelines.  
* Ensures **referential integrity**, **data consistency**, and **business-friendly structure** for reporting and analytics.
