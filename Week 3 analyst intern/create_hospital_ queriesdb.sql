/*USE hospital_db;

SELECT 
    YEAR(START) AS encounter_year, 
    COUNT(Id) AS total_encounters 
FROM encounters 
GROUP BY YEAR(START) 
ORDER BY encounter_year;


SELECT 
    ENCOUNTERCLASS, 
    COUNT(Id) AS total_encounters,
    ROUND(COUNT(Id) * 100.0 / (SELECT COUNT(Id) FROM encounters), 2) AS percentage_of_total
FROM encounters
GROUP BY ENCOUNTERCLASS
ORDER BY total_encounters DESC;

SELECT 
    COUNT(Id) AS over_24h_count,
    (SELECT COUNT(Id) FROM encounters) AS total_encounters,
    ROUND(COUNT(Id) * 100.0 / (SELECT COUNT(Id) FROM encounters), 2) AS percentage_over_24h
FROM encounters
WHERE TIMESTAMPDIFF(HOUR, START, STOP) > 24; 

SELECT 
    COUNT(Id) AS total_encounters,
    SUM(BASE_ENCOUNTER_COST) AS total_base_cost,
    SUM(TOTAL_CLAIM_COST) AS total_claim_cost,
    SUM(PAYER_COVERAGE) AS total_payer_coverage,
    SUM(TOTAL_CLAIM_COST - PAYER_COVERAGE) AS patient_responsibility,
    SUM(CASE WHEN PAYER_COVERAGE = 0 THEN 1 ELSE 0 END) AS zero_coverage_encounters
FROM encounters; */

SELECT 
    p.NAME AS Payer_Name,
    COUNT(e.Id) AS encounter_volume,
    ROUND(AVG(e.TOTAL_CLAIM_COST), 2) AS avg_claim_cost,
    ROUND(SUM(e.TOTAL_CLAIM_COST), 2) AS total_claim_cost
FROM encounters e
LEFT JOIN payers p ON e.PAYER = p.Id
GROUP BY p.NAME
ORDER BY total_claim_cost DESC;