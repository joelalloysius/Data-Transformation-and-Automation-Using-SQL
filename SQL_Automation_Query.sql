-- Create Analysis Table
WITH analysis_table AS (
SELECT "Certificate Number",
COUNT("Certificate Number") AS sites,
COUNT(DISTINCT "Scope Language") AS scopes,
COUNT(*) FILTER( WHERE "Multisite Header" = 'Y') AS head_office,
BOOL_OR("Scope Language"= 'ENG') AS has_english,
COUNT("Scope Language") AS scope_count
FROM public."Salesforce"
GROUP BY "Certificate Number"
ORDER BY sites ASC),

-- Single Site 1 
Single_site_1 AS (
SELECT *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number" 
FROM analysis_table
WHERE sites = 1)
),

-- Single Site 2
Single_Site_2 AS (
SELECT *
FROM public."Salesforce" 
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table 
WHERE sites = scopes AND has_english = true 
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_site_1))
AND "Scope Language" = 'ENG'),

--Single Site 3
Single_Site_3 AS (
SELECT DISTINCT ON ("Certificate Number") *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table 
WHERE sites = scopes AND has_english = false 
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_site_1))),

--Multisite 1
Multisite_1 AS (SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN 
(SELECT "Certificate Number"
FROM analysis_table 
WHERE head_office = 1)
AND "Multisite Header" = 'Y'),

--Multisite 2
Multisite_2 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = true) 
AND "Scope Language" = 'ENG'
AND "Multisite Header" = 'Y'),

-- Multisite 3
Multisite_3 AS (
SELECT DISTINCT ON ("Certificate Number") *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number" 
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = false)
AND "Multisite Header" = 'Y'),

-- Multisite 4
Multisite_4 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE scope_count = 1
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_Site_1))
AND "Scope Language" IS NOT NULL)

SELECT * FROM Single_Site_1
UNION
SELECT * FROM Single_Site_2
UNION
SELECT * FROM Single_Site_3
UNION
SELECT * FROM Multisite_1
UNION
SELECT * FROM Multisite_2
UNION
SELECT * FROM Multisite_3
UNION
SELECT * FROM Multisite_4;


WITH analysis_table AS (
SELECT "Certificate Number",
COUNT("Certificate Number") AS sites,
COUNT(DISTINCT "Scope Language") AS scopes,
COUNT(*) FILTER( WHERE "Multisite Header" = 'Y') AS head_office,
BOOL_OR("Scope Language"= 'ENG') AS has_english,
COUNT("Scope Language") AS scope_count
FROM public."Salesforce"
GROUP BY "Certificate Number"
ORDER BY sites ASC),

Additional_1 AS (SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN 
(SELECT "Certificate Number"
FROM analysis_table 
WHERE head_office = 1)
AND "Multisite Header" = 'N'),

Additional_2 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = true) 
AND "Scope Language" = 'ENG'
AND "Multisite Header" = 'N'),

Additional_3 AS (
SELECT  *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number" 
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = false)
AND "Multisite Header" = 'N'),

Additional_4 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE scope_count = 1)
AND "Scope Language" IS NULL)

SELECT * FROM Additional_1
UNION
SELECT * FROM Additional_2
UNION
SELECT * FROM Additional_3
UNION
SELECT * FROM Additional_4;

-- Create Analysis Table
WITH analysis_table AS (
SELECT "Certificate Number",
COUNT("Certificate Number") AS sites,
COUNT(DISTINCT "Scope Language") AS scopes,
COUNT(*) FILTER( WHERE "Multisite Header" = 'Y') AS head_office,
BOOL_OR("Scope Language"= 'ENG') AS has_english,
COUNT("Scope Language") AS scope_count
FROM public."Salesforce"
GROUP BY "Certificate Number"
ORDER BY sites ASC),

-- Single Site 1 
Single_site_1 AS (
SELECT *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number" 
FROM analysis_table
WHERE sites = 1)
),

-- Single Site 2
Single_Site_2 AS (
SELECT *
FROM public."Salesforce" 
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table 
WHERE sites = scopes AND has_english = true 
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_site_1))
AND "Scope Language" = 'ENG'),

--Single Site 3
Single_Site_3 AS (
SELECT DISTINCT ON ("Certificate Number") *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table 
WHERE sites = scopes AND has_english = false 
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_site_1))),

--Multisite 1
Multisite_1 AS (SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN 
(SELECT "Certificate Number"
FROM analysis_table 
WHERE head_office = 1)
AND "Multisite Header" = 'Y'),

--Multisite 2
Multisite_2 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = true) 
AND "Scope Language" = 'ENG'
AND "Multisite Header" = 'Y'),

-- Multisite 3
Multisite_3 AS (
SELECT DISTINCT ON ("Certificate Number") *
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number" 
FROM analysis_table
WHERE head_office >1
AND head_office = scopes
AND has_english = false)
AND "Multisite Header" = 'Y'),

-- Multisite 4
Multisite_4 AS (
SELECT * 
FROM public."Salesforce"
WHERE "Certificate Number" IN (
SELECT "Certificate Number"
FROM analysis_table
WHERE scope_count = 1
AND "Certificate Number" NOT IN (SELECT "Certificate Number" FROM Single_Site_1))
AND "Scope Language" IS NOT NULL),

-- All Main Sites.
Main AS (
SELECT * FROM Single_Site_1
UNION
SELECT * FROM Single_Site_2
UNION
SELECT * FROM Single_Site_3
UNION
SELECT * FROM Multisite_1
UNION
SELECT * FROM Multisite_2
UNION
SELECT * FROM Multisite_3
UNION
SELECT * FROM Multisite_4)

-- Standards per main site
SELECT m."Certificate Number",s."Standard",s."Standard Name"
FROM Main as m
LEFT JOIN public."Standards" as s
ON m."Standard" = s."Standard";

