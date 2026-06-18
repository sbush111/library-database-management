/* Question One: Is the book "Million size country." currrently available anywhere in the library network? */

EXPLAIN ANALYZE
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

CREATE INDEX idx__books__title ON books(title);
CREATE INDEX idx__inventory__book_id ON inventory(book_id);
CREATE INDEX idx__checkouts__book_id ON checkouts(book_id);

EXPLAIN ANALYZE
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

DROP INDEX idx__books__title;
DROP INDEX idx__inventory__book_id;
DROP INDEX idx__checkouts__book_id;

-- 40% decrease in execution time (2.5 ms to 1.5 ms)