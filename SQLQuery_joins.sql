select * from jobs
select * from employee
select * from titleauthor
select * from authors
select * from publishers
select * from titles
select * from stores
select * from sales
select * from discounts


--1)Display each publisher will all its employees (name, last name, first name, and title).
select p.pub_name as publisher,e.lname as last_name, e.fname as First_name, j.job_desc as title 
from publishers p join employee e on p.pub_id=e.pub_id
				join jobs j on e.job_id=j.job_id  

				order by p.pub_name


--2)  Display the title of each book, with the name(s), city, and state of the stores where the book was sold.
select t.title as Tittle, s.stor_name as Store,s.city as City, s.state as State
from titles t join sales sa on t.title_id=sa.title_id
				join stores s on sa.stor_id= s.stor_id

				order by t.title


--3) Display all authors (first and last name concatenated) with the title of the books they authored sorted by first and last name.
select CONCAT(a.au_fname,' ' ,a.au_lname) as Author, t.title as Tittle 
from authors a join titleauthor ta on a.au_id=ta.au_id
				join titles t on ta.title_id=t.title_id

				order by Author


--4) Display the first and last name of each author who has written at least one book, as well as the amounth of books they have written.	
	select  a.au_fname, a.au_lname ,count(ta.au_id) as Number
	from authors a join titleauthor ta on a.au_id=ta.au_id
	group by a.au_fname, a.au_lname
	


				
	--5) Display the title of each book, with the publishers name, and the author's last name concatenated with the first letter of their last name, ordered in descending alphabetic order.	

	select t.title as Title, p.pub_name as Publisher, CONCAT(a.au_fname ,' ', SUBSTRING(a.au_lname,1,1)) as Author
	from titles t join publishers p on t.pub_id=p.pub_id
				join titleauthor ta on t.title_id=ta.title_id
				join authors a on a.au_id= ta.au_id

				order by t.title


--6) For each store in the state of Washington, display the name of the store, the city and state it is located in, and lastly the title and amount of each book they have sold. Sort results by book titles in descending order. 


		select s.stor_name as 'Last Name du Store', s.city as City , s.state as State, t.title as Tittle, sa.qty as 'Livres vendus'
		from stores s join sales sa on s.stor_id=sa.stor_id
						join titles t on sa.title_id= t.title_id


		where s.state='WA'

		order by sa.qty

		--7) Display the names of all publishers who have paid an advance greater than $1000 for a book, along with the books id of the book the advance was paid for.
			
			select p.pub_name as Publishers, t.title_id as 'Tittle Id' 
			from titles t join publishers p on t.pub_id=p.pub_id

			where t.advance > 1000

		
			--8) Display the names of publishers who have published books in the “business” or “psychology” categories. 

				select distinct p.pub_name as Publishers,  case when t.type = 'business' then 'Business' 
														when t.type = 'psychology' then 'Psychology'
													
														
				end as Types 
					from titles t join publishers p on t.pub_id=p.pub_id
					where t.type='business' or t.type='psychology'
				


--9) Display the titles of books that have been written by the author Albert Ringer.	select  t.title as Tittle, a.au_fname,a.au_lname  
	from authors a join titleauthor ta on a.au_id=ta.au_id
	join titles t on ta.title_id=t.title_id

	where a.au_lname='Ringer' and a.au_fname='Albert'


	--10) Display the name of each publisher with the number of employees they employ. 

			select p.pub_name as Publishers, count(e.pub_id) as 'Number Of Emplyoees' 
			from employee e join publishers p on e.pub_id=p.pub_id

			group by p.pub_name



	--11) Display the name of each publisher with the number of books they have published, the minimum price of their books, the maximum price of their books, the sum and the average of their prices.

	select p.pub_name as Publishers_Name,count(t.pub_id) as 'Pub Books', min(t.price) as 'Minimum Price'
	, max(t.price) as Maximum ,sum(t.price) as Sum , avg(t.price) as Average
	from publishers p join titles t on p.pub_id=t.pub_id
						

	group by p.pub_name


	--12) Display the name of each Store with the number of different books sold in each store.

	select st.stor_name as 'Store Name ', count(sa.title_id) as 'Number Of Diffrent Books'
	from sales sa join stores st on st.stor_id=sa.stor_id

	group by st.stor_name

	--13) Display the title books that have sold fewer than 25 copies, along with the quantity they have sold. 

	select distinct t.title as 'Title', sum(sa.qty) as 'Quantity Sold'
	from titles t join sales sa on t.title_id= sa.title_id



	group by t.title
		having sum(sa.qty) <25


		--14) Display the largest advance payment made by each publisher (along with the publisher's name).		select distinct p.pub_name as 'Publishers', max(t.advance) as 'Largest_Payment'			from publishers p join titles t on p.pub_id=t.pub_id					group by p.pub_name						--15) Display the name of authors who have not written a book.			select CONCAT(a.au_lname ,' ', a.au_fname) as 'Author Name '			from authors a 			where a.contract <=0			order by a.au_lname						--16) Display the number of books sold for each book title. 	select  t.title as 'Title', sum(sa.qty) as 'Number of books sold'
	from titles t join sales sa on t.title_id= sa.title_id

	group by t.title


	--17)Display the number of books sold for each store. 

		select st.stor_name as Store, sum(sa.qty) as 'Number of books sold'
		from stores st join sales sa on sa.stor_id=st.stor_id

		group by st.stor_name

		order by avg(sa.qty)

