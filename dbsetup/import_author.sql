/*
This script was used to record the process of importing some data from the CSV file into the designed database schema.
Some SQL command were purely exploratory, where others perform that actual steps to import the data.
The former kind of commands will be commented out; the latter will not. All will have descriptinos in comment form.
*/



/* Lists authors whose listed names do not follow a "Firstname Lastname" format.
SELECT bookID, author
FROM temp_raw_data
WHERE author !~ '^[A-Za-z]+ [A-Za-z]+$';
*/

/* Lists authors whose listed names follow a "Prefix FirstName Lastname" format with all prefixes found with the previous command.
SELECT bookID, author
FROM temp_raw_data
WHERE author ~ '^((Mr.)|(Mrs.)|(Dr.)) [A-Za-z]+ [A-Za-z]+';
*/

/* Previews what stripping the prefixes from the author field would look like.
SELECT
    bookID,
    author,
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[2:], ' ')
FROM temp_raw_data
WHERE author ~ '^((Mr\.)|(Mrs\.)|(Dr\.)) [A-Za-z]+ [A-Za-z]+';
*/

/* Strips prefixes from the author field wherever present. */
UPDATE temp_raw_data
SET author = ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[2:], ' ')
WHERE author ~ '^((Mr\.)|(Mrs\.)|(Dr\.)) [A-Za-z]+ [A-Za-z]+';

/* Lists authors whose names still do not follow a "Firstname Lastname" format.
SELECT
    bookID,
    author,
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[1:2], ' ')
FROM temp_raw_data
WHERE author !~ '^[A-Za-z]+ [A-Za-z]+$';
*/

/* Removes suffixes from all authors whose names do not follow a "Firstname Lastname" format. */
UPDATE temp_raw_data
SET author = ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[1:2], ' ')
WHERE author !~ '^[A-Za-z]+ [A-Za-z]+$';

/* Previews separating the author names into distinct first name and last name columns.
SELECT DISTINCT 
    author,
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[1:1], ' ') AS first,
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[2:2], ' ') AS last
FROM temp_raw_data
LIMIT 30;
*/

/* Creates new authors table */
CREATE TABLE authors (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL
);

/* Inserts first and last names into new authors table */
INSERT INTO authors (first_name, last_name)
SELECT DISTINCT
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[1:1], ' ') AS first,
    ARRAY_TO_STRING((STRING_TO_ARRAY(author, ' '))[2:2], ' ') AS last
FROM temp_raw_data;