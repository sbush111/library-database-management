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

\copy temp_raw_data FROM 'city_library_data.csv' CSV HEADER;