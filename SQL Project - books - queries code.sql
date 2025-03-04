Create table books_details(
	Book_ID	smallint primary key, 
	Title	varchar(100),	
	Author	varchar(100),	
	Genre	varchar(50),	
	Published_Year	smallint,	
	Price	numeric(10,2),	
	Stock	smallint	
)

create table customer_details(
	Customer_ID	smallint primary key,
	Name	varchar(100),	
	Email	varchar(100),	
	Phone	varchar(15),	
	City	varchar(100),	
	Country	varchar(100)	
)
alter table books_details alter column book_id type serial;
drop table books_details;
select * from customer_details;


create table order_details(
	Order_ID serial  Primary Key,
	Customer_ID	int references customer_details(customer_id),
	Book_ID	int references books_details(book_id),	
	Order_Date	date,	
	Quantity int,	
	Total_Amount numeric(10,2)		
)

select * from books_details;
select * from customer_details;
select * from order_details;


--Query 1 - Retrieve all books in 'Fiction' genre
Select * from books_details where genre='Fiction' order by book_id;

--Query 2 - find books published after the year 1950
Select book_id, title, author, published_year from books_details where published_year > 1950 order by book_id;

--Query 3 -  List all customers from Canada
Select customer_id, name, country from customer_details 
where country='Canada';

--Query 4 - show orders placed in november 2023
Select order_id, customer_id, book_id, quantity, order_date from order_details
where order_date between '2024-11-01' and '2024-11-30';

--Query 5 - Retrieve the total stock of the books available
Select sum(stock) as total_books_in_Stock from books_details;

--Query 6 - find the details of the most expensive book
Select * from books_details order by price desc limit 1;

-- Query 7 - show all customers who ordered more than 1 quantity of a book
Select * from order_details where quantity>1 order by order_id;

--Query 8 - retrieve all orders where the total amount exceeds $20
Select order_id, customer_id, book_id, total_amount from order_details
where total_amount>20 order by total_amount;


--Query 9 -- list all the generes available in books table
Select distinct genre as book_genre from books_details;

--Query 10 - Find the book with the lowest_stock
select book_id, title, stock from books_details order by stock limit 1

--Query 11 - calculate the total revenue generated from all the orders
Select sum(total_amount) as revenue from order_details;


-- Advanced Queries
--Query 1 - find total books sold by each genre
Select b.genre, sum(o.quantity) as total_books_sold
from books_details b inner join order_details o
on b.book_id=o.book_id
group by b.genre;

--Query 2 - find the average price of books in the "Fantasy" genre

Select b.genre, avg(b.price) as avg_price
from books_details b where b.genre='Fantasy'
group by b.genre;

-- Query 3 - List customers who have placed at least two orders
Select c.name, o.quantity 
from customer_details c inner join order_details o 
on c.customer_id=o.customer_id where o.quantity>=2;

--Query 4 - find the most frequently ordered book

Select b.title, count(o.order_id) as order_count
from order_details o inner join books_details b
on b.book_id=o.book_id 
group by b.title
order by order_count desc limit 1;

--Query 5 - show the top 3 most expensive books of "Fantasy" genre
select b.title, b.price
from books_details b order by price desc
limit 3;

--Query 6 - Retrieve the total quantity of books sold by each other
Select b.author, sum(o.quantity)
from books_details b inner join order_details o on 
b.book_id=o.book_id
group by b.author;

--Query 7 - List the cities where customers who spent over $30 are located
Select c.city, o.total_amount
from customer_details c inner join order_details o 
on c.customer_id=o.customer_id 
where o.total_amount>30;

--Query 8 - Find the customers who spent the most on orders
Select c.name, sum(o.total_amount) as total_amount_spent
from customer_details c inner join order_details o 
on c.customer_id=o.customer_id 
group by c.name
order by total_amount_spent desc limit 5;

--Query 9 - Calculate the stock remaining after fulfilling all orders
Select b.book_id, b.title, b.stock, Coalesce(Sum(o.quantity),0) as order_quantity, b.stock-
coalesce(sum(o.quantity), 0) as Remaining_Quantity 
from books_details b left join order_details o on b.book_id=o.book_id
group by b.book_id order by b.book_id;

Select * from books
