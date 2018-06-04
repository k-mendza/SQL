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
-- find the year of first release
SELECT author_fname, author_lname, MIN(released_year)
FROM books
GROUP BY author_lname,author_fname;
-- find length of the longest book of each author
SELECT author_fname,author_lname, MAX(pages)
FROM books
GROUP BY author_lname, author_fname;
-- find length of the longest book of each author with aliases
SELECT 
	CONCAT(author_fname, ' ',author_lname) AS author,
	MAX(pages) AS book_length
FROM books
GROUP BY author_lname, author_fname;
-- find number of pages written by each author
SELECT author_fname, author_lname, SUM(pages)
FROM books
GROUP BY author_lname, author_fname;
-- find average release year
SELECT AVG(released_year) FROM books;
-- find average number of pages for each author
SELECT author_fname, author_lname, AVG(pages)
FROM books
GROUP BY author_lname, author_fname;
-- find number of books in db
SELECT COUNT(*) FROM books;
-- how many books were released each year
SELECT released_year,COUNT(released_year)
FROM books
GROUP BY released_year;
-- calculate the total number of books in stock
SELECT SUM(quantity) FROM books;
-- find average release year for each author
SELECT author_fname, author_lname, AVG(released_year)
FROM books;
GROUP BY author_lname,author_fname;
-- find full name of author who wrote the longest book
SELECT 
	CONCAT(author_fname, ' ' ,author_lname) AS fullname,
	MAX(pages)
FROM
	books
GROUP BY
	author_lname,author_fname;
-- find year number of books released in this year and avg number of pages
SELECT
	released_year AS year,
	COUNT(*) AS "# books",
	AVG(pages) AS "avg pages"
FROM 
	books
GROUP BY
	released_year
ORDER BY
	released_year;