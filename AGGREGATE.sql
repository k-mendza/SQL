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
-- ********* LOGICAL FUNCTIONS *********
-- != not equal to 
SELECT title FROM books WHERE released_year != 2000;
-- NOT LIKE opposite of LIKE
SELECT title FROM books WHERE title NOT LIKE 'W%';
-- > GREATER THAN 
SELECT title FROM books WHERE released_year > 2000;
-- >= GREATER THAN OR EQUAL TO
SELECT title FROM books WHERE quantity >= 0;
-- < LESS THAN 
SELECT title FROM books WHERE released_year < 2010;
-- <= LESS THAN OR EQUAL TO
SELECT title FROM books WHERE released_year <=2000;
-- && LOGICAL AND chains together logical functions equivalent of AND
SELECT * FROM books WHERE author_lname='Eggers' && released_year > 2010;
-- || LOGICAL OR equivalent of OR connects two operators together
SELECT * FROM books WHERE author_lname="Eggers" || released_year > 2000;
-- BETWEEN picks up values in range
SELECT title FROM books WHERE released_year BETWEEN 2000 AND 2010;
-- NOT BETWEEN picks up all values outside of the specified range
SELECT title FROM books WHERE released_year NOT BETWEEN 2000 AND 2010;
-- IN provides set of values for WHERE clause
SELECT title, released_year FROM books WHERE released_year IN (2000, 1985, 2013);
-- NOT IN opposite of IN
SELECT title, released_year FROM books WHERE released_year NOT IN (1998, 2001, 2007);
-- CASE STATEMENTS allows for conditional decisionmaking
SELECT title, released_year
	CASE 
		WHEN released_year >= 2000 THEN 'condition1'
		ELSE 'condition2'
	END AS alias
FROM books;
-- ONE TO MANY RELATION
-- ONE SIDE TABLE
CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR (100),
	last_name VARCHAR(100),
	email VARCHAR(100)
);
-- MANY SIDE TABLE with reference to foreign primary key
CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
	amount DECIMAL(8,2),
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers.id
);
-- CROSS JOIN with WHERE clause
SELECT * FROM customers, orders
WHERE customers.id = customer_id;
-- this can be simplified to 
SELECT * 
FROM customers
JOIN orders
ON customers.id = orders.customer_id;
-- thanks to JOIN command
-- now to show the table with customer that spent the most on the top
SELECT
	first_name,
	last_name,
	order_date,
	SUM(amount) AS total_spent
FROM customers
JOIN orders ON customers.id = customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- LEFT JOIN EXAMPLE
SELECT
	first_name,
	last_name,
	order_date,
	IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT, JOIN orders ON customers.id = customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- MANY TO MANY RELATION 

CREATE TABLE series(
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100),
	released_year INT,
	genre VARCHAR(100)
);

CREATE TABLE reviewers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);
-- join table which is crusial for many to many
CREATE TABLE reviews(
	id INT AUTO_INCREMENT PRIMARY KEY,
	rating DECIMAL(2,1),
	reviewer_id INT FOREIGN KEY REFERENCES reviewers.id,
	series_id INT FOREIGN KEY REFERENCES series.id
);
	