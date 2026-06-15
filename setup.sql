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

\copy temp_raw_data FROM 'setup/city_library_data.csv' CSV HEADER;

\i setup/import_author.sql
\i setup/import_genre.sql
\i setup/import_book.sql
\i setup/import_branch.sql
\i setup/import_inventory.sql
\i setup/import_member.sql
\i setup/import_checkout.sql

DROP TABLE temp_raw_data;