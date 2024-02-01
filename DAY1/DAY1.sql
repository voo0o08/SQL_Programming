show databases;

use sakila; #DB를 바꾸려면 use명령어 사용 

select now(); # now는 함수라 ()들어가야함 

create database testdb;
use testdb;

drop table if exists person; # person table이 있다면 삭제할 것 

create table person(
person_id smallint UNSIGNED,
fname varchar(20),
lname VARCHAR(20),
eye_color ENUM("BR", "BL", "GR"),
birth_data DATE,
street VARCHAR(30),
city VARCHAR(20),
state VARCHAR(20),
country VARCHAR(20),
postal_code VARCHAR(20),
constraint pk_person primary key (person_id)
);

desc person;

drop table if exists favorite_food; # person table이 있다면 삭제할 것 

create table favorite_food (
person_id smallint unsigned,
food VARCHAR(20),
constraint pk_favorite_food primary key (person_id, food),
constraint fk_fav_food_person_id foreign key (person_id) references person(person_id)
);

desc favorite_food;

# 2.5 테이블 수정 (ALTER)
set foreign_key_checks = 0; # 비활성화
alter table person modify person_id smallint unsigned auto_increment;
set foreign_key_checks = 1; # 다시 활성화

desc person ;

# 2.5 데이터 추가(INSERT INTO (col이름 .. ) VALUES (값1, 값2 ...))
insert into person (person_id, fname, lname, eye_color, birth_data)
values (null, "William", "Turner", "BR", "1972-05-27");

select * from person; # *은 전체 선택 / *말고 보고 싶은 col이름 작성해도 ㅇㅋ 

# where뒤에는 조건문 
select fname from person where fname='William';

# 데이터 추가 
insert into favorite_food (person_id, food)
values(1, "pizza"),(1, "cookie"),(1, "nachos");

select food from favorite_food
where person_id = 1
order by food;

insert into person 
(person_id, fname, lname, eye_color, birth_data,
street, city, state, country, postal_code)
VALUES(null, "Susan", "Smith", "BL", "1975-11-02", 
"23 Maplt St.", "Arlington", "VA", "USA", "20220");

select * from person;

# 데이터 수정(UPDATE)
update person 
set street = "1225 Tremon St.",
city = "Boston",
state = "MA",
country = "USA",
postal_code  = "02138"
where person_id = 1;

select * from person;

# 데이터 삭제 (DELETE FROM ~ WHERE ~ = ~;)
delete from person where person_id = 2;
select * from person;

# 2 수잔을 지우고 다시 생성하면 3 수잔으로 들어감 
insert into person 
(person_id, fname, lname, eye_color, birth_data,
street, city, state, country, postal_code)
VALUES(null, "Susan", "Smith", "BL", "1975-11-02", 
"23 Maplt St.", "Arlington", "VA", "USA", "20220");

insert into favorite_food (person_id, food) values (3, "lasagna");

select * from favorite_food;

# 2.6 오류 구문들 
update person set birth_date = "DEC-21-1980" where person_id = 1;
# 윗줄은 오류발생 날짜의 기본 형식은 YYYY-MM-DD
update person set birth_data = str_to_date("DEC-21-1980", '%b-%d-%Y') 
where person_id = 1;
select * from person;