use sakila;

select * from `language` l 

select customer_id,	rental_date
 from rental
 where rental_date <=	'2005-05-25';
/*
 25일과 같으면 이지만, 막상 25일은 출력이 안됨
 -> date없이 쓰면 2005 05-25 00:00:00이 기준이 돼서 그럼 
 */

 select customer_id,	rental_date
 from rental
 where rental_date <=	'2005-06-16'
 and rental_date >=	'2005-06-14';
 /*
마찬가지로 16일은 출력이 안됨 
*/

select last_name, first_name
from customer 
where last_name between "FA" and "FRB";

# 멤버십 조건
select title, rating 
from film f 
where rating in ("G", "PG");

# ===========================================================
select title, rating 
from film
where rating in (select rating from film where title like "%PET%");

# sub 쿼리 
select rating from film where title like "%PET%";
select title,	rating	from film	where title	like '%PET%';

# not in 사용 
select title,	rating
 from film
 where rating	not in ('PG-13',	'R',	'NC-17');
 
# 문자열 부분 가져오기
# left(문자열, n)
select left("abcdefg", 3);
# mid(문자열, 시작 위치, n)
select  mid("abcdefg"2, 3);
# right(문자열, n)
select right("abcdefg", 2);

select last_name,	first_name
 from customer
 where last_name like '_A_T%S'
 

# =========== 밑에 두개는 일치한 표현 ===========
select last_name,	first_name
 from customer
 where last_name like 'Q%' or last_name like 'Y%';
 
# ^:시작 
# []:범위
# REGEXP : Regular Expression -> 정규표현식
select last_name, first_name
from customer 
where last_name regexp "^[QY]";
# =========== =========== ===========

# 4.4 Null
select rental_id, customer_id, return_date
from rental
where return_date is null;

select rental_id,	customer_id,	return_date
 from rental
 where return_date is null
 or return_date not between '2005-05-01' and '2005-09-01';
 
# + select에서도 내장함수 사용 가능 
select payment_id,	customer_id,	amount,	date(payment_date)	as payment_date
from payment
where (payment_id between 101 and 120);