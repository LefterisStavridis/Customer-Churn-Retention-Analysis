USE CustomerChurnAnalytics;

-- Overall churn

SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN [Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN [Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Status;

-- Churn by tenure group

SELECT
    CASE
        WHEN se.[Tenure in Months] BETWEEN 1 AND 12 THEN '1-12 Months'
        WHEN se.[Tenure in Months] BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN se.[Tenure in Months] BETWEEN 25 AND 48 THEN '25-48 Months'
        WHEN se.[Tenure in Months] BETWEEN 49 AND 72 THEN '49-72 Months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate

FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    CASE
        WHEN se.[Tenure in Months] BETWEEN 1 AND 12 THEN '1-12 Months'
        WHEN se.[Tenure in Months] BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN se.[Tenure in Months] BETWEEN 25 AND 48 THEN '25-48 Months'
        WHEN se.[Tenure in Months] BETWEEN 49 AND 72 THEN '49-72 Months'
    END
ORDER BY Tenure_Group


-- Churn by internet type

SELECT
    se.[Internet Type],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY se.[Internet Type]
ORDER BY Churn_Rate DESC;


-- Check internet type within contract groups

SELECT
    se.[Internet Type],
    se.[Contract],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    se.[Internet Type],
    se.[Contract]
ORDER BY Churn_Rate DESC


-- Check average tenure by internet type

SELECT
    [Internet Type],
    AVG([Tenure in Months] * 1.0) AS Avg_Tenure
FROM dbo.Customer_Services
GROUP BY [Internet Type]
ORDER BY Avg_Tenure;


-- Churn by payment method

SELECT
    se.[Payment Method],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY se.[Payment Method]
ORDER BY Churn_Rate DESC;


-- Check payment method within contract groups

SELECT
    se.[Payment Method],
    se.[Contract],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    se.[Payment Method],
    se.[Contract]
ORDER BY Churn_Rate DESC;


-- Monthly charge by churn status

SELECT
    st.[Churn Label],
    AVG(se.[Monthly Charge]) AS Avg_Monthly_Charge
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY st.[Churn Label];


-- Monthly charge by contract and churn status

SELECT
    se.[Contract],
    st.[Churn Label],
    AVG(se.[Monthly Charge]) AS Avg_Monthly_Charge
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    se.[Contract],
    st.[Churn Label]
ORDER BY
    se.[Contract],
    st.[Churn Label]


-- Monthly charge by contract, internet type and churn status

SELECT
    se.[Contract],
    se.[Internet Type],
    st.[Churn Label],
    AVG(se.[Monthly Charge]) AS Avg_Monthly_Charge
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    se.[Contract],
    se.[Internet Type],
    st.[Churn Label]
ORDER BY
    se.[Contract],
    st.[Churn Label],
    se.[Internet Type]


-- Churn by senior citizen

SELECT
    d.[Senior Citizen],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Demographics AS d
JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
GROUP BY d.[Senior Citizen]
ORDER BY Churn_Rate DESC;


-- Churn by marital status

SELECT
    d.[Married],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Demographics AS d
JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
GROUP BY d.[Married]
ORDER BY Churn_Rate DESC;


-- Churn by dependents

SELECT
    d.[Dependents],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Demographics AS d
JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
GROUP BY d.[Dependents]
ORDER BY Churn_Rate DESC;


-- Churn by gender

SELECT
    d.[Gender],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Demographics AS d
JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
GROUP BY d.[Gender]
ORDER BY Churn_Rate DESC;


-- Churn by age group

SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate,
    CASE
        WHEN AGE BETWEEN 19 AND 29 THEN '19-29'
        WHEN AGE BETWEEN 30 AND 44 THEN '30-44'
        WHEN AGE BETWEEN 45 AND 64 THEN '45-64'
        WHEN AGE >=65 THEN '65+'
    END AS Age_Groups
FROM dbo.Customer_Demographics AS d
JOIN dbo.Customer_Status AS st
    ON d.[Customer ID] = st.[Customer ID]
GROUP BY 
    CASE
        WHEN AGE BETWEEN 19 AND 29 THEN '19-29'
        WHEN AGE BETWEEN 30 AND 44 THEN '30-44'
        WHEN AGE BETWEEN 45 AND 64 THEN '45-64'
        WHEN AGE >=65 THEN '65+'
    END
ORDER BY Churn_Rate DESC


-- Churn by referral group

SELECT
    CASE
        WHEN se.[Number of Referrals] = 0 THEN '0'
        WHEN se.[Number of Referrals] BETWEEN 1 AND 2 THEN '1-2'
        WHEN se.[Number of Referrals] BETWEEN 3 AND 5 THEN '3-5'
        WHEN se.[Number of Referrals] >= 6 THEN '6+'
    END AS Referral_Group,

    COUNT(*) AS Total_Customers,

    SUM(CASE 
        WHEN st.[Churn Label] = 'Yes' THEN 1 
        ELSE 0 
    END) AS Churned_Customers,

    100.0 * SUM(CASE 
        WHEN st.[Churn Label] = 'Yes' THEN 1 
        ELSE 0 END) / COUNT(*) AS Churn_Rate,

    AVG(CAST(se.[Tenure in Months] AS DECIMAL(10,2))) AS Average_Tenure
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    CASE
        WHEN se.[Number of Referrals] = 0 THEN '0'
        WHEN se.[Number of Referrals] BETWEEN 1 AND 2 THEN '1-2'
        WHEN se.[Number of Referrals] BETWEEN 3 AND 5 THEN '3-5'
        WHEN se.[Number of Referrals] >= 6 THEN '6+'
    END

ORDER BY Churn_Rate DESC


-- Churn and tenure by offer

SELECT
    se.[Offer],
    COUNT(*) AS Total_Customers,
    AVG(CAST(se.[Tenure in Months] AS DECIMAL(10,2))) AS Avg_Tenure,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY se.[Offer]
ORDER BY Churn_Rate DESC;


-- Offer by tenure group

SELECT
    se.[Offer],
    CASE
        WHEN se.[Tenure in Months] BETWEEN 1 AND 12 THEN '1-12 Months'
        WHEN se.[Tenure in Months] BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN se.[Tenure in Months] BETWEEN 25 AND 48 THEN '25-48 Months'
        WHEN se.[Tenure in Months] BETWEEN 49 AND 72 THEN '49-72 Months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE 
            WHEN st.[Churn Label] = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers,

    100.0 * SUM(
        CASE 
            WHEN st.[Churn Label] = 'Yes' THEN 1
            ELSE 0
        END
    ) / COUNT(*) AS Churn_Rate

FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
GROUP BY
    se.[Offer],
    CASE
        WHEN se.[Tenure in Months] BETWEEN 1 AND 12 THEN '1-12 Months'
        WHEN se.[Tenure in Months] BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN se.[Tenure in Months] BETWEEN 25 AND 48 THEN '25-48 Months'
        WHEN se.[Tenure in Months] BETWEEN 49 AND 72 THEN '49-72 Months'
    END
ORDER BY
    Tenure_Group,
    Churn_Rate DESC;


-- Churn by category

SELECT
    [Churn Category],
    COUNT(*) AS Churned_Customers,
    100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER () AS Percentage_of_Churn
FROM dbo.Customer_Status
WHERE [Churn Label] = 'Yes'
GROUP BY [Churn Category]
ORDER BY Churned_Customers DESC;


-- Churn by reason

SELECT
    [Churn Reason],
    COUNT(*) AS Churned_Customers,
    100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER () AS Percentage_of_Churn
FROM dbo.Customer_Status
WHERE [Churn Label] = 'Yes'
GROUP BY [Churn Reason]
ORDER BY Churned_Customers DESC;


-- Churn reasons by internet type

SELECT
    se.[Internet Type],
    st.[Churn Reason],
    COUNT(*) AS Churned_Customers,

    100.0 * COUNT(*) /
    SUM(COUNT(*)) OVER (
        PARTITION BY se.[Internet Type]
    ) AS Percentage_within_Internet_Type

FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]

WHERE st.[Churn Label] = 'Yes'

GROUP BY
    se.[Internet Type],
    st.[Churn Reason]

ORDER BY
    se.[Internet Type],
    Percentage_within_Internet_Type DESC;


-- Churn by city

SELECT
    l.[City],
    COUNT(*) AS Total_Customers,
    SUM(CASE 
        WHEN st.[Churn Label] = 'Yes' THEN 1 
        ELSE 0 
    END) AS Churned_Customers,
    100.0 * SUM(CASE 
        WHEN st.[Churn Label] = 'Yes' THEN 1 
        ELSE 0 
    END) / COUNT(*) AS Churn_Rate

FROM dbo.Customer_Status AS st
JOIN dbo.Customer_Location AS l
    ON st.[Customer ID] = l.[Customer ID]

GROUP BY l.[City]

HAVING COUNT(*) >= 30

ORDER BY Churn_Rate DESC;


-- San Diego churn by contract

SELECT
    se.[Contract],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE l.[City] = 'San Diego'
GROUP BY se.[Contract]
ORDER BY Churn_Rate DESC;


-- San Diego churn by internet type

SELECT
    se.[Internet Type],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE l.[City] = 'San Diego'
GROUP BY se.[Internet Type]
ORDER BY Churn_Rate DESC;


-- San Diego churn reasons

SELECT
    st.[Churn Reason],
    COUNT(*) AS Churned_Customers,
    100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER () AS Percentage_of_SanDiego_Churn
FROM dbo.Customer_Status AS st
JOIN dbo.Customer_Location AS l
    ON st.[Customer ID] = l.[Customer ID]
WHERE
    st.[Churn Label] = 'Yes'
    AND l.[City] = 'San Diego'
GROUP BY st.[Churn Reason]
ORDER BY Churned_Customers DESC;


-- San Diego competitor offer churn by contract

SELECT
    se.[Contract],
    COUNT(*) AS Churned_Customers
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE
    l.[City] = 'San Diego'
    AND st.[Churn Label] = 'Yes'
    AND st.[Churn Reason] = 'Competitor made better offer'
GROUP BY se.[Contract]
ORDER BY Churned_Customers DESC;


-- San Diego competitor offer churn by internet type

SELECT
    se.[Internet Type],
    COUNT(*) AS Churned_Customers
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE
    l.[City] = 'San Diego'
    AND st.[Churn Label] = 'Yes'
    AND st.[Churn Reason] = 'Competitor made better offer'
GROUP BY se.[Internet Type]
ORDER BY Churned_Customers DESC


-- High-risk San Diego segment

SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN st.[Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE
    l.[City] = 'San Diego'
    AND se.[Contract] = 'Month-to-Month'
    AND se.[Internet Type] = 'Fiber Optic';


-- Churn reasons in high-risk San Diego segment

SELECT
    st.[Churn Reason],
    COUNT(*) AS Churned_Customers,
    100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS Percentage_of_Segment_Churn
FROM dbo.Customer_Services AS se
JOIN dbo.Customer_Status AS st
    ON se.[Customer ID] = st.[Customer ID]
JOIN dbo.Customer_Location AS l
    ON se.[Customer ID] = l.[Customer ID]
WHERE
    l.[City] = 'San Diego'
    AND se.[Contract] = 'Month-to-Month'
    AND se.[Internet Type] = 'Fiber Optic'
    AND st.[Churn Label] = 'Yes'
GROUP BY st.[Churn Reason]
ORDER BY Churned_Customers DESC;