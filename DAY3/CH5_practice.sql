use sqlclass_db;

# 테이블 생성
create table customer
	(customer_id smallint unsigned,
	first_name varchar(20),
	last_name varchar(20),
	birth_date date,
	spouse_id smallint unsigned,
	constraint primary key (customer_id)
	);
	
desc customer;      

insert into customer
values
 (1,	'John',	'Mayer',	'1983-05-12',	2),
 (2,	'Mary',	'Mayer',	'1990-07-30',	1),
 (3,	'Lisa',	'Ross',	'1989-04-15',	5),
 (4,	'Anna',	'Timothy',	'1988-12-26',	6),
 (5,	'Tim',	'Ross',	'1957-08-15',	3),
 (6,	'Steve',	'Donell',	'1967-07-09',	4);
 
insert into customer	(customer_id, first_name, last_name, birth_date)
values(7, 'Donna', 'Trapp',	'1978-06-23');