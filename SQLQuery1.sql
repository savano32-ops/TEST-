USE [MIGRATION]
GO

SELECT [year_month]
      ,[month_of_release]
      ,[passenger_type]
      ,[direction]
      ,[sex]
      ,[age]
      ,[estimate]
      ,[standard_error]
      ,[status]
  FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]

GO

SELECT 
    LEFT(year_month, 4) AS year,
    SUM(estimate) AS total_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY LEFT(year_month, 4)
ORDER BY year;
SELECT 
    age,
    AVG(estimate) AS avg_monthly_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY age
ORDER BY 
    CASE age
        WHEN '0-4 years' THEN 1
        WHEN '10-14 years' THEN 2
        ELSE 3
    END;
    SELECT 
    LEFT(year_month, 4) AS year,
    sex,
    SUM(estimate) AS total_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY LEFT(year_month, 4), sex
ORDER BY year, sex;
SELECT 
    year_month,
    SUM(estimate) AS child_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' 
  AND passenger_type = 'Long-term migrant'
  AND (age = '0-4 years' OR age = '10-14 years')
GROUP BY year_month
ORDER BY year_month;
SELECT 
    status,
    COUNT(*) AS record_count,
    SUM(estimate) AS total_estimate
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY status;
SELECT TOP 5
    year_month,
    sex,
    estimate
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' 
  AND passenger_type = 'Long-term migrant'
  AND age = '0-4 years'
ORDER BY estimate DESC
SELECT 
    RIGHT(year_month, 2) AS month,
    AVG(estimate) AS avg_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY RIGHT(year_month, 2)
ORDER BY month
SELECT 
    age,
    sex,
    SUM(estimate) AS total_arrivals,
    ROUND(SUM(estimate) * 100.0 / SUM(SUM(estimate)) OVER (PARTITION BY age), 2) AS pct_of_age_group
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
GROUP BY age, sex
ORDER BY age, sex
SELECT 
    LEFT(year_month, 4) AS year,
    SUM(CASE WHEN age = '0-4 years' THEN estimate ELSE 0 END) AS age_0_4,
    SUM(CASE WHEN age = '10-14 years' THEN estimate ELSE 0 END) AS age_10_14,
    SUM(estimate) AS total_arrivals
FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
WHERE direction = 'Arrivals' 
  AND passenger_type = 'Long-term migrant'
  AND LEFT(year_month, 4) IN (
      SELECT DISTINCT TOP 3 LEFT(year_month, 4) 
      FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data 
      ORDER BY LEFT(year_month, 4) DESC
  )
GROUP BY LEFT(year_month, 4)
ORDER BY year DESC
WITH yearly_totals AS (
    SELECT 
        LEFT(year_month, 4) AS year,
        SUM(estimate) AS total_arrivals
    FROM [dbo].[international-migration-april-2025-estimated-migration-by-age-sex]migration_data
    WHERE direction = 'Arrivals' AND passenger_type = 'Long-term migrant'
    GROUP BY LEFT(year_month, 4)
)
SELECT 
    a.year,
    a.total_arrivals,
    LAG(a.total_arrivals) OVER (ORDER BY a.year) AS prev_year_total,
    (a.total_arrivals - LAG(a.total_arrivals) OVER (ORDER BY a.year)) AS yoy_change,
    ROUND((a.total_arrivals - LAG(a.total_arrivals) OVER (ORDER BY a.year)) * 100.0 / 
        NULLIF(LAG(a.total_arrivals) OVER (ORDER BY a.year), 0), 2) AS yoy_growth_pct
FROM yearly_totals a
ORDER BY a.year









