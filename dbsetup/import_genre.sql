/*
This script was used to record the process of importing some data from the CSV file into the designed database schema.
Some SQL command were purely exploratory, where others perform that actual steps to import the data.
The former kind of commands will be commented out; the latter will not. All will have descriptinos in comment form.
*/

/* List all unique genres in the database.
SELECT DISTINCT genre
FROM temp_raw_data;
*/

/* Create a genres table. */
CREATE TABLE genres (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text NOT NULL
);

/* Import the genres from the temp table into the genres table. */
INSERT INTO genres (name)
SELECT DISTINCT genre
FROM temp_raw_data;