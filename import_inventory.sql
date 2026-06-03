CREATE TABLE inventory (
    branch_id integer,
    book_id integer,
    count integer NOT NULL DEFAULT 0,
    CONSTRAINT pk_inventory
        PRIMARY KEY (branch_id, book_id),
    CONSTRAINT fk_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_book
        FOREIGN KEY (book_id)
        REFERENCES books(id)
        ON DELETE CASCADE
);



INSERT INTO inventory (branch_id, book_id, count)
SELECT branchid, bookid, COUNT(*)
FROM temp_raw_data
GROUP BY bookid, branchid;