/* ----- TASK 1 SQL Query ----- */

SELECT * 
FROM survey
LIMIT 10; 



/* ----- TASK 2 SQL Query ----- */

SELECT question, COUNT(user_id) AS 'responses'
FROM survey
GROUP BY question; 



/* ----- TASK 4 SQL Query ----- */ 

SELECT * 
FROM quiz
LIMIT 5; 

SELECT * 
FROM home_try_on
LIMIT 5;

SELECT * 
FROM purchase
LIMIT 5;



/* ----- TASK 5 SQL Query ----- */ 

WITH home_try_on_cte AS 
	(SELECT user_id, 
		CASE
		WHEN user_id IS NOT NULL THEN 'True'
		ELSE 'False'
		END AS is_home_try_on
	FROM home_try_on
	GROUP BY user_id 
	),

purchase_cte AS
	(SELECT user_id, 
		CASE 
		WHEN user_id IS NOT NULL THEN 'True'
 		ELSE 'False' 
   	END AS is_purchase
 	FROM purchase
 	GROUP BY user_id
 	)

SELECT hto_cte.user_id, 
	hto_cte.is_home_try_on, 
	hto.number_of_pairs, 
	p_cte.is_purchase
FROM home_try_on_cte hto_cte
LEFT JOIN home_try_on hto
ON hto_cte.user_id = hto.user_id
LEFT JOIN purchase_cte p_cte 
ON hto.user_id = p_cte.user_id
LIMIT 10;



/* ----- TASK 6 SQL Queries ----- */ 

SELECT purchase.model_name AS 'Model', 
	purchase.style AS 'Style', 
	COUNT(purchase.model_name) AS 'Pairs Purchased', 
	purchase.price AS 'Price', 
	(COUNT(purchase.model_name)*purchase.price) AS 'Revenue'
FROM purchase
GROUP BY 1
ORDER BY 4 DESC;

SELECT purchase.style AS 'Style', 
	COUNT(purchase.style) AS 'Models Purchased', 
	(COUNT(purchase.style)*purchase.price) AS 'Revenue'
FROM purchase
GROUP BY 1
ORDER BY 3; 

SELECT home_try_on.number_of_pairs AS 'Pairs Tried', 
	COUNT(DISTINCT home_try_on.user_id) AS 'Trial Customers Count', 
	COUNT(DISTINCT purchase.user_id) AS 'Paid Customers Count', 
	ROUND(1.0*COUNT(DISTINCT purchase.user_id)/COUNT(DISTINCT home_try_on.user_id), 2) AS 'Conversion Rate'
FROM home_try_on
LEFT JOIN purchase
ON home_try_on.user_id = purchase.user_id
GROUP BY 1;

