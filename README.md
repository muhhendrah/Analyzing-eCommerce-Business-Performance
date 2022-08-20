# Analyzing eCommerce Business Performance
---
*Tools : Google Sheets, PostgreSQL*

In a company, measuring business performance is very important to track, monitor, and assess the success or failure of various business processes. Therefore, in this project, we will analyze business performance for an eCommerce company, taking into account several business metrics, namely customer growth, product quality, and payment types.

## Data Preparation
---
Before we start to analyze, we need to prepare the dataset first. Below are the steps that I did to prepare the dataset.
1. Data Collecting : I collect data from the given resource in csv format. We have total 8 files with various number of fields.
2. Database Preparation : I create new database and new tables in PostgreSQL to store all of the data that we got by importing those data into each tables.
3. Generate Entity Relationship Diagram : In order to simplify our understanding about each tables relationship, I create Entity Relationship Diagram used PostgreSQL generate ERD tools.

## Analyzing eCommerce Business Performance
---
This analysis is divided into several sections to simplify the understanding:
1. Annual Customer Activity Growth Analysis
2. Annual Product Category Quality Analysis
3. Analysis of Annual Payment Type Usage

## Business Insights
---
1. We have a great user growth in 2016-2018, however mostly customers only buy once a year.
2. We have a great revenue growth in 2016-2018, the product category that most contribute to the annual revenue are Furniture Decor in 2016, Bed Bath Table in 2017, and Health Beauty in 2018.
3. Unfortunately total canceled order increased every year in 2016-2018, the product category with the most number of canceled order are Toys in 2016, Sports Leisure in 2017, and Health Beauty in 2018.
4. Among all of the payment methods, the credit card method has the highest usage increase every year, followed by Boleto and other methods with a significant value difference.

## Recommendations
---
1. Increase our customer engagement to get loyal customers.
2. Analyze popular product trends every year to be able to improve the quality of the products that are most in demand every year.
3. Further analyze why users canceled their order by asking their reason, so we can improve that user's problem.
4. Because credit card contributes to 75% of total transactions, we have to ensure customers have a good experience while they pay the order using a credit card.
