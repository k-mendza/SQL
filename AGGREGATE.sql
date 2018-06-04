-- AGGREGATE FUNCTIONS NOTES:
SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
-- selection counting distinct authors in the means of fname and lname
SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;
-- count all books with title containing 'the'
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';
