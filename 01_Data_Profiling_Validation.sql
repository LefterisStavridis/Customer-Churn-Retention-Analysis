USE CustomerChurnAnalytics

-- Check table sizes and unique IDs

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers
FROM dbo.Customer_Demographics;


SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers
FROM dbo.Customer_Location;


SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers
FROM dbo.Customer_Services;


SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers
FROM dbo.Customer_Status;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Zip Code]) AS Unique_Zipcodes
FROM dbo.Zip_Population;


-- Check for missing matches between tables

SELECT 
    d.[Customer ID]
FROM dbo.Customer_Demographics AS d
LEFT JOIN dbo.Customer_Services AS se
    ON d.[Customer ID] = se.[Customer ID]
WHERE se.[Customer ID] IS NULL;

SELECT 
    d.[Customer ID]
FROM dbo.Customer_Demographics AS d
LEFT JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
WHERE st.[Customer ID] IS NULL;

SELECT 
    d.[Customer ID]
FROM dbo.Customer_Demographics AS d
LEFT JOIN dbo.Customer_Location AS l
    ON d.[Customer ID] = l.[Customer ID]
WHERE l.[Customer ID] IS NULL;

SELECT
    l.[Zip Code]
FROM dbo.Customer_Location AS l
LEFT JOIN dbo.Zip_Population AS z
    ON l.[Zip Code] = z.[Zip Code]
WHERE z.[Zip Code] IS NULL;


-- Check demographic fields

-- Check ranges

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age,
    MIN([Number of Dependents]) AS Min_Dependents,
    MAX([Number of Dependents]) AS Max_Dependents
FROM dbo.Customer_Demographics;


-- Check missing values

SELECT
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
    SUM(CASE WHEN [Under 30] IS NULL THEN 1 ELSE 0 END) AS Null_Under30,
    SUM(CASE WHEN [Senior Citizen] IS NULL THEN 1 ELSE 0 END) AS Null_SeniorCitizen,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Null_Married,
    SUM(CASE WHEN Dependents IS NULL THEN 1 ELSE 0 END) AS Null_Dependents,
    SUM(CASE WHEN [Number of Dependents] IS NULL THEN 1 ELSE 0 END) AS Null_NumberOfDependents
FROM dbo.Customer_Demographics;


-- Check age and Under 30

SELECT
    COUNT(CASE
        WHEN Age < 30 AND [Under 30] <> 'Yes' THEN 1
        WHEN Age >= 30 AND [Under 30] <> 'No' THEN 1
    END) AS Under30_Mismatches
FROM dbo.Customer_Demographics;


-- Check age and Senior Citizen

SELECT
    COUNT(CASE
        WHEN Age < 65 AND [Senior Citizen] <> 'No' THEN 1
        WHEN Age >= 65 AND [Senior Citizen] <> 'Yes' THEN 1
    END) AS SeniorCitizen_Mismatches
FROM dbo.Customer_Demographics;


-- Check dependents

SELECT
    COUNT(CASE
        WHEN [Number of Dependents] = 0 AND Dependents = 'Yes' THEN 1
        WHEN [Number of Dependents] > 0 AND Dependents = 'No' THEN 1
    END) AS Dependent_Mismatches
FROM dbo.Customer_Demographics;

-- Check location data

-- Check ranges

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    COUNT(DISTINCT City) AS Unique_Cities,
    COUNT(DISTINCT [Zip Code]) AS Unique_Zipcodes,
    MIN(Latitude) AS Min_Latitude,
    MAX(Latitude) AS Max_Latitude,
    MIN(Longitude) AS Min_Longitude,
    MAX(Longitude) AS Max_Longitude
FROM dbo.Customer_Location;


-- Check missing values

SELECT
    SUM(CASE WHEN [Location ID] IS NULL THEN 1 ELSE 0 END) AS Null_Location_ID,
    SUM(CASE WHEN [Customer ID] IS NULL THEN 1 ELSE 0 END) AS Null_Customer_ID,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Null_Country,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS Null_State,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Null_City,
    SUM(CASE WHEN [Zip Code] IS NULL THEN 1 ELSE 0 END) AS Null_Zip_Code,
    SUM(CASE WHEN [Lat Long] IS NULL THEN 1 ELSE 0 END) AS Null_Lat_Long,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Null_Latitude,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Null_Longitude
FROM dbo.Customer_Location;

-- Check population data

-- Check ranges

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Zip Code]) AS Unique_Zipcodes,
    MIN(Population) AS Min_Population,
    MAX(Population) AS Max_Population
FROM dbo.Zip_Population;


-- Check missing values

SELECT
    SUM(CASE WHEN ID IS NULL THEN 1 ELSE 0 END) AS Null_ID,
    SUM(CASE WHEN [Zip Code] IS NULL THEN 1 ELSE 0 END) AS Null_Zip_Code,
    SUM(CASE WHEN Population IS NULL THEN 1 ELSE 0 END) AS Null_Population
FROM dbo.Zip_Population;


-- Check service data

-- Check ranges

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    MIN([Tenure in Months]) AS Min_Tenure,
    MAX([Tenure in Months]) AS Max_Tenure,
    MIN([Monthly Charge]) AS Min_Monthly_Charge,
    MAX([Monthly Charge]) AS Max_Monthly_Charge,
    MIN([Total Revenue]) AS Min_Total_Revenue,
    MAX([Total Revenue]) AS Max_Total_Revenue
FROM dbo.Customer_Services;


-- Check missing values

SELECT
    SUM(CASE WHEN [Customer ID] IS NULL THEN 1 ELSE 0 END) AS Null_Customer_ID,
    SUM(CASE WHEN [Tenure in Months] IS NULL THEN 1 ELSE 0 END) AS Null_Tenure,
    SUM(CASE WHEN [Contract] IS NULL THEN 1 ELSE 0 END) AS Null_Contract,
    SUM(CASE WHEN [Payment Method] IS NULL THEN 1 ELSE 0 END) AS Null_Payment_Method,
    SUM(CASE WHEN [Internet Service] IS NULL THEN 1 ELSE 0 END) AS Null_Internet_Service,
    SUM(CASE WHEN [Monthly Charge] IS NULL THEN 1 ELSE 0 END) AS Null_Monthly_Charge,
    SUM(CASE WHEN [Total Charges] IS NULL THEN 1 ELSE 0 END) AS Null_Total_Charges,
    SUM(CASE WHEN [Total Refunds] IS NULL THEN 1 ELSE 0 END) AS Null_Total_Refunds,
    SUM(CASE WHEN [Total Revenue] IS NULL THEN 1 ELSE 0 END) AS Null_Total_Revenue
FROM dbo.Customer_Services;


-- Check internet service and type

SELECT
    COUNT(CASE
        WHEN [Internet Service] = 'No' AND [Internet Type] <> 'None' THEN 1
        WHEN [Internet Service] = 'Yes' AND [Internet Type] = 'None' THEN 1
    END) AS Internet_Type_Mismatches
FROM dbo.Customer_Services;


-- Check internet service fields

SELECT
    COUNT(*) AS Mismatches
FROM dbo.Customer_Services
WHERE [Internet Service] = 'No'
  AND (
      [Online Security] = 'Yes'
      OR [Online Backup] = 'Yes'
      OR [Device Protection Plan] = 'Yes'
      OR [Premium Tech Support] = 'Yes'
      OR [Streaming TV] = 'Yes'
      OR [Streaming Movies] = 'Yes'
      OR [Streaming Music] = 'Yes'
      OR [Unlimited Data] = 'Yes'
  );

-- Check churn data

-- Check ranges

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    MIN([Satisfaction Score]) AS Min_Satisfaction_Score,
    MAX([Satisfaction Score]) AS Max_Satisfaction_Score,
    MIN([Churn Score]) AS Min_Churn_Score,
    MAX([Churn Score]) AS Max_Churn_Score,
    MIN(CLTV) AS Min_CLTV,
    MAX(CLTV) AS Max_CLTV
FROM dbo.Customer_Status;


-- Check status and churn label

SELECT
    [Customer Status],
    [Churn Label],
    COUNT(*) AS Total_Customers
FROM dbo.Customer_Status
GROUP BY
    [Customer Status],
    [Churn Label]
ORDER BY
    [Customer Status],
    [Churn Label];


-- Check churn reason and category

SELECT
    [Churn Label],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN [Churn Reason] IS NULL THEN 1 ELSE 0 END) AS Null_Reasons,
    SUM(CASE WHEN [Churn Category] IS NULL THEN 1 ELSE 0 END) AS Null_Categories
FROM dbo.Customer_Status
GROUP BY [Churn Label];


