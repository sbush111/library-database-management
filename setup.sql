CREATE TABLE temp_raw_data (
	BookID integer,
	Title text,
	Author text,
	Genre text,
	BranchID integer,
	BranchName text,
	BorrowerID integer,
	BorrowerName text,
	BorrowDate text,
	ReturnDate text
);

\copy temp_raw_data FROM 'dbsetup/city_library_data.csv' CSV HEADER;

\i dbsetup/import_author.sql
\i dbsetup/import_genre.sql
\i dbsetup/import_book.sql
\i dbsetup/import_branch.sql
\i dbsetup/import_inventory.sql
\i dbsetup/import_member.sql
\i dbsetup/import_checkout.sql

DROP TABLE temp_raw_data;