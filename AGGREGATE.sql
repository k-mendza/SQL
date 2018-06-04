-- AGGREGATE FUNCTIONS NOTES:
SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
-- selection counting distinct authors in the means of fname and lname
SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;
-- count all books with title containing 'the'
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';
-- count all books of each author
SELECT 
	author_fname,author_lname, COUNT(*) 
FROM 
	books
GROUP BY 
	author_lname,author_fname;
-- count all books from the same year with ascending order of the released year
SELECT
	released_year, COUNT(*)
FROM
	books
GROUP BY
	released_year
ORDER BY
	released_year;
-- find minimal year of release
SELECT
	MIN(released_year)
FROM
	books;
-- find minimal number of pages
SELECT
	MIN(pages)
FROM
	books;
-- find maximal number of pages
SELECT
	MAX(pages)
FROM
	books
-- find the title of the book with maximal number of pages
SELECT
	title,pages
FROM
	books
WHERE
	pages=(
		SELECT
			MAX(pages)
		FROM
			books);