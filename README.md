International Migration Analysis Project


Project Objectives
1.	Analyze long-term migration trends by age and sex over time
2.	Identify seasonal patterns in migration arrivals
3.	Compare migration patterns between different age groups (0-4 years vs 10-14 years)
4.	Examine gender differences in migration patterns
5.	Track the impact of major events (like COVID-19 in 2020) on migration flows

Key Analytical Questions
1.	What are the overall trends in long-term migrant arrivals over time?
2.	How do migration patterns differ between males and females?
3.	What are the seasonal patterns in migration for different age groups?
4.	How did the COVID-19 pandemic affect migration numbers in 2020-2021?
5.	Which age group (0-4 or 10-14) shows more consistent migration patterns?
6.	What are the peak months for migration arrivals historically?
7.	How do provisional estimates compare to final numbers historically?

DATASET

[international-migration-april-2025-estimated-migration-by-age-sex.csv](https://github.com/user-attachments/files/21313148/international-migration-april-2025-estimated-migration-by-age-sex.csv)
[](url

DATA PREPARATION AND POWER QUERY

1. Data Loading:

    Import CSV file into Power BI
       Verify data types for each column (date, text, numeric)
2. Data Cleaning:
    Split year_month column into separate Year and Month columns
       Create a proper date column from year_month
       Handle any missing or null values (though standard_error shows 0 for most records)

3. Data Transformation:
     Create calculated columns for:
     Age group categories (0-4, 10-14)
      Sex (Male, Female, Total)
            .Status (Final, Provisional)
Add a flag for COVID-19 period (2020-2021)
Create a quarter column for seasonal analysis

4. Data Enrichment:
    .Join with calendar table for time intelligence
    Add population data if available for per-capita analysis
    Create reference tables for passenger types and directions

