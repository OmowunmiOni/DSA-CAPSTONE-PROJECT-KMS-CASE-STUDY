--QUESTION 1- PRODUCT CATEGORY WITH HIGHEST SALES
SELECT
      [Product Category],
      SUM(Sales) AS TotalSales
FROM
   ['KMS Sql Case Study$']
GROUP BY
    [Product Category]
ORDER BY
       TotalSales DESC;
-- FROM THE RESULT TECHNOLOGY HAS THE HIGHEST SALES


-- QUESTION 2- TOP 3 AND BOTTOM 3 REGIONS IN TERMS OF SALES
--BOTTOM 3 REGIONS
SELECT
   Region,
   SUM(Sales) AS TotalSales
FROM
   ['KMS Sql Case Study$']
GROUP BY 
    Region
ORDER BY
     TotalSales ASC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

--TOP 3 REGIONS
SELECT
   Region,
   SUM(Sales) AS TotalSales
FROM
   ['KMS Sql Case Study$']
GROUP BY 
    Region
ORDER BY
     TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;


--QUESTION 3- Total sales of Appliances in Ontario 
SELECT
     SUM(Sales) AS TotalSales
FROM
    ['KMS Sql Case Study$']
WHERE 
    [Product Sub-Category]='Appliances'
    AND Province='Ontario';


-- QUESTION 4- bottom 10 customers

SELECT TOP 10
   [Customer Name],
   SUM(Sales) AS TotalSales
FROM
   ['KMS Sql Case Study$']
GROUP BY
    [Customer Name]
ORDER BY
    TotalSales ASC;

-- Recommendation According To The Result:
-- The bottom 10 customers contribute the least to revenue.
-- To boost revenue from these customers, KMS should:
-- 1. Offer targeted promotions and discounts.
-- 2. Introduce loyalty programs to increase customer retention.
-- 3. Personalize marketing based on past purchase behavior.
-- 4. Reach out to gather feedback and understand why spending is low.
-- 5. Bundle products to increase average order size.


--QUESTION 5- ship mode with most shipping cost
SELECT
    [Ship Mode],
    SUM([Shipping Cost]) AS TotalShippingCost
FROM
   ['KMS Sql Case Study$']
GROUP BY
  [Ship Mode]
ORDER BY
   TotalShippingCost DESC;


--QUESTION 6
-- Top 10 most valuable customers by profit
SELECT 
    [Customer Name], 
    SUM(Profit) AS TotalProfit,
    SUM(Sales) AS TotalSales
FROM 
    ['KMS Sql Case Study$']
GROUP BY 
    [Customer Name]
ORDER BY 
    TotalProfit DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- What products/services they purchase
SELECT 
    [Customer Name], 
    [Product Category], 
    [Product Sub-Category], 
    COUNT(*) AS PurchaseCount,
    SUM(Sales) AS TotalSales
FROM 
    ['KMS Sql Case Study$']
WHERE 
    [Customer Name] IN (
        SELECT TOP 10 [Customer Name]
        FROM ['KMS Sql Case Study$']
        GROUP BY [Customer Name]
        ORDER BY SUM(Profit) DESC
    )
GROUP BY 
    [Customer Name], [Product Category], [Product Sub-Category]
ORDER BY 
    [Customer Name], PurchaseCount DESC;


--QUESTION 7- small business customer with the highest sales
SELECT 
    [Customer Name], 
    SUM(Sales) AS TotalSales
FROM 
    ['KMS Sql Case Study$']
WHERE 
    [Customer Segment] = 'Small Business'
GROUP BY 
    [Customer Name]
ORDER BY 
    TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


--QUESTION 8- Corporate Customer that placed the most number of orders in 2009 – 2012
SELECT 
    [Customer Name], 
    COUNT(DISTINCT [Order ID]) AS OrderCount
FROM 
    ['KMS Sql Case Study$']
WHERE 
    [Customer Segment] = 'Corporate'
    AND YEAR([Order Date]) BETWEEN 2009 AND 2012
GROUP BY 
    [Customer Name]
ORDER BY 
    OrderCount DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


--QUESTION 9- the most profitable consumer customer
SELECT 
    [Customer Name], 
    SUM(Profit) AS TotalProfit
FROM 
    ['KMS Sql Case Study$']
WHERE 
    [Customer Segment] = 'Consumer'
GROUP BY 
    [Customer Name]
ORDER BY 
    TotalProfit DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


--QUESTION 11- Average shipping cost and total sales per Order Priority and Ship Mode
SELECT 
    [Order Priority], 
    [Ship Mode], 
    COUNT(*) AS OrderCount,
    AVG([Shipping Cost]) AS AvgShippingCost,
    SUM([Shipping Cost]) AS TotalShippingCost
FROM 
    ['KMS Sql Case Study$']
GROUP BY 
    [Order Priority], [Ship Mode]
ORDER BY 
    [Order Priority], AvgShippingCost DESC;

-- Yes, the company spent shipping costs based on the Order Priority.
-- For Critical and High priority orders, they used faster but costlier methods like Regular Air and Delivery Truck,
-- which is reasonable for time-sensitive deliveries.
-- However, for Medium and Low priority orders, they relied heavily on Delivery Truck,
-- which, while slower, is still one of the more expensive options.
-- -- The company can consider charging customers a premium for Express Air shipping,
-- especially for Critical and High-priority orders.
-- Since these customers need their orders urgently, they are likely willing to pay more for faster delivery.
-- This approach would not only recover the high cost of Express Air but also generate additional revenue.
-- It aligns value with price: the faster the delivery, the higher the charge.
-- This strategy encourages customers to select priority levels intentionally,
-- and helps the company optimize both delivery speed and profit.


