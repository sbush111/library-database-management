--How many books are currently checked out?

SELECT 
    (SELECT COUNT(*) - COUNT(return_date)
        FROM checkouts
        ) AS checked_out,
    (SELECT SUM(count)
        FROM inventory
        ) AS total;

--Which user currently has the most books checked out?

SELECT 
    u.id, 
    CONCAT(u.first_name, ' ', u.last_name) AS customer, 
    COUNT(*) AS currently_borrowing, 
    ARRAY_TO_STRING(ARRAY_AGG(b.title), ', ') AS books
FROM customers u
JOIN checkouts k
ON u.id = k.customer_id
JOIN books b
ON k.book_id = b.id
WHERE return_date IS NULL
GROUP BY u.id, u.first_name, u.last_name
ORDER BY currently_borrowing DESC
LIMIT 1;

--Which branch has the smallest percentage of their books checked out?

WITH inventory_per_branch AS (
    SELECT branch_id, COUNT(*) AS count
    FROM inventory
    GROUP BY branch_id
),

checked_out_per_branch AS (
    SELECT branch_id, COUNT(*) AS count
    FROM checkouts
    WHERE return_date IS NULL
    GROUP BY branch_id
)

SELECT
    b.id,
    b.name AS branch,
    k.count AS checked_out,
    i.count AS total,
    ROUND(100.0 * k.count / i.count, 2) AS percentage
FROM inventory_per_branch i
JOIN checked_out_per_branch k
ON i.branch_id = k.branch_id
JOIN branches b
ON i.branch_id = b.id
ORDER BY percentage;
