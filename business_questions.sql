/* Question One: Is the book "Million size country." currrently available anywhere in the library network? */

WITH total AS (
    SELECT count as total_copies
    FROM inventory i
    JOIN books b ON i.book_id = b.id
    WHERE title = 'Million size country.'
),
available AS (
    SELECT COUNT(*) as available_copies
    FROM checkouts c
    JOIN books b on c.book_id = b.id
    WHERE b.title = 'Million size country.' AND return_date IS NOT NULL
)
SELECT a.available_copies, t.total_copies
FROM total t
CROSS JOIN available a;

-- No. There is one copy and it is currently checked out.


/* Question Two: Which user currently has the most books checked out? */

SELECT 
    m.id, 
    CONCAT(m.first_name, ' ', m.last_name) AS member, 
    COUNT(*) AS currently_borrowing, 
    ARRAY_TO_STRING(ARRAY_AGG(b.title), ', ') AS books
FROM members m
JOIN checkouts k
ON m.id = k.member_id
JOIN books b
ON k.book_id = b.id
WHERE return_date IS NULL
GROUP BY m.id, m.first_name, m.last_name
ORDER BY currently_borrowing DESC
LIMIT 1;

-- Anna Robinson currently has two books checked out.


/* Question Three: Which branch has the smallest percentage of their books checked out? */

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
