/* QUESTION 1
Enter into Canvas the number of products that are Grey or Silver in colour, according to the "Color" column. */

SELECT Color
FROM SalesLT.Product
WHERE Color LIKE ‘Grey’ OR Color LIKE ‘Silver’

-- answer: 51

/* QUESTION 2
Find how many products weigh more than 1.5 kilograms and have a list price of at least $4293.92. Assume product weights are given in grams.
Enter into Canvas the number of products found above. */

SELECT Weight, ListPrice
FROM SalesLT.Product
WHERE Weight > 1500 AND ListPrice >= 4293.92

-- answer: 3

/* QUESTION 3
Using a product's name only, find how many products are Blue or Red in colour.
Enter into Canvas the number of products found above. */

SELECT Name
FROM  SalesLT.Product
WHERE LOWER(Name) LIKE ‘%blue%’ OR LOWER(Name) LIKE ‘% red%’

-- answer: 61

/* QUESTION 4
Find how many products satisfy the following criteria:
-Does not have a single colour (i.e. has multiple colours or no (known) colour)
-Has a weight
-Has no size
Enter into Canvas the number of products found above. */

SELECT Color, Size, Weight
FROM  SalesLT.Product
WHERE (Color IS NULL OR Color LIKE ‘Multi’ OR Color LIKE ‘No Colour’) AND Weight IS NOT NULL AND Size IS NULL

-- answer: 5

/* QUESTION 5
Enter into Canvas the number of products listed for sale in 2005 which have not yet been discontinued nor have they been ended. */

SELECT SellStartDate, SellEndDate, DiscontinuedDate
FROM  SalesLT.Product
WHERE Year(SellStartDate) = 2005 AND DiscontinuedDate IS NULL AND SellEndDate IS NULL

-- answer: 12

/* QUESTION 6
Enter into Canvas the number of customer addresses in the USA that are registered as billing or shipping addresses.*/

SELECT a.CountryRegion,
	ca.CustomerID,
	ca.AddressType
FROM SalesLT.CustomerAddress ca
	INNER JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
WHERE a.CountryRegion LIKE ‘United States’ AND (ca.AddressType LIKE ‘Billing’ OR ca.AddressType LIKE ‘Shipping’

-- answer: 64

/* QUESTION 7
Write a query to return the following result set:
Columns:
- CompanyName
- SalesOrderNumber
- SalesOrderDetailID
- Product Name
- ProductModel Name

Rows:
- Order details for products which are Tires (according to their model name), with the order number and customer's company name.
Sort:
- SalesOrderDetailID ascending
There should be 20 rows.
Enter into Canvas the SalesOrderNumber in row 8 from the query's result. */

SELECT c.CompanyName,
	soh.SalesOrderNumber,
	sod.SalesOrderDetailID,
	p.Name AS ProductName,
	pm.Name AS ProductModelName
FROM SalesLT.Customer c
	INNER JOIN SalesLT.SalesOrderHeader soh
	ON c.CustomerID = soh.CustomerID
	INNER JOIN SalesLT.SalesOrderDetail sod
	ON soh.SalesOrderID = sod.SalesOrderID
	INNER JOIN SalesLT.ProductModel pm
	ON p.ProductModelID = pm.ProductModelID
WHERE LOWER(pm.Name) LIKE ‘% tire’
ORDER BY sod.SalesOrderDetailID ASC

-- answer: SO80005

/* QUESTION 8
Write a query to return the following result set:
Columns:
- SalesOrderDetailID
- OrderQty
- UnitPrice
- LineTotal
- Name (from Product)
- Description (from ProductDescription)

Rows:
- Sale order details with their products and products' descriptions
- Ordered products without discounts only
- English product descriptions only

Sort:
- Order the result set by SalesOrderDetailID ascending

From the result, find the description in row 467 and enter into Canvas its rowguid value. */

SELECT sod.SalesOrderDetailID,
	sod.OrderQty,
	sod.UnitPrice,
	sod.LineTotal,
	sod.UnitPriceDiscount,
	p.Name AS ProductName,
	pd.rowguid,
	pd.Description,
	pmpd.Culture
FROM SalesLT.SalesOrderDetail sod
	INNER JOIN SalesLT.Product p
	ON sod.ProductID = p.ProductID
	INNER JOIN SalesLT.ProductModel pm
	ON p.ProductModelID = pm.ProductModelID
	INNER JOIN SalesLT.ProductModelProductDescription pmpd
	ON pm.ProductModelID = pmpd.ProductModelID
	INNER JOIN SalesLT.ProductDescription pd
	ON pmpd.ProductDescriptionID = pd.ProductDescriptionID
WHERE sod.UnitPriceDiscount = 0.00 AND pmpd.Culture = ‘en’
ORDER BY sod.SalesOrderDetailID ASC

-- answer: 3DC76714-7572-4547-9D79-ABB708950B2C

/* QUESTION 9
Find all addresses in the USA which are not assigned to a customer. Order your result ascendingly by AddressID.
You are encouraged to use an outer join in your query to answer this question.
Enter into Canvas the name of the city of the address in row 43. */

SELECT c.CustomerID,
	a.AddressID,
	a.AddressLine1,
	a.CountryRegion,
	a.City
FROM SalesLT.Customer c
	RIGHT JOIN SalesLT.CustomerAddress ca
	ON c.CustomerID = ca.CustomerID
	RIGHT JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
WHERE a.CountryRegion LIKE ‘United States’ AND c.CustomerID IS NULL
ORDER BY a.AddressID ASC

-- answer: San Mateo

/* QUESTION 10
Find all customers who have ever ordered products categorised as any of the following four categories:
1. Bottles and Cages
2. Jerseys
3. Mountain Bikes
4. Shorts
Enter into Canvas the number of unique (different) customers found in the list above. */

SELECT c.CustomerID,
	COUNT(DISTINCT pc.Name) AmountOfProduct
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
INNER JOIN SalesLT.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN SalesLT.Product p
ON sod.ProductID = p.ProductID
INNER JOIN SalesLT.ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = ‘Bottles and Cages’ OR pc.Name = ‘Jerseys’ OR pc.Name = ‘Mountain Bikes’ OR pc.Name = ‘Shorts’
GROUP BY c.CustomerID
HAVING COUNT(DISTINCT pc.Name) > 0

-- answer: 45

/* QUESTION 11
Attempt this question without using any joins.
Calculate the number of addresses in each city. Assume city names are unique across countries. Sort your result descendingly by the address count. If there are multiple cities with the same count then order those cities alphabetically.
Enter into Canvas the row number of "Arlington". */

SELECT City,
	COUNT(AddressLine1) AddressCount
FROM SalesLT.Address
GROUP BY City
ORDER BY AddressCount DESC, City ASC

-- answer: 63

/* QUESTION 12
Attempt this question without using any joins.
Find all sales orders containing more than nine different products.
Enter into Canvas the number of orders found above. */

SELECT SalesOrderID,
	COUNT(DISTINCT ProductID) AS ProductCount
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(DISTINCT ProductID) > 9

-- answer: 38

/* QUESTION 13
Attempt this question without using any joins.
Find all sales orders containing at least fifteen units. The units can be made up of different products.
Enter into Canvas the number of orders found above. */

SELECT SalesOrderID,
	SUM(OrderQty) AS TotalUnits
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING (SUM OrderQty) >= 15

-- answer: 44

/* QUESTION 14
What is the total weight in kilograms of orders due in July 2017, or September 2017, or November 2017? Only include orders which used an unknown shipping method.
Enter into Canvas the total weight found above, rounded and padded to 2dp.*/

SELECT ROUND(SUM(p.Weight * sod.OrderQty), 2) AS TotalWeightGrams
FROM SalesLT.SalesOrderHeader soh
	JOIN SalesLT.SalesOrderDetail sod
	ON soh.SalesOrderID = sod.SalesOrderID
	JOIN SalesLT.Product p
	ON p.ProductID = sod.ProductID
WHERE (p.Weight IS NOT NULL AND soh.ShipMethod = ‘Unknown’)
	AND (soh.DueDate >= ‘2017-07-01) AND soh.DueDate < ‘2017-08-01’)
	OR (soh.DueDate >= ‘2017-09-01) AND soh.DueDate < ‘2017-10-01’)
	OR (soh.DueDate >= ‘2017-11-01) AND soh.DueDate < ‘2017-12-01’)

-- answer: 2964.99

/* QUESTION 15
For all orders placed in 2017, calculate the revenue received for each product-colour (according to the Color column). Revenue is determined by using the product unit prices in the order, and it includes any applied discounts. Treat unknown (NULL) and "No Colour" as the same colour; treat "Multi" as its own colour. Sort your result by revenue descendingly.
Enter into Canvas the sum of the revenue amounts in rows 5 to 7 (inclusive), rounded and padded to 2dp. */

SELECT ROUND(SUM(Revenue), 2) AS SumOfRevenue
FROM (
    SELECT
        CASE
            WHEN p.Color IS NULL THEN ‘Unknown’
            WHEN p.Color = ‘No Colour’ THEN ‘Unknown’
            ELSE p.Color
        END,
        SUM(sod.OrderQty * sod.UnitPrice * (1 - sod.UnitPriceDiscount)) AS Revenue
    FROM SalesLT.SalesOrderHeader soh
        JOIN SalesLT.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
        JOIN SalesLT.Product p
        ON sod.Product = p.ProductID
    WHERE YEAR(OrderDate) = 2017
    GROUP BY CASE
    WHEN p.Color IS NULL THEN ‘Unknown’
            WHEN p.Color = ‘No Colour’ THEN ‘Unknown’
            ELSE p.Color
        END
    ORDER BY Revenue DESC
    OFFSET 4 ROWS FETCH NEXT 3 ROWS ONLY  -- This limits the results to rows 5 to 7
) AS Subquery;

-- 633157.85

/* QUESTION 16
A sub-query is needed to answer this question. See the notes in the assignment specification document.
Write a query to return the following result set:
Columns:
- ProductCategoryID
- ProductCategoryName
- ParentProductCategoryID (NULL if the category has no parent)
- ParentSubCatCount: the number of subcategories the parent has; NULL or 0 if the category has no parent
Rows:
- All Product Categories with ID greater than 1000
Enter into Canvas the "answerToSubmit" value produced by this query:
SELECT SUM(ProductCategoryID + LEN(ProductCategoryName) + ParentProductCategoryID + ParentSubCatCount) AS answerToSubmit
FROM (
--paste your query's code here (this is the query you write which uses a sub-query).
) q16 */

SELECT SUM(ProductCategoryID + LEN(Name) + q16.ParentProductCategoryID + ParentSubCatCount) AS answerToSubmit
FROM (SELECT ParentProductCategoryID, COUNT(ProductCategoryID) AS ParentSubCatCount
	FROM SalesLT.ProductCategory
	WHERE ProductCategoryID > 1000
	GROUP BY ParentProductCategoryID
) q16 INNER JOIN SalesLT.ProductCategory pc
	ON q16.ParentProductCategoryID = pc.ParentProductCategoryID

-- answer: 160088

/* QUESTION 17
List all customers who have ordered less than $79,589.616 worth of products across all their orders (excluding tax and freight, but including discounts). Customers who have not placed an order are considered to have ordered $0.00.
Use an order header's SubTotal to determine a customer's order amount. Treat SubTotal as including discounts.
Enter into Canvas the number of customers in the list found above. */

SELECT COUNT(*) AS RowCount
FROM (
    SELECT c.CustomerID, SUM(soh.SubTotal) AS SubTotal
    FROM SalesLT.SalesOrderHeader soh
           RIGHT JOIN SalesLT.Customer c
                      ON soh.CustomerID = c.CustomerID
    GROUP BY c.CustomerID
    HAVING SUM(soh.SubTotal) < 79589.616
      OR SUM(soh.SubTotal) IS NULL
) AS Subquery;

-- answer: 823

/* QUESTION 18
How many units of products categorised as accessories have been ordered? Only include units that have been or will be shipped to the USA state of New Mexico.
Products belonging to sub-categories (a.k.a. child categories) of a parent category are considered products of that parent category.
E.g. products which belong to sub-categories of "Bikes" (such as "Road Bikes" and "Mountain Bikes") are also considered "bike" products. */

SELECT sod.OrderQty, soh.SalesOrderID, p.ProductID
FROM SalesLT.ProductCategory pc
	JOIN SalesLT.Product p
	ON pc.ProductCategoryID = p.ProductCategoryID
	JOIN SalesLT.SalesOrderHeader soh
	ON p.ProductID = soh.SalesOrderID
	JOIN SalesLT.Address a
	ON a.AddressID = soh.BillToAddressID
WHERE a.StateProvince = ‘New Mexico’ AND pc.ParentProductCategoryID = 4
GROUP BY p.ProductID, sod.OrderQty, soh.SalesOrderID

-- answer: 1

/* QUESTION 19
For each sales order, compute the cost of freight per unit (across all its products). Sort your result by the computed cost descendingly.
Enter into Canvas the cost found above for the order in row 52, padded and rounded to 2dp. */

SELECT NewTable.SalesOrderID, ROUND(soh.Freight / TotalQty, 2) AS FreightPerUnit
FROM (
	SELECT SalesOrderID, SUM(OrderQty) AS TotalQty
	FROM SalesLT.SalesOrderDetail
	GROUP BY SalesOrderID) NewTable
JOIN SalesLT.SalesOrderHeader soh
ON NewTable.SalesOrderID = soh.SalesOrderID
ORDER BY FreightPerUnit DESC

-- answer: 3.78

/* QUESTION 20
Find how many units of each product have been ordered as at 11:59:59pm, 31st January 2017. Only include products available for sale as at 11:59:59pm, 31st January 2017. Products available for sale are those which have begun to sell, and are not yet ended or discontinued.
Dates are provided in the SellStartDate, SellEndDate, and DiscontinuedDate columns.
From the resulting list, enter into Canvas how many unique ProductNumbers have exceeded 43 units. */

SELECT COUNT(*) AS NumberOfRows
FROM (
    SELECT sod.ProductID, SUM(sod.OrderQty) AS OrderQty
    FROM SalesLT.Product p
        JOIN SalesLT.SalesOrderDetail sod
        ON p.Product = sod.ProductID
        JOIN sod.SalesOrderID = soh.SalesOrderID
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh,OrderDate <= ‘2017-01-31 11:59:59’
        AND (p.SellEndDate IS NULL OR p.SellEndDate > ‘2017-01-31’)
        AND (p.DiscontinuedDate IS NULL OR p.DiscontinuedDate > ‘2017-01-31’)
        AND (p.SellStartDate < ‘2017-01-31’)
    GROUP BY sod.ProductID
    HAVING SUM(sod.OrderQty) > 43
) AS SubqueryAlias;

-- answer: 13










