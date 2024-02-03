# 내부 조인 예제 
select c.first_name, c.last_name, a.address
from customer as c inner join address as a
on c.address_id = a.address_id;

# SQL92 문법 표기
select c.first_name,	c.last_name,	a.address,	a.postal_code
 from customer	as c	join address	as a
 on c.address_id =	a.address_id
 where a.postal_code =	52137;
 
select c.first_name,	c.last_name,	a.address
 from customer	as c	join address	as a
 where c.address_id =	a.address_id and a.postal_code =	52137;
 
# ==============================================
select c.first_name, c.last_name, ct.city, a.address, a.district, a.postal_code
from customer as c	
	inner join address as a
 	on c.address_id =	a.address_id
 	inner join city as ct
 	on a.city_id =	ct.city_id;

# ~. 안해도 에러없이 실행 가능 아직 안복잡해서...?
select first_name, last_name, city, address, district, postal_code
from customer as c	
	inner join address as a
 	on c.address_id =	a.address_id
 	inner join city as ct
 	on a.city_id =	ct.city_id;
 	
# ===================서브 쿼리 사용=======================
 select address_id, address, city, district
 from address as a
 	inner join city as ct
 	on a.city_id = ct.city_id 
 where a.district  = "California";

select c.first_name,	c.last_name,	addr.address,	addr.city,	addr.district
 from customer	as c
 inner join
 (select address_id, address, city, district
 	from address as a
 	inner join city as ct
 	on a.city_id = ct.city_id 
 where a.district  = "California"
 ) as addr
 on c.address_id =	addr.address_id;

 # ==================== 테이블 재사용
# 따로따로 출연
select f.title, first_name, last_name
 from film as f
 inner join film_actor as fa
 on f.film_id =	fa.film_id
 inner join actor a
 on fa.actor_id =	a.actor_id
 where ((a.first_name =	'CATE' and a.last_name =	'MCQUEEN')
 or (a.first_name =	'CUBA' and a.last_name =	'BIRCH'));
 

# ============ 두 배우가 같이 출연한 영화만 검색

select f.title
 from film	as f
 inner join film_actor as fa1
 on f.film_id =	fa1.film_id
 inner join actor	a1	
#	film,	film_actor,	actor	내부	조인	#1
 on fa1.actor_id	=	a1.actor_id
 inner join film_actor as fa2
 on f.film_id =	fa2.film_id
 inner join actor	a2	
# film,	film_actor,	actor	내부	조인	#2
 on fa2.actor_id	=	a2.actor_id
 where (a1.first_name	=	'CATE' and a1.last_name	=	'MCQUEEN')	
and (a2.first_name	=	'CUBA' and a2.last_name	=	'BIRCH');


# test 
select *
 from film	as f
 inner join film_actor as fa1
 on f.film_id =	fa1.film_id
 inner join actor	a1	
#	film,	film_actor,	actor	내부	조인	#1
 on fa1.actor_id	=	a1.actor_id
