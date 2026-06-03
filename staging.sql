CREATE DATABASE city_library;

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