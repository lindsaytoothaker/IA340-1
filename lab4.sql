--4.1

/* cannot delete Virginia from table because it refers to the other tables. 
FIPS/name are forgein keys on other tables. 
This is a 1 to M relationship
*/

--4.2
/* we cannot paste the line of code "insert into income(fips,income,year) values('80',6000,2025)"
because there is no state with fips 80
*/

--4.3
/* mostly good- somewhat redundant but can fix that by giving more specific parameters */

--4.5
/* yes, can upload ER diagram to chatgpt */

--4.6
-- Step 1: Find the most recent year in the income table
/* WITH RecentYear AS (
    SELECT MAX(year) AS most_recent_year
    FROM income
)

-- Step 2: Find the state with the highest income in that most recent year
SELECT n.name, i.income, i.year
FROM income i
JOIN name n ON i.fips = n.fips
JOIN RecentYear ry ON i.year = ry.most_recent_year
ORDER BY i.income DESC
LIMIT 1;   */

-- it works!

--4.7
-- Step 1: Get the population for Virginia in the most recent year and five years prior
/* 
WITH PopulationData AS (
    SELECT p.year, p.pop
    FROM population p
    JOIN name n ON p.fips = n.fips
    WHERE n.name = 'Virginia'
    ORDER BY p.year DESC
    LIMIT 6 -- We need to ensure we have enough data for 5 years
)

-- Step 2: Get the most recent and the past population
SELECT 
    recent.pop AS recent_population, 
    past.pop AS past_population,
    (recent.pop - past.pop) AS population_change,
    ((recent.pop - past.pop) * 100.0 / past.pop) AS population_growth_rate
FROM (
    SELECT year, pop
    FROM PopulationData
    ORDER BY year DESC
    LIMIT 1
) AS recent,
(
    SELECT year, pop
    FROM PopulationData
    ORDER BY year DESC
    OFFSET 5
    LIMIT 1
) AS past;
*/

-- My prompt was "calculate the population growth in virginia over the last 5 years" it worked when I posted it into PGAdmin

--4.8

/* I looked at income and changes over the last five years in maryland using the chatgpt prompt 
"calculate maryland income trends over the last five years". it returned columns with
income, previous year income, amount of change, and rate of change (%)

-- Step 1: Retrieve income data for Maryland over the last five years
WITH MarylandIncome AS (
    SELECT i.year, i.income
    FROM income i
    JOIN name n ON i.fips = n.fips
    WHERE n.name = 'Maryland'
    ORDER BY i.year DESC
    LIMIT 5
)

-- Step 2: Calculate the income change between each year and display the trends
SELECT 
    year,
    income,
    LAG(income) OVER (ORDER BY year) AS previous_income,
    (income - LAG(income) OVER (ORDER BY year)) AS income_change,
    ROUND(((income - LAG(income) OVER (ORDER BY year)) * 100.0 / LAG(income) OVER (ORDER BY year)), 2) AS percent_change
FROM MarylandIncome;

Chat GPT is able to produce responses and some of the time they are accurate, 
but it struggles with general statements. To get exactly what you want,
you need to be very specific in your wording */







