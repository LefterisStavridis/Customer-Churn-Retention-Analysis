USE CustomerChurnAnalytics;


-- Top churn reasons by internet type

WITH ChurnReasons AS (
    SELECT
        se.[Internet Type],
        st.[Churn Reason],
        COUNT(*) AS Churned_Customers
    FROM dbo.Customer_Services AS se
    JOIN dbo.Customer_Status AS st
        ON se.[Customer ID] = st.[Customer ID]
    WHERE st.[Churn Label] = 'Yes'
    GROUP BY
        se.[Internet Type],
        st.[Churn Reason]
),

RankedReasons AS (
    SELECT
        [Internet Type],
        [Churn Reason],
        Churned_Customers,
        RANK() OVER (
            PARTITION BY [Internet Type]
            ORDER BY Churned_Customers DESC
        ) AS Reason_Rank
    FROM ChurnReasons
)

SELECT
    [Internet Type],
    [Churn Reason],
    Churned_Customers,
    Reason_Rank
FROM RankedReasons
WHERE Reason_Rank <= 3
ORDER BY
    [Internet Type],
    Reason_Rank;


-- Customer risk segmentation

WITH CustomerRisk AS (
    SELECT
        st.[Customer ID],
        se.[Contract],
        se.[Tenure in Months],
        st.[Churn Label],
        CASE
            WHEN se.[Contract] = 'Month-to-Month' AND se.[Tenure in Months] <= 12
                THEN 'High Risk'
            WHEN se.[Contract] = 'Month-to-Month' OR se.[Tenure in Months] <= 24
                THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Segment
    FROM dbo.Customer_Status AS st
    JOIN dbo.Customer_Services AS se
        ON st.[Customer ID] = se.[Customer ID]
)

SELECT
    [Customer ID],
    [Contract],
    [Tenure in Months],
    [Churn Label],
    Risk_Segment
FROM CustomerRisk;


-- Churn by risk segment

WITH CustomerRisk AS (
    SELECT
        st.[Customer ID],
        se.[Contract],
        se.[Tenure in Months],
        st.[Churn Label],
        CASE
            WHEN se.[Contract] = 'Month-to-Month' AND se.[Tenure in Months] <= 12
                THEN 'High Risk'
            WHEN se.[Contract] = 'Month-to-Month' OR se.[Tenure in Months] <= 24
                THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Segment
    FROM dbo.Customer_Status AS st
    JOIN dbo.Customer_Services AS se
        ON st.[Customer ID] = se.[Customer ID] 
        )
SELECT
    Risk_Segment,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN [Churn Label] = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    100.0 * SUM(CASE WHEN [Churn Label] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Churn_Rate
FROM CustomerRisk
GROUP BY Risk_Segment
ORDER BY Churn_Rate DESC;