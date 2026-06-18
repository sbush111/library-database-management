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


/* Question Two: Which branch has the largest inventory of history books? */

SELECT br.name branch_name, SUM(count) as history_book_inventory
FROM inventory i
JOIN books bk ON bk.id = i.book_id
JOIN genres g ON g.id = bk.genre_id
JOIN branches br ON br.id = i.branch_id
WHERE g.name = 'History'
GROUP BY br.name
ORDER BY history_book_inventory DESC;

-- Branch 3 has the largest inventory, at 17 books.


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
