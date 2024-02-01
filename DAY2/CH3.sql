use sakila;

select * from `language` l 

# select절
select language_id,
 'COMMON' language_usage,
 language_id *	3.14	lang_pi_value,
 upper(name)	language_name
 from language;

# 중복제거 / 판다스에서 unique 같은 
select distinct actor_id from film_actor order by actor_id ;

select concat(cust.last_name, ",", cust.first_name) full_name
from(
select first_name, last_name, email
from customer
where first_name = "JESSIE"
) as cust;

# 임시 테이블 => 데이터 베이스 세션이 닫힐 때 사라짐
# J로 시작하는 데이터 
create temporary table actors_j
(
actor_id smallint(5),
first_name varchar(45),
last_name varchar(45)
);

desc actor_j;

insert into actors_j 
select actor_id, first_name, last_name
from actor	
where last_name like 'J%';

select * from actors_j;

# 임시 테이블은 안뜸 
show tables;

# 가상 테이블(View)
create view cust_vw as 
select customer_id, first_name, last_name, active
from customer;

select * from cust_vw;

select customer.first_name, customer.last_name,
	time(rental.rental_date) as rental_time
from customer inner join rental 
	on customer.customer_id = rental.customer_id 
where date(rental.rental_date) = "2005-06-14";

select c.first_name, c.last_name, time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = "2005-06-14";

select title
from film 
where rating="G" and rental_duration >= 7;

# and / or 사용
select title, rating, rental_duration
from film
where (rating = "G" and rental_duration >= 7)
	or (rating="PG-13" and rental_duration < 4);
	

# Group by 절과 having 절 
select c.first_name, c.last_name, count(*)
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
group by c.first_name , c.last_name
having count(*) >= 40;
# count(*): 그룹화 한 전체 행의 수
# having은 필수는 아님 

select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = "2005-06-14"
order by c.last_name,  c.first_name asc;
# asc는 생략이 가능하고 / desc는 입력해줘야함 

# 실습 3-1
select actor_id,  last_name, first_name
from actor
order by last_name, first_name;

# 실습 3-2
select actor_id,	first_name,	last_name
from actor
where last_name = "WILLIAMS" or last_name = "DAVIS";

# 실습 3-3
select distinct customer_id, rental_date
 from rental
 where date(rental_date)	=	'2005-07-05';
 
# 실습 3-4
select store_id, email, rental_date, return_date
from customer as c inner join rental as r 
	on c.customer_id = r.customer_id 
where date(rental_date) = "2005-06-14"
order by return_date desc;


