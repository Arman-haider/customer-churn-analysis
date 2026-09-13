SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customer_churn'
ORDER BY ordinal_position;

SELECT * FROM customer_churn;
--1. What is the total number of customers in the dataset?
SELECT COUNT(customer_id) AS total_customer FROM customer_churn;
--2. What is the total number of unique customer IDs?
SELECT COUNT(DISTINCT customer_id) AS total_unique_customer FROM customer_churn;
--3. Are there any duplicate customer IDs?
SELECT customer_id,
COUNT(*) AS Duplicated
FROM customer_churn
GROUP BY customer_id
HAVING COUNT(*) >1;
--4. Are there any completely duplicated records?
SELECT customer_id, gender, senior_citizen, "Partner", 
"Dependents", tenure, phone_service, multiple_lines,
internet_service, online_security, online_backup, device_protection, tech_support, 
streaming_tv, streaming_movies, "Contract", paperless_billing, payment_method,
monthly_charges, total_charges, "Churn"
FROM customer_churn
GROUP BY customer_id, gender, senior_citizen, "Partner", 
"Dependents", tenure, phone_service, multiple_lines,
internet_service, online_security, online_backup, device_protection, tech_support, 
streaming_tv, streaming_movies, "Contract", paperless_billing, payment_method,
monthly_charges, total_charges, "Churn"
HAVING COUNT(*)>1;
--5. What is the number of missing values in each column?
SELECT 
	SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS cust_id_missing,
	SUM(CASE WHEN "gender" IS NULL THEN 1 ELSE 0 END) AS gender_missing,
	SUM(CASE WHEN senior_citizen IS NULL THEN 1 ELSE 0 END) AS senior_citizen_missing,
	SUM(CASE WHEN "Partner" IS NULL THEN 1 ELSE 0 END) AS partner_missing,
	SUM(CASE WHEN "Dependents" IS NULL THEN 1 ELSE 0 END) AS dependents_missing,
	SUM(CASE WHEN "tenure" IS NULL THEN 1 ELSE 0 END) AS tenure_missing,
	SUM(CASE WHEN phone_service IS NULL THEN 1 ELSE 0 END) AS phone_service_missing,
	SUM(CASE WHEN multiple_lines IS NULL THEN 1 ELSE 0 END) AS multiple_lines_missing,
	SUM(CASE WHEN internet_service IS NULL THEN 1 ELSE 0 END) AS internet_service_missing,
	SUM(CASE WHEN online_security IS NULL THEN 1 ELSE 0 END) AS online_security_missing,
	SUM(CASE WHEN online_backup IS NULL THEN 1 ELSE 0 END) AS online_backup_missing,
	SUM(CASE WHEN device_protection IS NULL THEN 1 ELSE 0 END) AS device_protection_missing,
	SUM(CASE WHEN tech_support IS NULL THEN 1 ELSE 0 END) AS tech_support_missing,
	SUM(CASE WHEN streaming_tv IS NULL THEN 1 ELSE 0 END) AS streaming_tv_missing,
	SUM(CASE WHEN "Contract" IS NULL THEN 1 ELSE 0 END) AS contract_missing,
	SUM(CASE WHEN paperless_billing IS NULL THEN 1 ELSE 0 END) AS paperless_billing_missing,
	SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS payment_method_missing,
	SUM(CASE WHEN monthly_charges IS NULL THEN 1 ELSE 0 END) AS monthly_charges_missing,
	SUM(CASE WHEN total_charges IS NULL THEN 1 ELSE 0 END) AS total_charges_missing,
	SUM(CASE WHEN "Churn" IS NULL THEN 1 ELSE 0 END) AS churn_missing
FROM customer_churn;
--6. Which customers have missing TotalCharges?
SELECT customer_id
FROM customer_churn
WHERE total_charges IS NULL;
--7. How many customers have tenure equal to 0?
SELECT COUNT("tenure") AS total_customer_with_0_tenure
FROM customer_churn
WHERE "tenure" =0;
--8. Do all customers with missing TotalCharges have tenure equal to 0?
SELECT customer_id,"tenure"
FROM customer_churn
WHERE total_charges IS NULL;

--9. Are there any negative values in MonthlyCharges?
SELECT COUNT(monthly_charges) AS total_negative_values_monthly_charges
FROM customer_churn
WHERE monthly_charges<0;
--10. Are there any negative values in TotalCharges?
SELECT COUNT(total_charges) AS total_negative_values_total_charges
FROM customer_churn
WHERE total_charges < 0;

--11. What are the minimum, maximum, and average values of tenure?
SELECT 	
	MIN("tenure") AS min_tenure,
	MAX("tenure") AS max_tenure,
	ROUND(AVG("tenure"),2) AS avg_tenure
FROM customer_churn;
--12. What are the minimum, maximum, and average values of MonthlyCharges?
SELECT 	
	MIN(monthly_charges) AS min_monthly_charges,
	MAX(monthly_charges) AS max_monthly_charges,
	AVG(monthly_charges) AS avg_monthly_charges
FROM customer_churn;
--13. What are the minimum, maximum, and average values of TotalCharges?
SELECT 	
	MIN(total_charges) AS min_total_charges,
	MAX(total_charges) AS max_total_charges,
	ROUND(AVG(total_charges),2) AS avg_total_charges
FROM customer_churn;

-- 14. What is the distribution of customers by gender?
SELECT "gender",COUNT(*) AS distribution_by_gender
FROM customer_churn
GROUP BY "gender";
-- 15. What is the distribution of SeniorCitizen customers?
SELECT senior_citizen,COUNT(*) AS distribution_by_senior_citizen
FROM customer_churn
GROUP BY senior_citizen;
-- 16. What is the distribution of customers by Partner status?
SELECT "Partner", COUNT(*) AS distribution_by_partner_status
FROM customer_churn
GROUP BY "Partner";
-- 17. What is the distribution of customers by Dependents status?
SELECT "Dependents", COUNT(*) AS distribution_by_dependents
FROM customer_churn
GROUP BY "Dependents";
-- 18. What is the churn count by gender?
SELECT "gender","Churn",COUNT(*) AS churn_by_gender
FROM customer_churn
GROUP BY "gender", "Churn"
ORDER BY "gender", "Churn";
-- 19. What is the churn rate by gender?
SELECT "gender",
COUNT(*) FILTER(WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER(WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churned_rate_by_gender
FROM customer_churn
GROUP BY "gender"
ORDER BY "gender";
-- 20. What is the churn count by SeniorCitizen status?
SELECT senior_citizen,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_by_senior_citizen
FROM customer_churn
GROUP BY senior_citizen
ORDER BY senior_citizen;
-- 21. What is the churn rate by SeniorCitizen status?
SELECT senior_citizen,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER(WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churned_rate_by_senior_citizen
FROM customer_churn
GROUP BY senior_citizen
ORDER BY senior_citizen;
-- 23. What is the churn rate by Partner status?
SELECT "Partner",
COUNT(*) FILTER ( WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churned_rate_by_partner
FROM customer_churn
GROUP BY "Partner"
ORDER BY "Partner";

-- 24. What is the churn count by Dependents status?
SELECT "Dependents",
COUNT(*) Filter(WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY "Dependents"
ORDER BY "Dependents";
-- 25. What is the churn rate by Dependents status?
SELECT "Dependents",
COUNT(*) Filter(WHERE "Churn"='Yes') AS churned_customers,
ROUND(COUNT(*) FILTER( WHERE "Churn" ='Yes')*100.0/COUNT(*),2) AS churned_rate_by_dependents
FROM customer_churn
GROUP BY "Dependents"
ORDER BY "Dependents";


--                                  SECTION 3 — PHONE & INTERNET SERVICE ANALYSIS
--                            ============================================================

-- 26. What is the distribution of customers by PhoneService?
SELECT phone_service,
COUNT(*) AS distribution_by_phone_service
FROM customer_churn
GROUP BY phone_service;
-- 27. What is the distribution of customers by MultipleLines?
SELECT multiple_lines,
COUNT(*) AS distribution_by_multiple_lines
FROM customer_churn
GROUP BY multiple_lines;

-- 28. What is the distribution of customers by InternetService?
SELECT internet_service,
COUNT(*) AS distribution_by_internet_service
FROM customer_churn
GROUP BY internet_service;

-- 29. What is the distribution of customers by OnlineSecurity?
SELECT online_security,
COUNT(*) AS distribution_by_online_security
FROM customer_churn
GROUP BY online_security;

-- 30. What is the distribution of customers by OnlineBackup?
SELECT online_backup,
COUNT(*) AS distribution_by_online_backup
FROM customer_churn
GROUP BY online_backup;

-- 31. What is the distribution of customers by DeviceProtection?
SELECT device_protection,
COUNT(*) AS distribution_by_device_protection
FROM customer_churn
GROUP BY device_protection;

-- 32. What is the distribution of customers by TechSupport?
SELECT tech_support,
COUNT(*) AS distribution_by_tech_support
FROM customer_churn
GROUP BY tech_support;

-- 33. What is the distribution of customers by StreamingTV?
SELECT streaming_tv,
COUNT(*) AS distribution_by_streaming_tv
FROM customer_churn
GROUP BY streaming_tv;

-- 34. What is the distribution of customers by StreamingMovies?
SELECT streaming_movies,
COUNT(*) AS distribution_by_streaming_movies
FROM customer_churn
GROUP BY streaming_movies;

-- 35. What is the churn count by PhoneService?
SELECT phone_service,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_by_phone_service
FROM customer_churn
GROUP BY phone_service;
-- 36. What is the churn rate by PhoneService?
SELECT phone_service,
COUNT(*) FILTER( WHERE "Churn"='Yes') AS churned_by_phone_service,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_phone_service
FROM customer_churn
GROUP BY phone_service;
-- 37. What is the churn count by MultipleLines?
SELECT multiple_lines,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY multiple_lines;
-- 38. What is the churn rate by MultipleLines?
SELECT multiple_lines,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_multiple_lines
FROM customer_churn
GROUP BY multiple_lines;

-- 39. What is the churn count by InternetService?
SELECT internet_service,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY internet_service;

-- 40. What is the churn rate by InternetService?
SELECT internet_service,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_internet_service
FROM customer_churn
GROUP BY internet_service;
-- 41. What is the churn count by OnlineSecurity?
SELECT online_security,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY online_security;

-- 42. What is the churn rate by OnlineSecurity?
SELECT online_security,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_online_security
FROM customer_churn
GROUP BY online_security;

-- 43. What is the churn count by OnlineBackup?
SELECT online_backup,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY online_backup;

-- 44. What is the churn rate by OnlineBackup?
SELECT online_backup,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_online_backup
FROM customer_churn
GROUP BY online_backup;

-- 45. What is the churn count by DeviceProtection?
SELECT device_protection,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY device_protection;

-- 46. What is the churn rate by DeviceProtection?
SELECT device_protection,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_device_protection
FROM customer_churn
GROUP BY device_protection;

-- 47. What is the churn count by TechSupport?
SELECT tech_support,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY tech_support;

-- 48. What is the churn rate by TechSupport?
SELECT tech_support,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_tech_support
FROM customer_churn
GROUP BY tech_support;

-- 49. What is the churn count by StreamingTV?
SELECT streaming_tv,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY streaming_tv;

-- 50. What is the churn rate by StreamingTV?
SELECT streaming_tv,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_streaming_tv
FROM customer_churn
GROUP BY streaming_tv;

-- 51. What is the churn count by StreamingMovies?
SELECT streaming_movies,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY streaming_movies;

-- 52. What is the churn rate by StreamingMovies?
SELECT streaming_movies,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_streaming_movies
FROM customer_churn
GROUP BY streaming_movies;


--                           ============================================================
--                                    SECTION 4 — CONTRACT & BILLING ANALYSIS
--                           ============================================================

-- 53. What is the distribution of customers by Contract type?
SELECT "Contract",
COUNT(*) AS total_customers
FROM customer_churn
GROUP BY "Contract";
-- 54. What is the distribution of customers by PaperlessBilling?
SELECT paperless_billing,
COUNT(*) AS total_customers
FROM customer_churn
GROUP BY paperless_billing;
-- 55. What is the distribution of customers by PaymentMethod?
SELECT payment_method,
COUNT(*) AS total_customers
FROM customer_churn
GROUP BY payment_method;

-- 56. What is the average MonthlyCharges?
SELECT ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges
FROM customer_churn;
-- 57. What is the minimum MonthlyCharges?
SELECT MIN(monthly_charges) AS min_monthly_charges
FROM customer_churn;
-- 58. What is the maximum MonthlyCharges?
SELECT MAX(monthly_charges) AS max_monthly_charges
FROM customer_churn;
-- 59. What is the average TotalCharges?
SELECT ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges
FROM customer_churn;

-- 60. What is the minimum TotalCharges?
SELECT MIN(total_charges) AS min_total_charges
FROM customer_churn;

-- 61. What is the maximum TotalCharges?
SELECT MAX(total_charges) AS max_total_charges
FROM customer_churn;

-- 62. What is the average MonthlyCharges by Contract type?
SELECT "Contract", ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges_by_contract
FROM customer_churn
GROUP BY "Contract";

-- 63. What is the average TotalCharges by Contract type?
SELECT "Contract", ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges_by_contract
FROM customer_churn
GROUP BY "Contract";

-- 64. What is the average MonthlyCharges by InternetService?
SELECT internet_service, ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges_by_internet_service
FROM customer_churn
GROUP BY internet_service;

-- 65. What is the average TotalCharges by InternetService?
SELECT internet_service, ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges_by_internet_service
FROM customer_churn
GROUP BY internet_service;

-- 66. What is the churn count by Contract type?
SELECT "Contract",
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY "Contract";
-- 67. What is the churn rate by Contract type?
SELECT "Contract",
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_contract
FROM customer_churn
GROUP BY "Contract";
-- 68. What is the churn count by PaperlessBilling?
SELECT paperless_billing,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY paperless_billing;

-- 69. What is the churn rate by PaperlessBilling?
SELECT paperless_billing,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_paperless_billing
FROM customer_churn
GROUP BY paperless_billing;

-- 70. What is the churn count by PaymentMethod?
SELECT payment_method,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
FROM customer_churn
GROUP BY payment_method;

-- 71. What is the churn rate by PaymentMethod?
SELECT payment_method,
COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_payment_method
FROM customer_churn
GROUP BY payment_method;


                              -- Core Churn KPIs

-- 72.	How many customers have churned?
SELECT COUNT(*) FILTER (WHERE "Churn"='Yes') AS total_churned_customers
FROM customer_churn;
-- 73.	How many customers have not churned?
SELECT COUNT(*) FILTER (WHERE "Churn"='No') AS total_retained_customers
FROM customer_churn;

-- 74.	What is the overall churn rate?
SELECT COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn;

-- 75.	What percentage of customers are retained?
SELECT COUNT(*) AS total_customers,
ROUND(COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2) AS retention_rate
FROM customer_churn;


                           -- Tenure & Charges vs Churn

-- 92.	What is the average tenure of churned customers?
SELECT ROUND(AVG("tenure")::numeric,2) AS avg_tenure_churned_customers
FROM customer_churn
WHERE "Churn"='Yes';
-- 93.	What is the average tenure of retained customers?
SELECT ROUND(AVG("tenure")::numeric,2) AS avg_retained_customers
FROM customer_churn
WHERE "Churn"='No';

-- 94.	What is the average MonthlyCharges of churned customers?
SELECT ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges_churned_customers
FROM customer_churn
WHERE "Churn"='Yes';

-- 95.	What is the average MonthlyCharges of retained customers?
SELECT ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges_retained_customers
FROM customer_churn
WHERE "Churn"='No';

-- 96.	What is the average TotalCharges of churned customers?
SELECT ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges_churned_customers
FROM customer_churn
WHERE "Churn"='Yes';

-- 97.	What is the average TotalCharges of retained customers?
SELECT ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges_retained_customers
FROM customer_churn
WHERE "Churn"='No';

-- 98.	What is the minimum, maximum tenure among churned customers?
SELECT 
	MIN("tenure") AS min_tenure_churned_customer,
	MAX("tenure") AS max_tenure_churned_customer
FROM customer_churn
WHERE "Churn"='Yes';
-- 100.	What is the minimum, maximum MonthlyCharges among churned customers?
SELECT 
	MIN(monthly_charges) AS min_monthly_charges_churned_customer,
	MAX(monthly_charges) AS max_monthly_charges_churned_customer
FROM customer_churn
WHERE "Churn"='Yes';

-- 102.	What is the minimum, maximum TotalCharges among churned customers?
SELECT 
	MIN(total_charges) AS min_total_charges_churned_customer,
	MAX(total_charges) AS max_total_charges_churned_customer
FROM customer_churn
WHERE "Churn"='Yes';

                                          --  Customer Segmentation

-- 104.	How many customers have tenure between 0–12 months?
SELECT
	COUNT(*) AS total_customers_with_tenure_0_12
FROM customer_churn
WHERE "tenure" BETWEEN 0 AND 12;
-- 105.	How many customers have tenure between 13–36 months?
SELECT
	COUNT(*) AS total_customers_with_tenure_13_36
FROM customer_churn
WHERE "tenure" BETWEEN 13 AND 36;

-- 106.	How many customers have tenure greater than 36 months?
SELECT
	COUNT(*) AS total_customers_with_tenure_greater_than_36
FROM customer_churn
WHERE "tenure" > 36;

-- 107.	What is the churn rate for customers with tenure between 0–12 months?
SELECT
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_tenure_0_12
FROM customer_churn
WHERE "tenure" BETWEEN 0 AND 12;

-- 108.	What is the churn rate for customers with tenure between 13–36 months?
SELECT
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_tenure_13_36
FROM customer_churn
WHERE "tenure" BETWEEN 13 AND 36;

-- 109.	What is the churn rate for customers with tenure greater than 36 months?
SELECT
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate_by_tenure_greater_than_36
FROM customer_churn
WHERE "tenure" > 36;

-- 110.	Which tenure segment has the highest churn rate?
WITH churn_by_tenure_segment AS (
	SELECT
		CASE
			WHEN "tenure" BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN "tenure" BETWEEN 13 AND 36 THEN '13-36 Months'
			WHEN "tenure" > 36 THEN 'Greater than 36 months'
		END AS tenure_segment,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*) AS churned_rate
	FROM customer_churn
	GROUP BY
		CASE
			WHEN "tenure" BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN "tenure" BETWEEN 13 AND 36 THEN '13-36 Months'
			WHEN "tenure" > 36 THEN 'Greater than 36 months'
		END
) 
SELECT 
	tenure_segment,
	total_customers,
	ROUND(churned_rate,2) AS churn_rate
FROM churn_by_tenure_segment
ORDER BY churned_rate DESC
LIMIT 1;
-- 111.	Which tenure segment has the highest number of churned customers?
WITH tenure_churn AS (
	SELECT 
		CASE 
			WHEN "tenure" BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN "tenure" BETWEEN 13 AND 36 THEN '13-36 Months'
			WHEN "tenure" > 36 THEN 'Greater than 36 months'
		END AS tenure_segment,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers
	FROM customer_churn
	GROUP BY 
		CASE 
			WHEN "tenure" BETWEEN 0 AND 12 THEN '0-12 Months'
			WHEN "tenure" BETWEEN 13 AND 36 THEN '13-36 Months'
			WHEN "tenure" > 36 THEN 'Greater than 36 months'
		END
)
SELECT
	tenure_segment,
	total_customers,
	churned_customers
FROM tenure_churn
ORDER BY 3 DESC
LIMIT 1;
-- 112.	How many customers have low, Medium & High MonthlyCharges?
WITH monthly_charges_ranges AS (
	SELECT 
		CASE
			WHEN monthly_charges <=40 THEN 'Low'
			WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
			ELSE 'High'
		END AS monthly_charges_segment,
		COUNT(*) AS total_customers
	FROM customer_churn
	GROUP BY 
		CASE
			WHEN monthly_charges <=40 THEN 'Low'
			WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
			ELSE 'High'
		END
)
SELECT 
	total_customers,
	monthly_charges_segment
FROM monthly_charges_ranges
ORDER BY total_customers DESC;

-- 116.	Which MonthlyCharges segment has the highest churn rate?

WITH monthly_charges_ranges AS (
	SELECT 
		CASE
			WHEN monthly_charges <=40 THEN 'Low'
			WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
			ELSE 'High'
		END AS monthly_charges_segment,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*) AS churn_rate
	FROM customer_churn
	GROUP BY 
		CASE
			WHEN monthly_charges <=40 THEN 'Low'
			WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
			ELSE 'High'
		END
)
SELECT 
	total_customers,
	ROUND(churn_rate,2) AS churn_rate,
	monthly_charges_segment
FROM monthly_charges_ranges
ORDER BY churn_rate DESC
LIMIT 1;


                                    -- 4. Multi-Dimensional Churn Analysis

-- 117.	What is the churn rate by Contract and InternetService?
SELECT 
	"Contract",
	internet_service,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	internet_service
ORDER BY churn_rate DESC;
-- 118.	What is the churn rate by Contract and PaymentMethod?
SELECT 
	"Contract",
	payment_method,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	payment_method
ORDER BY churn_rate DESC;

-- 119.	What is the churn rate by Contract and TechSupport?
SELECT 
	"Contract",
	tech_support,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	tech_support
ORDER BY churn_rate DESC;

-- 120.	What is the churn rate by Contract and OnlineSecurity?
SELECT 
	"Contract",
	online_security,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	online_security
ORDER BY churn_rate DESC;

-- 121.	What is the churn rate by Contract and SeniorCitizen status?
SELECT 
	"Contract",
	senior_citizen,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	senior_citizen
ORDER BY churn_rate DESC;

-- 122.	What is the churn rate by Contract and PaperlessBilling?
SELECT 
	"Contract",
	paperless_billing,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	"Contract",
	paperless_billing
ORDER BY churn_rate DESC;

-- 123.	What is the churn rate by InternetService and TechSupport?
SELECT 
	internet_service,
	tech_support,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	tech_support
ORDER BY churn_rate DESC;

-- 124.	What is the churn rate by InternetService and OnlineSecurity?
SELECT 
	internet_service,
	online_security,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	online_security
ORDER BY churn_rate DESC;

-- 125.	What is the churn rate by InternetService and OnlineBackup?
SELECT 
	internet_service,
	online_backup,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	online_backup
ORDER BY churn_rate DESC;

-- 126.	What is the churn rate by InternetService and DeviceProtection?
SELECT 
	internet_service,
	device_protection,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	device_protection
ORDER BY churn_rate DESC;

-- 127.	What is the churn rate by InternetService and StreamingTV?
SELECT 
	internet_service,
	streaming_tv,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	streaming_tv
ORDER BY churn_rate DESC;

-- 128.	What is the churn rate by InternetService and StreamingMovies?
SELECT 
	internet_service,
	streaming_movies,
	COUNT(*) AS total_customer,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2 )AS churn_rate
FROM customer_churn
GROUP BY 
	internet_service,
	streaming_movies
ORDER BY churn_rate DESC;


                           -- 5. Multiple Risk Factor Analysis

-- 144.	What is the churn rate for customers with Month-to-month contracts and Fiber optic internet?
SELECT 
	"Contract",
	internet_service,
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month' AND internet_service='Fiber optic'
GROUP BY 
	"Contract",
	internet_service;
-- 145.	What is the churn rate for customers with Month-to-month contracts and Electronic check payment?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month'
	AND payment_method='Electronic check';

-- 146.	What is the churn rate for customers with Month-to-month contracts and high MonthlyCharges?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month'
	AND monthly_charges > 80 ;

-- 147.	What is the churn rate for customers with low tenure and Month-to-month contracts?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month'
	AND "tenure" BETWEEN 0 AND 12 ;

-- 148.	What is the churn rate for customers with low tenure and high MonthlyCharges?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE monthly_charges>80
	AND "tenure" BETWEEN 0 AND 12 ;

-- 149.	What is the churn rate for SeniorCitizen customers with Month-to-month contracts?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month'
	AND senior_citizen=1 ;

-- 150.	What is the churn rate for SeniorCitizen customers with Fiber optic internet?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE internet_service='Fiber optic'
	AND senior_citizen=1 ;

-- 151.	What is the churn rate for customers without OnlineSecurity and without TechSupport?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE online_security = 'No'
	AND tech_support = 'No';

-- 152.	What is the churn rate for customers with Month-to-month contracts, Fiber optic internet, and Electronic check?
SELECT 
	COUNT(*) AS total_customers,
	ROUND(COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2) AS churn_rate
FROM customer_churn
	WHERE "Contract"='Month-to-month'
	AND internet_service='Fiber optic'
	AND payment_method='Electronic check';

-- 153.	How many customers have multiple high-risk characteristics and have churned?

WITH high_risk_customers AS (
	SELECT 
		customer_id,
		"Churn",
		(
			CASE WHEN "Contract"='Month-to-month' THEN 1 ELSE 0 END +
			CASE WHEN internet_service='Fiber optic' THEN 1 ELSE 0 END +
			CASE WHEN payment_method='Electronic check' THEN 1 ELSE 0 END +
			CASE WHEN "tenure" BETWEEN 0 AND 12 THEN 1 ELSE 0 END +
			CASE WHEN  monthly_charges>80 THEN 1 ELSE 0 END 
		) AS risk_score		
	FROM customer_churn
)
SELECT
	COUNT(*) AS churned_customers
FROM high_risk_customers
WHERE risk_score>2
AND "Churn"='Yes';


                              -- 6. Retention & Customer Value Analysis

-- 155.	What is the average tenure of retained customers?
SELECT
	ROUND(AVG("tenure")::numeric,2) AS avg_retained_tenure
FROM customer_churn
WHERE "Churn"='No';
-- 156.	What is the average MonthlyCharges of retained customers?
SELECT
	ROUND(AVG(monthly_charges)::numeric,2) AS avg_retained_monthly_charges
FROM customer_churn
WHERE "Churn"='No';

-- 157.	What is the average TotalCharges of retained customers?
SELECT
	ROUND(AVG(total_charges)::numeric,2) AS avg_retained_total_charges
FROM customer_churn
WHERE "Churn"='No';

-- 158.	Which Contract type has the highest customer retention rate?
WITH retention_rate_contract AS (
	SELECT
		CASE
			WHEN "Contract" = 'One year' THEN 'One year'
			WHEN "Contract" = 'Month-to-month' THEN 'Month-to-month'
			WHEN "Contract" = 'Two year' THEN 'Two year'
		END AS contract_segment,
		COUNT(*) AS total_customers,
		ROUND(COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*)::numeric,2 )AS retention_rate
	FROM customer_churn
	GROUP BY 
		CASE
			WHEN "Contract" = 'One year' THEN 'One year'
			WHEN "Contract" = 'Month-to-month' THEN 'Month-to-month'
			WHEN "Contract" = 'Two year' THEN 'Two year'
		END
)
SELECT 
	contract_segment,
	retention_rate
FROM retention_rate_contract
ORDER BY retention_rate DESC
LIMIT 1;
-- 159.	Which InternetService type has the highest customer retention rate?
WITH retention_rate_internet_service AS (
	SELECT 	
		CASE
			WHEN internet_service='No' THEN 'No Internet Service'
			WHEN internet_service='DSL' THEN 'DSL'
			WHEN internet_service='Fiber optic' THEN 'Fiber optic'
		END AS internet_service_segment,
		COUNT(*) AS total_customers,
		ROUND(COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*)::numeric,2) AS retention_rate
	FROM customer_churn
	GROUP BY
		CASE
			WHEN internet_service='No' THEN 'No Internet Service'
			WHEN internet_service='DSL' THEN 'DSL'
			WHEN internet_service='Fiber optic' THEN 'Fiber optic'
		END
)
SELECT 
	internet_service_segment,
	retention_rate
FROM retention_rate_internet_service
ORDER BY retention_rate DESC 
LIMIT 1;


-- 160.	Which PaymentMethod has the highest customer retention rate?
WITH retention_rate_payment_method AS (
	SELECT 
		CASE
			WHEN payment_method='Electronic check' THEN 'Electronic check'
			WHEN payment_method='Credit card (automatic)' THEN 'Credit card (automatic)'
			WHEN payment_method='Mailed check' THEN 'Mailed check'
			WHEN payment_method='Bank transfer (automatic)' THEN 'Bank transfer (automatic)'
		END AS payment_method_segment,
		COUNT(*) AS total_customers,
		ROUND(COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*)::numeric,2) AS retention_rate
	FROM customer_churn
	GROUP BY 
		CASE
			WHEN payment_method='Electronic check' THEN 'Electronic check'
			WHEN payment_method='Credit card (automatic)' THEN 'Credit card (automatic)'
			WHEN payment_method='Mailed check' THEN 'Mailed check'
			WHEN payment_method='Bank transfer (automatic)' THEN 'Bank transfer (automatic)'
		END
)
SELECT 
	payment_method_segment,
	retention_rate
FROM retention_rate_payment_method
ORDER BY retention_rate DESC
LIMIT 1;
-- 161.	Which Contract type generates the highest average TotalCharges?
WITH avg_total_charges_contract AS (
	SELECT 
		CASE
			WHEN "Contract" = 'One year' THEN 'One year'
			WHEN "Contract" = 'Month-to-month' THEN 'Month-to-month'
			WHEN "Contract" = 'Two year' THEN 'Two year'
		END AS contract_segment,
		ROUND(AVG(total_charges)::numeric,2) AS avg_total_charges
	FROM customer_churn
	GROUP BY
		CASE
			WHEN "Contract" = 'One year' THEN 'One year'
			WHEN "Contract" = 'Month-to-month' THEN 'Month-to-month'
			WHEN "Contract" = 'Two year' THEN 'Two year'
		END
)
SELECT 
	contract_segment,
	avg_total_charges
FROM avg_total_charges_contract
ORDER BY avg_total_charges DESC
LIMIT 1;
-- 162.	Which InternetService type has the highest average MonthlyCharges?

WITH avg_monthly_charges_internet_service AS (
	SELECT 
		CASE
			WHEN internet_service='No' THEN 'No Internet Service'
			WHEN internet_service='DSL' THEN 'DSL'
			WHEN internet_service='Fiber optic' THEN 'Fiber optic'
		END AS internet_service_segment,
		ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges
		FROM customer_churn
		GROUP BY 
			CASE
			WHEN internet_service='No' THEN 'No Internet Service'
			WHEN internet_service='DSL' THEN 'DSL'
			WHEN internet_service='Fiber optic' THEN 'Fiber optic'
		END
)

SELECT	
	internet_service_segment,
	avg_monthly_charges
FROM avg_monthly_charges_internet_service
ORDER BY avg_monthly_charges DESC
LIMIT 1;


                         -- 	7. Final Business Analysis

-- 	178.	What are the top 5 factors associated with customer churn?

WITH 
	churn_by_gender AS 
	(
		SELECT 
			'Gender' AS factor_name,
			"gender"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "gender"
	),
	churn_by_senior_citizen AS 
	(
		SELECT 
			'Senior Citizen' AS factor_name, 
			senior_citizen::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY senior_citizen
	),
	churn_by_partner AS 
	(
		SELECT 
			'Partner' AS factor_name,
			"Partner"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Partner"
	),
	churn_by_dependents AS 
	(
		SELECT 
			'Dependents' AS factor_name,
			"Dependents"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Dependents"
	),
	churn_by_phone_service AS 
	(
		SELECT 
			'Phone Service' AS factor_name,
			phone_service::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY phone_service
	),
	churn_by_multiple_lines AS 
	(
		SELECT 
			'Multiple Lines' AS factor_name,
			multiple_lines::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY multiple_lines
	),
	churn_by_internet_service AS 
	(
		SELECT 
			'Internet Service' AS factor_name,
			internet_service::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY internet_service
	),
	
	churn_by_online_security AS 
	(
		SELECT 
			'Online Security' AS factor_name,
			online_security::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY online_security
	),
	churn_by_online_backup AS 
	(
		SELECT 
			'Online Backup' AS factor_name,
			online_backup::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY online_backup
	),
	churn_by_device_protection AS 
	(
		SELECT 
			'Device Protection' AS factor_name,
			device_protection::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY device_protection
	),
	churn_by_tech_support AS 
	(
		SELECT 
			'Tech Support' AS factor_name,
			tech_support::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY tech_support
	),
	churn_by_streaming_tv AS 
	(
		SELECT 
			'Streaming Tv' AS factor_name,
			streaming_tv::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY streaming_tv
	),
	churn_by_streaming_movies AS 
	(
		SELECT 
			'Streaming Movies Service' AS factor_name,
			streaming_movies::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY streaming_movies
	),
	churn_by_contract AS 
	(
		SELECT 
			'Contract' AS factor_name,
			"Contract"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Contract"
	),
	churn_by_paperless_billing AS 
	(
		SELECT 
			'Paperless Billing' AS factor_name,
			paperless_billing::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY paperless_billing
	),
	churn_by_payment_method AS 
	(
		SELECT 
			'Payment Method' AS factor_name,
			payment_method::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY payment_method
	),
	churn_by_tenure AS
	(
		SELECT
			'Tenure Segment' AS factor_name,
			CASE
				WHEN "tenure" BETWEEN 0 AND 12 THEN 'Low'
				WHEN "tenure" BETWEEN 13 AND 36 THEN 'Medium'
				WHEN "tenure">36 THEN 'High'
			END AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2
				) AS churn_rate
		FROM customer_churn
		GROUP BY 2
			
	),
	churn_by_monthly_charges AS 
	(
		SELECT 
			'Monthly Charges Segment' AS factor_name,
			CASE
				WHEN monthly_charges<=40 THEN 'Low'
				WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
				WHEN monthly_charges >80 THEN 'High'
			END AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND ( 
					COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2
				) AS churn_rate
		FROM customer_churn
		GROUP BY 2
	),
	all_churn_factors AS
	(
		SELECT * FROM churn_by_gender
		UNION ALL
		SELECT * FROM churn_by_senior_citizen
		UNION ALL
		SELECT * FROM churn_by_partner
		UNION ALL
		SELECT * FROM churn_by_dependents
		UNION ALL
		SELECT * FROM churn_by_phone_service
		UNION ALL
		SELECT * FROM churn_by_multiple_lines
		UNION ALL
		SELECT * FROM churn_by_internet_service
		UNION ALL
		SELECT * FROM churn_by_online_backup
		UNION ALL
		SELECT * FROM churn_by_device_protection
		UNION ALL
		SELECT * FROM churn_by_tech_support
		UNION ALL
		SELECT * FROM churn_by_contract
		UNION ALL
		SELECT * FROM churn_by_paperless_billing
		UNION ALL
		SELECT * FROM churn_by_payment_method
		UNION ALL 
		SELECT * FROM churn_by_tenure
		UNION ALL
		SELECT * FROM churn_by_monthly_charges
		UNION ALL 
		SELECT * FROM churn_by_online_security
		UNION ALL
		SELECT * FROM churn_by_streaming_movies
		UNION ALL
		SELECT * FROM churn_by_streaming_tv
	),
	factor_ranking AS
	(
		SELECT 
			factor_name,
			MAX(churn_rate) AS highest_churn_rate,
			MIN(churn_rate) AS Lowest_churn_rate,
			MAX(churn_rate)-MIN(churn_rate) AS churn_rate_spread
		FROM all_churn_factors
		GROUP BY factor_name
	)
	 SELECT * 
	FROM factor_ranking
	ORDER BY churn_rate_spread DESC	
	LIMIT 5;


               -- High Risk Customers	
WITH high_risk_customers AS (
    SELECT
        customer_id,
        "Churn",
        (
            CASE WHEN "tenure" BETWEEN 0 AND 12 THEN 1 ELSE 0 END +
            CASE WHEN payment_method = 'Electronic check' THEN 1 ELSE 0 END +
            CASE WHEN "Contract" = 'Month-to-month' THEN 1 ELSE 0 END +
            CASE WHEN internet_service = 'Fiber optic' THEN 1 ELSE 0 END +
            CASE WHEN online_security = 'No' THEN 1 ELSE 0 END
        ) AS risk_score
    FROM customer_churn
)
SELECT
    COUNT(*) AS high_risk_customers
FROM high_risk_customers
WHERE risk_score > 2;


-- 179.	Which customer segment should the business prioritize for retention?

	WITH 
		retention_by_gender AS
		(
			SELECT
				'Gender' AS factor_name,
				"gender"::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY "gender"
			
		),
		retention_by_senior_citizen AS 
		(
			SELECT
				'Senior Citizen' AS factor_name,
				senior_citizen::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY senior_citizen
		),
		retention_by_partner AS 
		(
			SELECT
				'Partner' AS factor_name,
				"Partner"::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY "Partner"
		),
		retention_by_dependents AS 
		(
			SELECT 
				'Dependents' AS factor_name,
				"Dependents"::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY "Dependents"
		),
		retention_by_tenure AS
		(
			SELECT 
				'Tenure' AS factor_name,
				CASE
					WHEN "tenure" BETWEEN 0 AND 12 THEN 'Low'
					WHEN "tenure" BETWEEN 13 AND 36 THEN 'Medium'
					WHEN "tenure" > 36 THEN 'High'
				END AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY factor_value
		),
		retention_by_phone_service AS
		(
			SELECT 
				'Phone Service' AS factor_name,
				"phone_service"::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY phone_service
		),
		retention_by_multiple_lines AS
		(
			SELECT 
				'Multiple Lines' AS factor_name,
				multiple_lines::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY multiple_lines
		),
		retention_by_internet_service AS 
		(
			SELECT 
				'Internet Service' AS factor_name,
				internet_service::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY internet_service
		),
		retention_by_online_security AS 
		(
			SELECT 
				'Online Security' AS factor_name,
				online_security::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY online_security
		),
		retention_by_online_backup AS 
		(
			SELECT 
				'Online Backup' AS factor_name,
				online_backup::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY online_backup
		),
		retention_by_device_protection AS 
		(
			SELECT 
				'Device Protection ' AS factor_name,
				device_protection::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY device_protection
		),
		retention_by_tech_support AS 
		(
			SELECT 
				'Tech Support ' AS factor_name,
				tech_support::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY tech_support
		),
		retention_by_streaming_tv AS 
		(
			SELECT 
				'Streaming Tv ' AS factor_name,
				streaming_tv::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY streaming_tv
		),
		retention_by_streaming_movies AS 
		(
			SELECT 
				'Streaming Movies ' AS factor_name,
				streaming_movies::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY streaming_movies
		),
		retention_by_contract AS 
		(
			SELECT 
				'Contract' AS factor_name,
				"Contract"::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY "Contract"
		),
		retention_by_paperless_billing AS 
		(
			SELECT 
				'Paperless Billing ' AS factor_name,
				paperless_billing::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY paperless_billing
		),
		retention_by_payment_method AS 
		(
			SELECT 
				'Payment Method' AS factor_name,
				payment_method::text AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY payment_method
		),
		retention_by_monthly_charges AS
		(
			SELECT 
				'Monthly Charges' AS factor_name,
				CASE
					WHEN monthly_charges <=40 THEN 'Low'
					WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
					WHEN monthly_charges >80 THEN 'High'
				END AS factor_value,
				COUNT(*) AS total_customers,
				COUNT(*) FILTER (WHERE "Churn"='No') AS retained_customers,
				ROUND(
					COUNT(*) FILTER (WHERE "Churn"='No')*100.0/COUNT(*),2
				) AS retention_rate
			FROM customer_churn
			GROUP BY factor_value
		)
		SELECT * FROM retention_by_gender
		UNION ALL
		SELECT * FROM retention_by_senior_citizen
		UNION ALL
		SELECT * FROM retention_by_partner
		UNION ALL
		SELECT * FROM retention_by_dependents
		UNION ALL
		SELECT * FROM retention_by_phone_service
		UNION ALL
		SELECT * FROM retention_by_multiple_lines
		UNION ALL
		SELECT * FROM retention_by_internet_service
		UNION ALL
		SELECT * FROM retention_by_online_backup
		UNION ALL
		SELECT * FROM retention_by_device_protection
		UNION ALL
		SELECT * FROM retention_by_tech_support
		UNION ALL
		SELECT * FROM retention_by_contract
		UNION ALL
		SELECT * FROM retention_by_paperless_billing
		UNION ALL
		SELECT * FROM retention_by_payment_method
		UNION ALL 
		SELECT * FROM retention_by_tenure
		UNION ALL
		SELECT * FROM retention_by_monthly_charges
		UNION ALL 
		SELECT * FROM retention_by_online_security
		UNION ALL
		SELECT * FROM retention_by_streaming_movies
		UNION ALL
		SELECT * FROM retention_by_streaming_tv
		ORDER BY retention_rate ASC
		LIMIT 5;
		
		

		
-- 180.	Which customer segment has the greatest potential churn risk?
WITH 
	churn_by_gender AS 
	(
		SELECT 
			'Gender' AS factor_name,
			"gender"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "gender"
	),
	churn_by_senior_citizen AS 
	(
		SELECT 
			'Senior Citizen' AS factor_name, 
			senior_citizen::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY senior_citizen
	),
	churn_by_partner AS 
	(
		SELECT 
			'Partner' AS factor_name,
			"Partner"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Partner"
	),
	churn_by_dependents AS 
	(
		SELECT 
			'Dependents' AS factor_name,
			"Dependents"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Dependents"
	),
	churn_by_phone_service AS 
	(
		SELECT 
			'Phone Service' AS factor_name,
			phone_service::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY phone_service
	),
	churn_by_multiple_lines AS 
	(
		SELECT 
			'Multiple Lines' AS factor_name,
			multiple_lines::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY multiple_lines
	),
	churn_by_internet_service AS 
	(
		SELECT 
			'Internet Service' AS factor_name,
			internet_service::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY internet_service
	),
	
	churn_by_online_security AS 
	(
		SELECT 
			'Online Security' AS factor_name,
			online_security::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY online_security
	),
	churn_by_online_backup AS 
	(
		SELECT 
			'Online Backup' AS factor_name,
			online_backup::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY online_backup
	),
	churn_by_device_protection AS 
	(
		SELECT 
			'Device Protection' AS factor_name,
			device_protection::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY device_protection
	),
	churn_by_tech_support AS 
	(
		SELECT 
			'Tech Support' AS factor_name,
			tech_support::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY tech_support
	),
	churn_by_streaming_tv AS 
	(
		SELECT 
			'Streaming Tv' AS factor_name,
			streaming_tv::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY streaming_tv
	),
	churn_by_streaming_movies AS 
	(
		SELECT 
			'Streaming Movies Service' AS factor_name,
			streaming_movies::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY streaming_movies
	),
	churn_by_contract AS 
	(
		SELECT 
			'Contract' AS factor_name,
			"Contract"::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY "Contract"
	),
	churn_by_paperless_billing AS 
	(
		SELECT 
			'Paperless Billing' AS factor_name,
			paperless_billing::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY paperless_billing
	),
	churn_by_payment_method AS 
	(
		SELECT 
			'Payment Method' AS factor_name,
			payment_method::text AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes') *100.0/COUNT(*),2
			) AS churn_rate
		FROM customer_churn
		GROUP BY payment_method
	),
	churn_by_tenure AS
	(
		SELECT
			'Tenure Segment' AS factor_name,
			CASE
				WHEN "tenure" BETWEEN 0 AND 12 THEN 'Low'
				WHEN "tenure" BETWEEN 13 AND 36 THEN 'Medium'
				WHEN "tenure">36 THEN 'High'
			END AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND(
					COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2
				) AS churn_rate
		FROM customer_churn
		GROUP BY 2
			
	),
	churn_by_monthly_charges AS 
	(
		SELECT 
			'Monthly Charges Segment' AS factor_name,
			CASE
				WHEN monthly_charges<=40 THEN 'Low'
				WHEN monthly_charges BETWEEN 40.01 AND 80 THEN 'Medium'
				WHEN monthly_charges >80 THEN 'High'
			END AS factor_value,
			COUNT(*) AS total_customers,
			COUNT(*) FILTER (WHERE "Churn"='Yes') AS churned_customers,
			ROUND ( 
					COUNT(*) FILTER (WHERE "Churn"='Yes')*100.0/COUNT(*),2
				) AS churn_rate
		FROM customer_churn
		GROUP BY 2
	)
		SELECT 
			factor_name,
			factor_value,
			total_customers,
			churned_customers,
			churn_rate
		FROM (

		
				
		SELECT * FROM churn_by_gender
		UNION ALL
		SELECT * FROM churn_by_senior_citizen
		UNION ALL
		SELECT * FROM churn_by_partner
		UNION ALL
		SELECT * FROM churn_by_dependents
		UNION ALL
		SELECT * FROM churn_by_phone_service
		UNION ALL
		SELECT * FROM churn_by_multiple_lines
		UNION ALL
		SELECT * FROM churn_by_internet_service
		UNION ALL
		SELECT * FROM churn_by_online_backup
		UNION ALL
		SELECT * FROM churn_by_device_protection
		UNION ALL
		SELECT * FROM churn_by_tech_support
		UNION ALL
		SELECT * FROM churn_by_contract
		UNION ALL
		SELECT * FROM churn_by_paperless_billing
		UNION ALL
		SELECT * FROM churn_by_payment_method
		UNION ALL 
		SELECT * FROM churn_by_tenure
		UNION ALL
		SELECT * FROM churn_by_monthly_charges
		UNION ALL 
		SELECT * FROM churn_by_online_security
		UNION ALL
		SELECT * FROM churn_by_streaming_movies
		UNION ALL
		SELECT * FROM churn_by_streaming_tv
	) AS all_churn_segment
		ORDER BY churn_rate DESC
		;
	

SELECT 
	ROUND(COUNT(*) FILTER (WHERE "Churn"= 'No')*100.0/COUNT(*),2) AS retentio_rate_by_tenure,
	CASE
		WHEN "tenure" <=12 THEN 'Low'
		WHEN "tenure" BETWEEN 13 AND 36 THEN 'Medium'
		WHEN "tenure" >36 THEN 'High'
	END AS tenure_segment
FROM customer_churn
GROUP BY  tenure_segment
ORDER BY 1 DESC;

-- Retention By gender
SELECT 
	"gender",
	ROUND(COUNT(*) FILTER (WHERE "Churn"= 'No')*100.0/COUNT(*),2) AS retentio_rate_by_gender
FROM customer_churn
GROUP BY "gender"
ORDER BY 1 DESC;
-- 181.	What are the strongest business insights that can be derived from the churn analysis?
/*
The churn analysis shows that customer retention is strongly influenced by contract type,
tenure, monthly charges, internet service, and payment method. Customers with month-to-month contracts and 
shorter tenure show greater risk of leaving. Customers with higher monthly charges also tend to have higher churn,
suggesting that pricing and perceived value may affect retention.

The analysis also highlights certain service and payment-method segments with higher churn rates, 
which indicates that these customer groups should receive targeted retention efforts.

Key business insights:

Focus on new customers, especially those in their first 12 months.
Encourage month-to-month customers to move toward longer-term contracts.
Review the value proposition for high monthly-charge customers.
Investigate why certain internet-service and payment-method segments experience higher churn.
Use these characteristics to identify high-risk customers early and target them with retention campaigns.

Overall insight: The business should move from reactive churn management to proactive,
segment-based retention, focusing resources on customers who show multiple high-risk characteristics.

*/
-- 182.	What customer retention strategies should the business consider based on the SQL findings?

/* 
Based on the SQL churn analysis, the business should consider the following retention strategies:

Target new customers: Customers with shorter tenure have higher churn risk, so the business
should introduce stronger onboarding, regular follow-ups, and early-stage offers.
Promote long-term contracts: Encourage month-to-month customers to switch to one-year or
two-year contracts through discounts or loyalty benefits.
Address high monthly charges: Offer personalized plans, discounts, or additional benefits to customers with high monthly charges
to improve perceived value.
Focus on high-risk internet segments: Investigate customers with higher churn rates for specific internet services 
and improve service quality, support, or pricing where necessary.
Improve payment experience: For payment methods associated with higher churn, 
make payment processes easier and provide alternative payment options or incentives for reliable payment methods.
Use targeted retention campaigns: Combine multiple risk characteristics—such as short tenure, 
month-to-month contract, high monthly charges, and high-risk service/payment segments—to identify 
customers who need immediate attention.
Strengthen customer support: Customers without services such as Tech Support or Online Security can be 
evaluated for targeted service bundles that increase value and customer engagement.

Overall strategy: The business should prioritize proactive, segment-based retention rather than
treating all customers equally. Retention efforts should focus most heavily on customers showing multiple high-risk characteristics.

*/

                                  -- FINAL BUSINESS DELIVERABLE

                       -- After completing the above analysis, identify:

-- 1.	Top 5 churn drivers
/*
	The analysis identifies low-tenure customers (0–12 months) as the highest-risk group, with a churn rate of 47.44%,
	followed by Electronic check users (45.29%), 
	month-to-month contract customers (42.71%), Fiber optic customers (41.89%), 
	and customers without Online Security (41.77%).
*/
-- 2.	Highest-risk customer segment
/* 
	Highest-risk customer segment: Customers with 0–12 months of tenure are the highest-risk segment, with a 47.44% churn rate.
	This indicates that newly acquired customers require stronger onboarding and early-stage retention efforts.
*/
	-- 3.	Lowest-risk customer segment
/*	
	Lowest-risk customer segment: Customers with a two-year contract have the lowest churn rate at 2.83%, 
	making them the lowest-risk segment among the analyzed factors.
*/
-- 4.	Highest-risk contract type
/*
	Highest-risk contract type: Customers on month-to-month contracts have the highest churn rate at 42.71%, 
	indicating that customers without long-term commitments are significantly more likely to churn.
*/
-- 5.	Highest-risk internet service
/* 
	Highest-risk internet service: Customers using Fiber optic internet have the highest churn rate at 41.89%, 
	indicating that this segment requires closer attention for retention.
*/
-- 6.	Highest-risk payment method
/*
	Highest-risk payment method: Customers using Electronic check have the highest churn rate at 45.29%, 
	indicating that this customer group should be prioritized for retention efforts.
*/
-- 7.	Relationship between tenure and churn
/* 
	Churn is strongly related to customer tenure. Customers in their first 12 months have the highest churn rate at 47.44%, 
	while customers with more than 36 months of tenure have the lowest churn rate at 11.93%.
	This indicates that new customers are significantly more likely to churn than long-term customers.
*/
-- 8.	Relationship between MonthlyCharges and churn
/*
	Monthly charges have a positive relationship with churn. Customers paying higher monthly charges have a higher
	likelihood of churning. The High monthly-charge segment has the highest churn rate at 33.98%, 
	compared with 11.64% for the Low segment.
*/
-- 9.	Relationship between services and churn
/*
	Customers without additional services such as Online Security, Tech Support, Online Backup, 
	and Device Protection have significantly higher churn rates than customers subscribed to these services. 
	For example, churn is 41.77% among customers without Online Security compared with 14.61% among those with it, 
	while Tech Support shows a similar pattern (41.64% vs. 15.17%).
	This suggests that value-added support and protection services may play an important role in customer retention.
*/
-- 10.	Recommended customer retention strategies
/*
	Retention strategies should focus on the lowest-retention segments: Low-tenure customers (52.56%),
	Electronic Check users (54.71%), Month-to-month customers (57.29%), Fiber Optic customers (58.11%), 
	and customers without Online Security (58.23%). The business should strengthen onboarding, promote long-term contracts 
	and automatic payments,	address Fiber Optic service/value concerns, and offer bundled security services to 
	improve customer retention.
*/
-- 11.	Business impact of reducing churn
/*
	Reducing customer churn can significantly improve business performance by increasing customer retention, 
	protecting recurring revenue, and reducing the cost of acquiring replacement customers. Since 26.54% of customers in the dataset
	have churned, even a small reduction in churn could help the business retain a substantial number of customers. 
	Improving retention among high-risk segments such as low-tenure customers, month-to-month customers, and 
	Electronic Check users can increase customer lifetime value and contribute to more stable long-term revenue.
*/
-- 12.	Key KPIs to monitor in Power BI

