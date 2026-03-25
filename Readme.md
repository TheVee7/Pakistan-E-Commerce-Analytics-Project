# 📊 Pakistan E-Commerce Analytics Project

## 🔍 Overview
This project analyzes a large-scale e-commerce dataset (~500K records) to uncover key drivers of order completion, revenue leakage, and customer behavior. The objective is to generate actionable insights that improve conversion rates and optimize business performance.

---

## 🎯 Business Problem
Despite strong order volume, the platform suffers from a **low order completion rate (~53%)**, leading to significant **revenue leakage (~₨3.39B)**.

### Key Questions:
- Why are orders not completing?
- What factors influence conversion?
- How can revenue leakage be reduced?

---

## 📁 Dataset
- **Source:** Kaggle  
- **Size:** ~500,000 rows, 21 features  
- **Key Features:**
  - Order Status
  - Category
  - Payment Method
  - Discount Amount
  - Customer ID
  - Revenue Metrics  

---

## 🛠️ Tools & Technologies
- **SQL (MySQL)** → Data querying & analysis  
- **Python (Pandas, Matplotlib)** → Data processing & analysis  
- **Power BI** → Dashboard & visualization  
- **Excel** → Data cleaning  

---

## 🔎 Key Analysis Performed

### 1. Order Completion Analysis
- Calculated overall completion rate  
- Compared completion rates across categories  

### 2. Revenue Leakage Analysis
- Identified revenue lost due to cancellations  
- Analyzed revenue contribution by order status  

### 3. Customer Behavior Analysis
- Segmented repeat vs one-time customers  
- Compared average spending patterns  

### 4. Discount Strategy Analysis
- Evaluated impact of discounts on completion rates  
- Identified optimal discount ranges  

### 5. Payment Method Analysis
- Compared success rates across payment methods  
- Identified high-failure digital payment systems  

---

## 📈 Key Findings

### 🔴 Low Completion Rate = Core Issue
- Only ~53% of orders are completed  
- ~47% of orders fail  
- Estimated revenue loss: **₨3.39 Billion**

---

### 🎯 Discounts Are Not Always Effective
| Discount Range | Completion Rate |
|---------------|----------------|
| 0%            | 54.12%         |
| 1–10%         | 45.79%         |
| 10–20%        | 54.25%         |
| 20%+          | 56.53%         |

➡️ Small discounts (1–10%) reduce completion rates  

---

### 📱 High Revenue but Low Conversion Category
- **Mobiles & Tablets**
  - Highest revenue contributor  
  - Low completion rate (~43%)  
- Potential: Unlock additional revenue (~₨115M+) by improving conversion  

---

### 💳 Payment Failure = Major Bottleneck
- Many digital payment methods have <50% completion rates  
- ~₨3.34B revenue loss linked to failed transactions  
- Cash on Delivery performs best  

---

## 📊 Business Recommendations

### 💳 Payment Optimization
- Improve payment gateway reliability  
- Reduce checkout friction  
- Introduce incentives for digital payments  

---

### 🛍️ Conversion Optimization (High-Value Items)
- Introduce EMI / installment options  
- Improve inventory visibility  
- Use price-match or limited-time checkout incentives  

---

### 🎯 Discount Strategy Optimization
- Avoid 1–10% discounts  
- Focus on 10–20% range  
- Use 20%+ discounts selectively for low-performing categories  

---

### 📦 Operational Improvements
- Reduce cancellations  
- Improve fulfillment and tracking  

---

## 📊 Dashboard
Power BI dashboard includes:
- Order status breakdown  
- Category performance  
- Payment success rates  
- Discount vs completion analysis  

---

## 🚀 Project Outcome
This project identifies **conversion inefficiency (not demand)** as the core business problem and provides a structured approach to recover lost revenue and improve performance.

---

## 🔗 Links

- 📊 Power BI Dashboard: [View Dashboard](https://vs8273-my.sharepoint.com/:u:/g/personal/vee_vs8273_onmicrosoft_com/IQCY4ntiIDKkT4RnAsXKwAXzAUYOLvnpdbog2DCiqA9Mcp8?e=caZTmK)

- 💼 LinkedIn: [Varun Dev Sharma](https://www.linkedin.com/in/varun-dev-sharma-b88260259/)
